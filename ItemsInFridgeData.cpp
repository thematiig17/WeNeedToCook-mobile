#include "ItemsInFridgeData.h"
#include "FileIO.h"

ItemsInFridgeModel::ItemsInFridgeModel()
{
    FileIO fileIO;
    fileIO.loadData();
    //addItem({"Banana", 5});
    //addItem({"Apple", 10});
    //addItem({"Orange", 7});
}

int ItemsInFridgeModel::rowCount(const QModelIndex &) const
{
    return m_items.size();
}

QVariant ItemsInFridgeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const ItemsInFridgeData &item = m_items[index.row()];
    switch (role) {
    case NameRole: return item.name;
    case CountRole: return item.count;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ItemsInFridgeModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { CountRole, "count" }
    };
}

void ItemsInFridgeModel::addItem(const ItemsInFridgeData &item)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}

void ItemsInFridgeModel::addItem(const QString &name, int count)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({name, count});
    endInsertRows();
}


void ItemsInFridgeModel::addItemToFile(const ItemsInFridgeData &item)
{
    FileIO fileIO;
    fileIO.saveData(fileIO.loadData(), fileIO.makeJsonFromFridge(item.name, item.count));
}
void ItemsInFridgeModel::addItemToFile(const QString &name, int count)
{
    FileIO fileIO;
    fileIO.saveData(fileIO.loadData(), fileIO.makeJsonFromFridge(name, count));
}

void ItemsInFridgeModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

void ItemsInFridgeModel::loadItemsFromFile() {

    /*Usuniecie danych obecnych juz w modelu*/
    beginResetModel();   // powiadomienie QML że dane się zmienią
    m_items.clear();


    FileIO fileIO;
    QJsonArray array = fileIO.loadData();
    for (const QJsonValue &valueOfArray : array) {
        if(!valueOfArray.isObject()){
            continue;
        }

        QJsonObject obj = valueOfArray.toObject();

        QString name = obj["name"].toString();
        int value = obj["value"].toInt();

        addItem({name, value});
        qDebug() << "ItemsInFridgeData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int ItemsInFridgeModel::count() const {
    return m_items.count();
}
