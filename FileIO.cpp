#include "FileIO.h"
#include <QFile>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QDir>
#include <QDebug>

FileIO::FileIO(QObject *parent)
    : QObject{parent}
{}

QString FileIO::getFilePath(QString nameOfFile) const{
    QString dirPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation); //pobieramy z systemu sciezke danych aplikacji
    QDir dir(dirPath); //zmienna trzymajaca sciezke do pliku w odpowiednim formacie
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    qDebug() << "FileIO.cpp | getFilePath() | Sciezka do pliku: " << dir.filePath(nameOfFile + ".json");
    return dir.filePath(nameOfFile + ".json");
}

QJsonArray FileIO::loadData(QString nameOfFile){
    QFile file(getFilePath(nameOfFile));
    if (!file.open(QIODevice::ReadOnly)) {
        return {};
    }
    QByteArray jsonData = file.readAll();
    file.close();
    QJsonDocument document = QJsonDocument::fromJson(jsonData);

    return document.array();
}

QJsonObject FileIO::makeJsonFromFridge(QString name, int value, QString unit) {

    QJsonObject temp_obj;
    temp_obj["name"] = name;
    temp_obj["value"] = value;
    temp_obj["unit"] = unit;
    return temp_obj;

}

QJsonObject FileIO::makeJsonFromRecipe(QString name, QString description, QStringList ingredients, QVariantList quantity) { //UWAGA TO JEST TEST, JEŻELI DZIAŁA TO OKI :D


    QJsonObject ingredientsObject;

    for (int i = 0; i < ingredients.size(); ++i) {
        QJsonObject item;
        item["name"] = ingredients[i];
        item["quantity"] = quantity[i].toDouble();
        ingredientsObject[ingredients[i]] = item;
    }

    // Jeden przepis
    QJsonObject recipe;
    recipe["name"] = name;
    recipe["description"] = description;
    recipe["ingredients"] = ingredientsObject;

    return recipe;



}

bool FileIO::saveData(QString nameOfFile, QJsonArray data, const QJsonObject &object){

    QFile file(getFilePath(nameOfFile));
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


void FileIO::createExampleJson(QString nameOfFile){
    QJsonObject banana = makeJsonFromFridge("Banana", 5, "pcs");
    QJsonObject apple = makeJsonFromFridge("Apple", 10, "pcs");
    QJsonObject orange = makeJsonFromFridge("Orange", 7, "g");

    saveData(nameOfFile, loadData(nameOfFile), banana);
    saveData(nameOfFile, loadData(nameOfFile), apple);
    saveData(nameOfFile, loadData(nameOfFile), orange);

    qDebug() << "FileIO.cpp | createExampleJson() | Wykonano funkcje createExampleJson()";
}

void FileIO::deleteJson(QString nameOfFile) {
    QFile file(getFilePath(nameOfFile));
    if (file.open(QIODevice::WriteOnly)){
        QJsonArray emptyArray;
        QJsonDocument doc(emptyArray);
        file.write(doc.toJson());
        file.close();
    }
}
