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

    Q_INVOKABLE bool saveData(QString nameOfFile, QJsonArray data, const QJsonObject &object); //zapis danych, TRUE - udany zapis, FALSE - nieudany zapis, przyjmuje json ktory trzeba zapisac
    Q_INVOKABLE QJsonObject makeJsonFromFridge(QString name, int value, QString unit);
    Q_INVOKABLE QJsonArray loadData(QString nameOfFile); //Wczytuje danem zwraca json

    Q_INVOKABLE void createExampleJson(QString nameOfFile);
    Q_INVOKABLE void deleteJson(QString nameOfFile);

private:
    QString getFilePath(QString nameOfFile) const; //zwraca sciezke

};

#endif // FILEIO_H
