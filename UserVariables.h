#ifndef USERVARIABLES_H
#define USERVARIABLES_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>

class UserVariables : public QObject
{
    Q_OBJECT
    QString nameOfUser = "PTASZKIIIIIIIIIIIIIIIIIIIIII"; //TUTAJ USTAWIC COS NORMALNEGO NA KONIEC UWU ALE WODY WERKI SA SUPER WIEC NARAZIE JEST WODA WERKA
public:
    UserVariables();
    Q_INVOKABLE void changeNameOfUser(QString newName);
    Q_INVOKABLE QString getNameOfUser();
};

#endif // USERVARIABLES_H
