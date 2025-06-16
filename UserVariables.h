#ifndef USERVARIABLES_H
#define USERVARIABLES_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>

class UserVariables : public QObject
{
    Q_OBJECT
    QString nameOfUser = "DefaultUser";
public:
    UserVariables();
    Q_INVOKABLE void changeNameOfUser(QString newName);
    Q_INVOKABLE QString getNameOfUser();
};

#endif // USERVARIABLES_H
