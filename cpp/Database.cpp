#include "Database.h"

Database::Database(QObject *parent)
    : QObject{parent}
    , m_oppened(false)
{
#if DELETE_DB_AT_START
    D("removed database file at start with status: " + BOOL_TO_STR(QFile::remove(DATABASE_FILE)));
#endif
    QObject::connect(WeekEvents::getInstance(), &WeekEvents::currentWeekChanged, this, &Database::readWeekEvents);
    QObject::connect(this, &Database::contentOfDatabaseChanged, this, &Database::readWeekEvents);
}

Database::~Database()
{

}

Database *const Database::getInstance() noexcept
{
    static Database i;
    return &i;
}

void Database::initialize()
{
    if(!this->openDB())
    {
        E("Unable to open database");
        emit this->initializeFailed();
        return;
    }

    if(!this->createTableEvents())
    {
        E("Unable to open create table");
        emit this->initializeFailed();
        return;
    }

    this->readWeekEvents();

    emit this->initialized();
}

const QString &Database::getLastError() const
{
    return this->m_lastError;
}

bool Database::openDB()
{
    if(m_oppened)
    {
        W("Database already oppened!")
        m_lastError = "Database already oppened!";
        return false;
    }

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", MAIN_DB_CONNECTION);
    db.setDatabaseName(DATABASE_FILE);

    if(!db.open())
    {
        E("Failed while oppening database: " + db.lastError().text())
        m_lastError = "Failed while oppening database: " + db.lastError().text();
        return false;
    }

    m_oppened = true;
    I("Database oppened");
    return true;
}

void Database::closeDB()
{
    if(!m_oppened)
    {
        W("Database isn't open, can't close it!")
        m_lastError = "Database isn't open, can't close it!";
        return;
    }

    if(!QSqlDatabase::contains( MAIN_DB_CONNECTION ))
    {
        W("Main database connection don't exist, can't close database!")
        m_lastError = "Main database connection don't exist, can't close database!";
        return;
    }

    QSqlDatabase::database( MAIN_DB_CONNECTION ).close();
    QSqlDatabase::removeDatabase( MAIN_DB_CONNECTION );

    m_oppened = false;
    I("Database closed");
}

bool Database::resetDB()
{
    const bool dbWasOpen = m_oppened;
    if(m_oppened)
        this->closeDB();

    /// remove db file
    if(QFile::exists(DATABASE_FILE))
    {
        if(!QFile::remove(DATABASE_FILE))
        {
            E("Unable to remove the database file!")
            m_lastError = "Unable to remove the database file!";
            return false;
        }
        I("Database file removed");
    }

    return dbWasOpen ? this->openDB() : true;
}

bool Database::createTableEvents()
{
    QSqlDatabase db = QSqlDatabase::database( MAIN_DB_CONNECTION );
    QSqlQuery query(db);

    if(this->tableEventsExist())
    {
        I("Table 'events' already exist");
        return true;
    }

    QString queryText =
        "CREATE TABLE IF NOT EXISTS events("
        "id             INTEGER     PRIMARY KEY,"
        "title          TEXT        NOT NULL,"
        "description    TEXT        NOT NULL,"
        "path           TEXT        NOT NULL,"
        "begin_time      INTEGER     NOT NULL,"
        "end_time        INTEGER     NOT NULL,"

        "CHECK (begin_time < end_time) )";

    if(!query.exec(queryText))
    {
        QString text = "Creating 'events' failed: " + query.lastError().text();
        W(text)
        m_lastError = text;
        return false;
    }

#if ADD_EXAMPLE_DATA_TO_TABLE
    this->createExampleEventsData();
#endif

    return true;
}

bool Database::tableEventsExist() const
{
    QSqlDatabase db = QSqlDatabase::database( MAIN_DB_CONNECTION );
    QSqlQuery query(db);

    if(!query.exec("SELECT name FROM sqlite_master"))
    {
        W("Unable to read sqlite_master");
        return false;
    }

    bool foundEventsTable = false;
    while(query.next())
    {
        QSqlRecord record = query.record();
        QString tableName = record.value(0).toString();
        /// record.value("name").toString(); is also usefull, but digit is a faster way

        if(tableName.toLower() == "events")
        {
            foundEventsTable = true;
            break;
        }
    }

    return foundEventsTable;
}

void Database::createExampleEventsData() const
{
    QSqlDatabase db = QSqlDatabase::database( MAIN_DB_CONNECTION );
    QSqlQuery query(db);

    const QString queriesPrefix("INSERT INTO events (title, description, path, begin_time, end_time) VALUES ");
    QStringList queriesValues = {
        "('my title', 'desc', 'some path', 12, 14)",
        "('my title2', 'desc2', 'some path2', 16, 18)",
        "('my title3', 'desc3', 'some path3', 19, 21)",
    };

    for(const auto &queryValues : queriesValues)
    {
        if(!query.exec(queriesPrefix + queryValues))
            W("failed while executing query: " + queryValues);

    }

    I("Example events data was created");
}

void Database::readEventsFromRange(qint64 begin, qint64 end, EventsList &list) const
{
    QSqlDatabase db = QSqlDatabase::database( MAIN_DB_CONNECTION );
    QSqlQuery query(db);

    /// preparing query is not required - data cannot be invalid
    QString queryText = "SELECT * FROM events ";
    queryText += "WHERE begin_time >= " + QString::number(begin);
    queryText += " AND end_time <= " + QString::number(end);

    if(!query.exec( queryText ))
    {
        W("Unable to execute SELECT query for events: " + query.lastError().text());
        return;
    }

    int i=0;
    while(query.next())
    {
        QSqlRecord r = query.record();
        Event e;
        e.setID( r.value("id").toULongLong() );
        e.setTitle( r.value("title").toString() );
        e.setDescription( Database::validatePath(r.value("path").toString()) );
        e.setBeginTime( r.value("begin_time").toULongLong() );
        e.setEndTime( r.value("end_time").toULongLong() );
        list.append(e);
    }
}

QString Database::validatePath(const QString &path)
{
    if(path.startsWith("file:///"))
        return path.last(path.size() - 8);
    else
        return path;

}

void Database::readWeekEvents()
{
    WeekEvents *const weekEvents = WeekEvents::getInstance();

    for(int i=0; i<7; i++)
    {
        QDate date = weekEvents->getWeekDate(i);
        qint64 begin = date.startOfDay().toSecsSinceEpoch();
        qint64 end = date.endOfDay().toSecsSinceEpoch();

        EventsList list;
        this->readEventsFromRange(begin, end, list);
        weekEvents->setEventsForDay(static_cast<Qt::DayOfWeek>(i+1), list);
    }

    I("WeekEvents readed from the database")

}

