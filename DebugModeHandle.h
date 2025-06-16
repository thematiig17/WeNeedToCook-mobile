#ifndef DEBUGMODEHANDLE_H
#define DEBUGMODEHANDLE_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>

/*Klasa obslugujaca DebugMode*/

class DebugModeHandle : public QObject
{
    Q_OBJECT
    bool isDebugModeEnabled = false;
public:
    DebugModeHandle();
    Q_INVOKABLE void enableDebugMode();
    Q_INVOKABLE void disableDebugMode();
    Q_INVOKABLE bool debugModeStatus();
};

#endif // DEBUGMODEHANDLE_H
