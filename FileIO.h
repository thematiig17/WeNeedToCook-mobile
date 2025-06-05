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

    Q_INVOKABLE bool saveData(QJsonArray data, const QJsonObject &object); //zapis danych, TRUE - udany zapis, FALSE - nieudany zapis, przyjmuje json ktory trzeba zapisac
    Q_INVOKABLE QJsonObject makeJsonFromFridge(QString name, int value);
    Q_INVOKABLE QJsonArray loadData(); //Wczytuje danem zwraca json

    Q_INVOKABLE void createExampleJson();
    Q_INVOKABLE void deleteJson();

private:
    QString getFilePath() const; //zwraca sciezke

};

#endif // FILEIO_H
