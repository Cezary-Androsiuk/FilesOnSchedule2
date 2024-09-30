#include "Database.h"

Database::Database(QObject *parent)
    : QObject{parent}
    , m_oppened(false)
{

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

    emit this->initialized();
}

const QString &Database::getLastError() const
{
    return this->m_lastError;
}

bool Database::openDB()
{
    if(!m_oppened)
    {
        W("Database already oppened!")
        m_lastError = "Database already oppened!";
        return false;
    }

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", MAIN_DB_CONNECTION);
    db.setDatabaseName(DATABASE_FILE);

    if(!db.open())
    {
        m_oppened = false;
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

