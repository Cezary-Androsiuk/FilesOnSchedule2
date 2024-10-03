#include "Event.h"

Event::Event(QObject *parent)
    : QObject{parent}
{
    QObject::connect(this, &Event::pathChanged, this, &Event::checkWhatIsPathType);
}

void Event::setID(size_t id)
{
    m_id = id;
    emit this->idChanged();
}

void Event::setTitle(cQString title)
{
    m_title = title;
    emit this->titleChanged();
}

void Event::setDescription(cQString description)
{
    m_description = description;
    emit this->descriptionChanged();
}

void Event::setPath(cQString path)
{
    m_path = path;
    emit this->pathChanged();
}

void Event::setBeginTime(size_t beginTime)
{
    m_beginTime = beginTime;
    emit this->beginTimeChanged();
}

void Event::setEndTime(size_t endTime)
{
    m_endTime = endTime;
    emit this->endTimeChanged();
}


size_t Event::getID() const
{
    return m_id;
}

cQString Event::getTitle() const
{
    return m_title;
}

cQString Event::getDescription() const
{
    return m_description;
}

cQString Event::getPath() const
{
    return m_path;
}

size_t Event::getBeginTime() const
{
    return m_beginTime;
}

size_t Event::getEndTime() const
{
    return m_endTime;
}

Event::PathType Event::getPathType() const
{
    return m_pathType;
}


void Event::checkWhatIsPathType()
{
    QFileInfo path(m_path);

    if(path.exists())
    {
        if(path.isDir())
            m_pathType = PathType::Directory;
        else if(path.isFile())
            m_pathType = PathType::File;
    }
    else
        m_pathType = PathType::NotExist;

    emit this->pathTypeChanged();
}
