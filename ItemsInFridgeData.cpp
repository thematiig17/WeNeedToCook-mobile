#include "ItemsInFridgeData.h"
#include "FileIO.h"

ItemsInFridgeModel::ItemsInFridgeModel()
{
    FileIO fileIO;
    fileIO.loadData("FridgeData");
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
    case UnitRole: return item.unit;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ItemsInFridgeModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { CountRole, "count" },
        { UnitRole, "unit" }
    };
}

void ItemsInFridgeModel::addItem(const ItemsInFridgeData &item)
{
    if (item.name.length() > 10) {
        qWarning() << "Nazwa zbyt długa:" << item.name;
        return;
    }

    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (!regex.match(item.name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << item.name;
        return;
    }


    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}


void ItemsInFridgeModel::addItem(const QString &name, int count, QString unit)
{
    if (name.length() > 10) {
        qWarning() << "Name too long";
        return;
    }
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (!regex.match(name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << name;
        return;
    }

    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({name, count, unit});
    endInsertRows();
}



void ItemsInFridgeModel::addItemToFile(const ItemsInFridgeData &item)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (item.name.length() > 10 || !regex.match(item.name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("FridgeData", fileIO.loadData("FridgeData"), fileIO.makeJsonFromFridge(item.name, item.count, item.unit));
}
void ItemsInFridgeModel::addItemToFile(const QString &name, int count, QString unit)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (name.length() > 10 || !regex.match(name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("FridgeData", fileIO.loadData("FridgeData"), fileIO.makeJsonFromFridge(name, count, unit));
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
    QJsonArray array = fileIO.loadData("FridgeData");
    for (const QJsonValue &valueOfArray : array) {
        if(!valueOfArray.isObject()){
            continue;
        }

        QJsonObject obj = valueOfArray.toObject();

        QString name = obj["name"].toString();
        int value = obj["value"].toInt();
        QString unit = obj["unit"].toString();

        addItem({name, value, unit});
        qDebug() << "ItemsInFridgeData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int ItemsInFridgeModel::count() const {
    return m_items.count();
}
