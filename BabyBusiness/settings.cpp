#include "settings.h"

Settings::Settings()
{
    QSettings settings("Calgoc","BabyBusiness");
    m_momsTurn = settings.value("mom",true).toBool();
}

void Settings::setMomsTurn(bool momsTurn)
{
    if (m_momsTurn == momsTurn)
        return;

    m_momsTurn = momsTurn;
    QSettings settings("Calgoc","BabyBusiness");
    settings.setValue("mom", m_momsTurn);
    emit momsTurnChanged(m_momsTurn);
}
