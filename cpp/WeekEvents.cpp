#include "WeekEvents.h"

WeekEvents::WeekEvents(QObject *parent)
    : QObject{parent}
{
    QDate now( QDate::currentDate() );

    qint64 tmpJulianDay = now.toJulianDay() - now.dayOfWeek() + 1;
    m_currentWeek = QDate::fromJulianDay(tmpJulianDay);
}

WeekEvents::~WeekEvents()
{

}

WeekEvents * const WeekEvents::getInstance() noexcept
{
    static WeekEvents we;
    return &we;
}

void WeekEvents::setEventsForDay(Qt::DayOfWeek day, EventsList list)
{
    m_events[day] = list;
}

QDate WeekEvents::getWeekDate(qint64 dayOffset) const
{
    if(dayOffset > 6) /// limit, read only from monday to sunday in currentWeek
        dayOffset = 6;

    return m_currentWeek.addDays(dayOffset);
}

QString WeekEvents::getCurrentWeek() const
{
    return m_currentWeek.toString("d M yyyy") + " - " + this->getWeekDate(6).toString("d M yyyy");
}

void WeekEvents::nextWeek()
{
    m_currentWeek = m_currentWeek.addDays(7);
    emit this->currentWeekChanged();
}

void WeekEvents::prevWeek()
{
    m_currentWeek = QDate::fromJulianDay( m_currentWeek.toJulianDay() - 7 );
    emit this->currentWeekChanged();
}
