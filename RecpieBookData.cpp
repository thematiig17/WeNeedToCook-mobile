#include "RecipeBookData.h"
#include "FileIO.h"

RecipeBookModel::RecipeBookModel()
{
    FileIO fileIO;
    fileIO.loadData("RecipeData");
    //addItem({"Banana", 5});
    //addItem({"Apple", 10});
    //addItem({"Orange", 7});
}

int RecipeBookModel::rowCount(const QModelIndex &) const
{
    return m_items.size();
}

QVariant RecipeBookModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_items.size())
        return QVariant();

    const RecipeBookData &item = m_items[index.row()];
    switch (role) {
    case NameRole: return item.name;
    case CountRole: return item.count;
    case UnitRole: return item.unit;
    case NoteRole: return item.note;
    default: return QVariant();
    }
}

QHash<int, QByteArray> RecipeBookModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { CountRole, "count" },
        { UnitRole, "unit" },
        { NoteRole,"note"}
    };
}

void RecipeBookModel::addItem(const RecipeBookData &item)
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


void RecipeBookModel::addItem(const QString &name, int count, QString unit, QString note)
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
    m_items.append({name, count, unit, note});
    endInsertRows();
}



void RecipeBookModel::addItemToFile(const RecipeBookData &item)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (item.name.length() > 10 || !regex.match(item.name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("RecipeData", fileIO.loadData("RecipeData"), fileIO.makeJsonFromRecipe(item.name, item.count, item.unit, item.note));
}
void RecipeBookModel::addItemToFile(const QString &name, int count, QString unit, QString note)
{
    QRegularExpression regex("^[a-zA-Z .,]{1,50}$");
    if (name.length() > 10 || !regex.match(name).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("RecipeData", fileIO.loadData("RecipeData"), fileIO.makeJsonFromRecipe(name, count, unit, note));
}

void RecipeBookModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

void RecipeBookModel::loadItemsFromFile() {

    /*Usuniecie danych obecnych juz w modelu*/
    beginResetModel();   // powiadomienie QML że dane się zmienią
    m_items.clear();


    FileIO fileIO;
    QJsonArray array = fileIO.loadData("RecipeData");
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
        qDebug() << "RecipeBookData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int RecipeBookModel::count() const {
    return m_items.count();
}
