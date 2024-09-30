#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QFile>

#include "cpp/Log.h"

#define MAIN_DB_CONNECTION "MainDatabaseConnection"
#define DATABASE_FILE "FilesOnSchedule2.db"

class Database : public QObject
{
    Q_OBJECT

private:
    explicit Database(QObject *parent = nullptr);
    Database(const Database &) = delete; // rm copy constructor
    Database(      Database &&) = delete; // rm move constructor
    Database& operator=(const Database &) = delete; // rm copy operator
    Database& operator=(      Database &&) = delete; // rm move operator (y = std::move(x))
    ~Database();

public:
    static Database * const getInstance() noexcept;

    void initialize();

    const QString &getLastError() const;

private:
    bool openDB();
    void closeDB();
    bool resetDB();

signals:
    void initialized();
    void initializeFailed();

private:
    bool m_oppened;
    QString m_lastError;
};

#endif // DATABASE_H
