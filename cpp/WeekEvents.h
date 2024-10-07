#ifndef WEEKEVENTS_H
#define WEEKEVENTS_H

#include <QObject>
#include <QMap>
#include <QList>
#include <QDate>
#include <QDateTime>

#include "cpp/Log.h"
#include "cpp/Event.h"

typedef QList<Event> EventsList;
typedef QMap<Qt::DayOfWeek, EventsList> EventsMap;

class WeekEvents : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentWeek READ getCurrentWeek NOTIFY currentWeekChanged FINAL)
    Q_PROPERTY(EventsMap events READ getEvents NOTIFY eventsChanged FINAL)

private:
    explicit WeekEvents(QObject *parent = nullptr);
    WeekEvents(const WeekEvents &) = delete; // rm copy constructor
    WeekEvents(      WeekEvents &&) = delete; // rm move constructor
    WeekEvents& operator=(const WeekEvents &) = delete; // rm copy operator
    WeekEvents& operator=(      WeekEvents &&) = delete; // rm move operator (y = std::move(x))
    ~WeekEvents();

public:
    static WeekEvents * const getInstance() noexcept;

    void setEventsForDay(Qt::DayOfWeek day, EventsList list);

    Q_INVOKABLE QDate getWeekDate(qint64 dayOffset = 0) const;
    Q_INVOKABLE QString getTextDate(qint64 dayOffset = 0) const;
    QString getCurrentWeek() const;
    const EventsMap &getEvents() const;

public slots:
    void nextWeek();
    void prevWeek();

signals:
    void currentWeekChanged();
    void eventsChanged();

private:
    EventsMap m_events;
    QDate m_currentWeek;
};

#endif // WEEKEVENTS_H
