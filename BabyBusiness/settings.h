#ifndef SETTINGS_H
#define SETTINGS_H
#include <QObject>
#include <QSettings>


class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool momsTurn READ momsTurn WRITE setMomsTurn NOTIFY momsTurnChanged)
    bool m_momsTurn;

public:
Settings();
bool momsTurn() const
{
    return m_momsTurn;
}
public slots:
void setMomsTurn(bool momsTurn);
signals:
void momsTurnChanged(bool momsTurn);
};

#endif // SETTINGS_H
