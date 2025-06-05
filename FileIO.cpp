#include "FileIO.h"
#include <QFile>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QDir>
#include <QDebug>

FileIO::FileIO(QObject *parent)
    : QObject{parent}
{}

QString FileIO::getFilePath() const{
    QString dirPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation); //pobieramy z systemu sciezke danych aplikacji
    QDir dir(dirPath); //zmienna trzymajaca sciezke do pliku w odpowiednim formacie
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    qDebug() << "FileIO.cpp | getFilePath() | Sciezka do pliku: " << dir.filePath("FridgeData.json");
    return dir.filePath("FridgeData.json");
}

QJsonArray FileIO::loadData(){
    QFile file(getFilePath());
    if (!file.open(QIODevice::ReadOnly)) {
        return {};
    }
    QByteArray jsonData = file.readAll();
    file.close();
    QJsonDocument document = QJsonDocument::fromJson(jsonData);

    return document.array();
}

QJsonObject FileIO::makeJsonFromFridge(QString name, int value) {

    QJsonObject temp_obj;
    temp_obj["name"] = name;
    temp_obj["value"] = value;
    return temp_obj;

}

bool FileIO::saveData(QJsonArray data, const QJsonObject &object){

    QFile file(getFilePath());
    if (!file.open(QIODevice::WriteOnly)){
        return false;
    }

    data.append(object);

    QJsonDocument doc(data);
    file.write(doc.toJson());
    file.close();
    return true;



    /*(!saveData(temp_array)){
        qWarning() << "FileIO.cpp | makeJsonFromFridge() | Blad utworzenia pozycji json z tekstu!"
    }*/
}


void FileIO::createExampleJson(){
    QJsonObject banana = makeJsonFromFridge("Banana", 5);
    QJsonObject apple = makeJsonFromFridge("Apple", 10);
    QJsonObject orange = makeJsonFromFridge("Orange", 7);

    saveData(loadData(), banana);
    saveData(loadData(), apple);
    saveData(loadData(), orange);

    qDebug() << "FileIO.cpp | createExampleJson() | Wykonano funkcje createExampleJson()";
}

void FileIO::deleteJson() {
    QFile file(getFilePath());
    if (file.open(QIODevice::WriteOnly)){
        QJsonArray emptyArray;
        QJsonDocument doc(emptyArray);
        file.write(doc.toJson());
        file.close();
    }
}
