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

QJsonObject FileIO::makeJsonFromFridge(QString name, int value, QString unit, QString note) {

    QJsonObject temp_obj;
    temp_obj["name"] = name;
    temp_obj["value"] = value;
    temp_obj["unit"] = unit;
    temp_obj["note"] = note;

    return temp_obj;

}

QJsonObject FileIO::makeJsonFromRecipe(QString name, QString description, QStringList ingredients, QVariantList quantity, QStringList units) { //UWAGA TO JEST TEST, JEŻELI DZIAŁA TO OKI :D


    QJsonObject ingredientsObject;

    for (int i = 0; i < ingredients.size(); ++i) {
        QJsonObject item;
        item["name"] = ingredients[i];
        item["quantity"] = quantity[i].toDouble();
        item["unit"] = units[i];
        ingredientsObject[ingredients[i]] = item;
    }

    // Jeden przepis
    QJsonObject recipe;
    recipe["name"] = name;
    recipe["description"] = description;
    recipe["ingredients"] = ingredientsObject;

    return recipe;


}

QJsonObject FileIO::makeJsonFromShoppingList(QString name, int value, QString unit, QString note) { //UWAGA TO JEST TEST, JEŻELI DZIAŁA TO OKI :D
    QJsonObject temp_obj;
    temp_obj["name"] = name;
    temp_obj["value"] = value;
    temp_obj["unit"] = unit;
    temp_obj["note"] = note;
    return temp_obj;
}

bool FileIO::saveData(QString nameOfFile, QJsonArray data, QJsonObject object){
    bool valueExists = false;

    // Szukamy istniejącego obiektu i aktualizujemy go
    if (nameOfFile != "RecipeData") {
        for (int i = 0; i < data.size(); ++i) {
            QJsonObject existingObj = data[i].toObject();
            if (existingObj["name"].toString() == object["name"].toString()) {
                int newValue = existingObj["value"].toInt() + object["value"].toInt();
                existingObj["value"] = newValue;
                data[i] = existingObj;  // Zaktualizuj obiekt w tablicy
                valueExists = true;
                break;
            }
        }
    }

    for (int i = data.size() - 1; i >= 0; --i) {
        QJsonObject existingObj = data[i].toObject();
        if (existingObj["value"].toInt() < 0) {
            saveData("ShoppingListData",
                     loadData("ShoppingListData"),
                     makeJsonFromShoppingList(
                         existingObj["name"].toString(),
                         -1 * existingObj["value"].toInt(),
                         existingObj["unit"].toString(),
                         existingObj["note"].toString()
                         ));
            data.removeAt(i); // USUNIĘCIE z tablicy
        }
    }
    /*sprawdzanie czy ktorys element ma wartosc 0*/
    for (int i = data.size() - 1; i >= 0; --i) {
        QJsonObject obj = data[i].toObject();
        if (obj["value"].toInt() == 0) {
            data.removeAt(i);
        }
    }
    // Jeśli nie znaleziono istniejącego obiektu, dodaj nowy
    if (!valueExists && !object.isEmpty()) {
        data.append(object);
    }

    QFile file(getFilePath(nameOfFile));
    if (!file.open(QIODevice::WriteOnly)) {
        return false;
    }

    QJsonDocument doc(data);
    file.write(doc.toJson());
    file.close();
    return true;
}


void FileIO::createExampleJson(QString nameOfFile){
    if (nameOfFile == "FridgeData"){
        QJsonObject banana = makeJsonFromFridge("Banana", 5, "pcs","cos");
        QJsonObject apple = makeJsonFromFridge("Apple", 10, "pcs","cos");
        QJsonObject orange = makeJsonFromFridge("Orange", 7, "g","cos");

        saveData(nameOfFile, loadData(nameOfFile), banana);
        saveData(nameOfFile, loadData(nameOfFile), apple);
        saveData(nameOfFile, loadData(nameOfFile), orange);
    }
    else if (nameOfFile == "RecipeData"){
        QStringList opcje = {"skladnik1", "skladnik2", "skladnik3"};
        QVariantList liczby = {"1", "2", "3"};
        QStringList jednostki = {"pcs", "pcs", "ml"};

        QStringList skladJajecznica = {"jajko", "sol", "pieprz"};
        QVariantList iloscJajecznica = {"3", "5", "5"};
        QStringList jednostkiJajecznica = {"pcs", "g", "g"};
        QJsonObject jajecznica = makeJsonFromRecipe("Jajecznica", "Smaz na patelni", skladJajecznica, iloscJajecznica, jednostkiJajecznica);

        QStringList skladBanan = {"Banana"};
        QVariantList iloscBanan = {"2"};
        QStringList jednostkiBanan = {"pcs"};
        QJsonObject banana = makeJsonFromRecipe("Bananowe", "Zjedz banana", skladBanan, iloscBanan, jednostkiBanan);

        saveData(nameOfFile, loadData(nameOfFile), jajecznica);
        saveData(nameOfFile, loadData(nameOfFile), makeJsonFromRecipe("Testowy", "Opistest", opcje, liczby, jednostki));
        saveData(nameOfFile, loadData(nameOfFile), banana);

    }
    else if (nameOfFile == "ShoppingListData"){
        QJsonObject grapes = makeJsonFromShoppingList("Grapes", 20, "pcs", "For eating");
        QJsonObject milk = makeJsonFromShoppingList("Milk", 1000, "mL", "For drinking");

        saveData(nameOfFile, loadData(nameOfFile), grapes);
        saveData(nameOfFile, loadData(nameOfFile), milk);
    }


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

void FileIO::deleteByName(QString nameOfFile, QString name) {
    QJsonArray baseFile = loadData(nameOfFile);
    QJsonArray filteredFile;

    for (const QJsonValue &val : baseFile) {
        QJsonObject object = val.toObject();
        if (object["name"].toString() != name) {
            filteredFile.append(object);
        }
    }

    QJsonObject emptyObject;
    saveData(nameOfFile, filteredFile, emptyObject);
}

void FileIO::editExistingEntry(QString nameOfFile, QString name, QJsonObject newEntry) {
    QJsonArray baseFile = loadData(nameOfFile);
    QJsonArray filteredFile;

    for (const QJsonValue &val : baseFile) {
        QJsonObject object = val.toObject();
        if (object["name"].toString() == name) {
            filteredFile.append(newEntry);
        }
        else {
            filteredFile.append(object);
        }
    }
    QJsonObject emptyObject = QJsonObject();
    saveData(nameOfFile, filteredFile, emptyObject);
}

bool FileIO::searchItemByName(QString nameOfFile, QString name, int minimumValue){
    QJsonArray baseFile = loadData(nameOfFile);

    for (const QJsonValue &val : baseFile) {
        QJsonObject object = val.toObject();
        if (object["name"].toString() == name) {
            if (object["value"].toInt() < minimumValue){
                return true;
            }
        }
    }
    return false;
}
bool FileIO::searchItemByName(QString nameOfFile, QString name){
    QJsonArray baseFile = loadData(nameOfFile);

    for (const QJsonValue &val : baseFile) {
        QJsonObject object = val.toObject();
        if (object["name"].toString() == name) {
            return true;
        }
    }
    return false;
}
