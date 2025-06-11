#include "UserVariables.h"
#include "FileIO.h"

UserVariables::UserVariables() {}

void UserVariables::changeNameOfUser(QString newName) {

    nameOfUser = newName;
    FileIO fileIO;
    QJsonArray temp_array;
    QJsonObject temp_obj;
    temp_obj["username"] = newName;

    fileIO.saveData("Username", temp_array, temp_obj);
}

QString UserVariables::getNameOfUser() {
    FileIO fileIO;

    QJsonArray array = fileIO.loadData("Username");
    QString name;
    for (const QJsonValue &valueOfArray : array) {
        if(!valueOfArray.isObject()){
            continue;
        }

        QJsonObject obj = valueOfArray.toObject();

        name = obj["username"].toString();

    }
    return name;
}
