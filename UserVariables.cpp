#include "UserVariables.h"

UserVariables::UserVariables() {}

void UserVariables::changeNameOfUser(QString newName) {
    nameOfUser = newName;
}

QString UserVariables::getNameOfUser() {
    return nameOfUser;
}
