#ifndef EVENT_H
#define EVENT_H

#include <QObject>
#include <QFileInfo>

#include "cpp/Log.h"

typedef const QString &cQString;

class Event : public QObject
{
    Q_OBJECT
    Q_PROPERTY(size_t id            READ getID          NOTIFY idChanged            FINAL)
    Q_PROPERTY(const QString &title       READ getTitle       NOTIFY titleChanged         FINAL)
    Q_PROPERTY(const QString &description READ getDescription NOTIFY descriptionChanged   FINAL)
    Q_PROPERTY(const QString &path        READ getPath        NOTIFY pathChanged          FINAL)
    Q_PROPERTY(size_t beginTime     READ getBeginTime   NOTIFY beginTimeChanged     FINAL)
    Q_PROPERTY(size_t endTime       READ getEndTime     NOTIFY endTimeChanged       FINAL)
    Q_PROPERTY(size_t pathType      READ getPathType    NOTIFY pathTypeChanged      FINAL)

public:
    explicit Event(QObject *parent = nullptr);

    enum PathType{
        NotExist = 0,
        Directory,
        File
    };
    Q_ENUM(PathType)

    void setID(size_t id);
    void setTitle(cQString title);
    void setDescription(cQString description);
    void setPath(cQString path);
    void setBeginTime(size_t beginTime);
    void setEndTime(size_t endTime);

    size_t getID() const;
    cQString getTitle() const;
    cQString getDescription() const;
    cQString getPath() const;
    size_t getBeginTime() const;
    size_t getEndTime() const;

    PathType getPathType() const;

signals:
    void idChanged();
    void titleChanged();
    void descriptionChanged();
    void pathChanged();
    void beginTimeChanged();
    void endTimeChanged();

    void pathTypeChanged();

public slots:
    void checkWhatIsPathType();

private:
    size_t m_id;
    QString m_title;
    QString m_description;
    QString m_path;
    size_t m_beginTime;
    size_t m_endTime;

    PathType m_pathType;
};

#endif // EVENT_H
