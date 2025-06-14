#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>

class FileIO : public QObject
{
    Q_OBJECT
public:
    explicit FileIO(QObject *parent = nullptr); //konstrutkor

    Q_INVOKABLE bool saveData(QString nameOfFile, QJsonArray data, QJsonObject object); //zapis danych, TRUE - udany zapis, FALSE - nieudany zapis, przyjmuje json ktory trzeba zapisac

    Q_INVOKABLE QJsonObject makeJsonFromRecipe(QString name, QString description, QStringList ingredients, QVariantList quantity); //UWAGA TO JEST TEST, JEŻELI DZIAŁA TO OKI :D
    Q_INVOKABLE QJsonObject makeJsonFromFridge(QString name, int value, QString unit, QString note);
    Q_INVOKABLE QJsonObject makeJsonFromShoppingList(QString name, int value, QString unit, QString note); //UWAGA TO JEST TEST, JEŻELI DZIAŁA TO OKI :D

    Q_INVOKABLE QJsonArray loadData(QString nameOfFile); //Wczytuje danem zwraca json

    Q_INVOKABLE void createExampleJson(QString nameOfFile);
    Q_INVOKABLE void deleteJson(QString nameOfFile);

    Q_INVOKABLE void deleteByName(QString nameOfFile, QString name);
    Q_INVOKABLE void editExistingEntry(QString nameOfFile, QString name, QJsonObject newEntry);

private:
    QString getFilePath(QString nameOfFile) const; //zwraca sciezke

};

#endif // FILEIO_H
