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
    case NoteRole: return item.note;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ShoppingListModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { CountRole, "count" },
        { UnitRole, "unit" },
        {NoteRole, "note"}
    };
}

void ShoppingListModel::addItem(const ShoppingListData &item)
{
    if (item.name.length() > 30) {
        qWarning() << "Nazwa zbyt długa:" << item.name;
        return;
    }
    else if (item.note.length() > 120) {
        qWarning() << "Nazwa zbyt długa:" << item.note;
        return;
    }

    static QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (!regex.match(item.name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << item.name;
        return;
    }
    if (!regex.match(item.note).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << item.note;
        return;
    }


    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}


void ShoppingListModel::addItem(const QString &name, int count, QString unit, QString note)
{
    if (name.length() > 30) {
        qWarning() << "Name too long";
        return;
    }
    else if (note.length() > 120) {
        qWarning() << "Nazwa zbyt długa:" << note;
        return;
    }
    static QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (!regex.match(name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << name;
        return;
    }
    if (!regex.match(note).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << note;
        return;
    }

    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({name, count, unit, note});
    endInsertRows();
}



void ShoppingListModel::addItemToFile(const ShoppingListData &item)
{
    static QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (item.name.length() > 30 || item.note.length() > 120 || !regex.match(item.name).hasMatch() || !regex.match(item.note).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("ShoppingListData", fileIO.loadData("ShoppingList"), fileIO.makeJsonFromShoppingList(item.name, item.count, item.unit, item.note));
}
void ShoppingListModel::addItemToFile(const QString &name, int count, QString unit, QString note)
{
    static QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (name.length() > 30 || note.length() > 120 || !regex.match(name).hasMatch() || !regex.match(note).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("ShoppingListData", fileIO.loadData("ShoppingListData"), fileIO.makeJsonFromShoppingList(name, count, unit, note));
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
        QString note = obj["note"].toString();

        addItem({name, value, unit, note});
        qDebug() << "ShoppingListData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int ShoppingListModel::count() const {
    return m_items.count();
}

void ShoppingListModel::addMultipleItemsToFile(QStringList ingredients, QVariantList quantity, QStringList units) {
    for(int i = 0; i < ingredients.count(); i++){
    FileIO fileIO;
    fileIO.saveData("ShoppingListData", fileIO.loadData("ShoppingListData"), fileIO.makeJsonFromShoppingList(ingredients[i], quantity[i].toInt(), units[i], "Added from Recipe"));
    }
}
