#include "ShoppingList.h"
#include "FileIO.h"

ShoppingListModel::ShoppingListModel()
{
    FileIO fileIO;
    fileIO.loadData("ShoppingListData");
    //addItem({"Banana", 5});
    //addItem({"Apple", 10});
    //addItem({"Orange", 7});
}

int ShoppingListModel::rowCount(const QModelIndex &) const
{
    return m_items.size();
}

QVariant ShoppingListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const ShoppingListData &item = m_items[index.row()];
    switch (role) {
    case NameRole: return item.name;
    case CountRole: return item.count;
    case UnitRole: return item.unit;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ShoppingListModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { CountRole, "count" },
        { UnitRole, "unit" }
    };
}

void ShoppingListModel::addItem(const ShoppingListData &item)
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


void ShoppingListModel::addItem(const QString &name, int count, QString unit)
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



void ShoppingListModel::addItemToFile(const ShoppingListData &item)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (item.name.length() > 10 || !regex.match(item.name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("ShoppingListData", fileIO.loadData("ShoppingList"), fileIO.makeJsonFromShoppingList(item.name, item.count, item.unit));
}
void ShoppingListModel::addItemToFile(const QString &name, int count, QString unit)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (name.length() > 10 || !regex.match(name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("ShoppingListData", fileIO.loadData("ShoppingListData"), fileIO.makeJsonFromShoppingList(name, count, unit));
}

void ShoppingListModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

void ShoppingListModel::loadItemsFromFile() {

    /*Usuniecie danych obecnych juz w modelu*/
    beginResetModel();   // powiadomienie QML że dane się zmienią
    m_items.clear();


    FileIO fileIO;
    QJsonArray array = fileIO.loadData("ShoppingListData");
    for (const QJsonValue &valueOfArray : array) {
        if(!valueOfArray.isObject()){
            continue;
        }

        QJsonObject obj = valueOfArray.toObject();

        QString name = obj["name"].toString();
        int value = obj["value"].toInt();
        QString unit = obj["unit"].toString();

        addItem({name, value, unit});
        qDebug() << "ShoppingListData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int ShoppingListModel::count() const {
    return m_items.count();
}
