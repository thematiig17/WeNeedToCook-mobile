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
    case DescriptionRole: return item.description;
    case IngredientsRole: return item.ingredients;
    case QuantityRole: return item.quantity;
    case UnitsRole: return item.units;
    default: return QVariant();
    }
}

QHash<int, QByteArray> RecipeBookModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { DescriptionRole, "description" },
        { IngredientsRole, "ingredients" },
        { QuantityRole, "quantity" },
        { UnitsRole, "units" }
    };
}

void RecipeBookModel::addItem(const RecipeBookData &item)
{
    if (item.name.length() > 30) {
        qWarning() << "Nazwa zbyt długa:" << item.name;
        return;
    }
    else if (item.description.length() > 180) {
        qWarning() << "Nazwa zbyt długa:" << item.description;
        return;
    }

    QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (!regex.match(item.name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << item.name;
        return;
    }
    if (!regex.match(item.description).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << item.description;
        return;
    }


    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}


void RecipeBookModel::addItem(const QString &name, QString description, QStringList ingredients, QVariantList quantity, QStringList units)
{
    if (name.length() > 30) {
        qWarning() << "Name too long";
        return;
    }
    else if (description.length() > 180) {
        qWarning() << "Nazwa zbyt długa:" << description;
        return;
    }
    QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (!regex.match(name).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << name;
        return;
    }
    if (!regex.match(description).hasMatch()) {
        qWarning() << "Nazwa zawiera niedozwolone znaki:" << description;
        return;
    }

    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append({name, description, ingredients, quantity, units});
    endInsertRows();
}



void RecipeBookModel::addItemToFile(const RecipeBookData &item)
{
    QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (item.name.length() > 30 || item.description.length() > 180 || !regex.match(item.name).hasMatch() || !regex.match(item.description).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("RecipeData", fileIO.loadData("RecipeData"), fileIO.makeJsonFromRecipe(item.name, item.description, item.ingredients, item.quantity, item.units));
}
void RecipeBookModel::addItemToFile(const QString &name, QString description, QStringList ingredients, QVariantList quantity, QStringList units)
{
    QRegularExpression regex("^[a-zA-Z0-9 .,()\n]{1,180}$");
    if (name.length() > 30 || description.length() > 180 || !regex.match(name).hasMatch() || !regex.match(description).hasMatch()) {
        qWarning() << "Błędna nazwa — nie zapisano do pliku:";
        return;
    }


    FileIO fileIO;
    fileIO.saveData("RecipeData", fileIO.loadData("RecipeData"), fileIO.makeJsonFromRecipe(name, description, ingredients, quantity, units));
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

        RecipeBookData recipe;
        recipe.name = obj["name"].toString();
        recipe.description = obj["description"].toString();

        QJsonObject ingredientsObj = obj["ingredients"].toObject();
        QStringList ingredients;
        QVariantList quantities;
        QStringList units;

        for (const QString &key : ingredientsObj.keys()) {
            QJsonObject ingredientData = ingredientsObj[key].toObject();
            QString name = ingredientData["name"].toString();
            double quantity = ingredientData["quantity"].toDouble();
            QString unit = ingredientData["unit"].toString();

            ingredients.append(name);
            quantities.append(quantity);
            units.append(unit);
        }

        recipe.ingredients = ingredients;
        recipe.quantity = quantities;
        recipe.units = units;

        addItem(recipe);

        qDebug() << "RecipeBookData.cpp | loadItemsFromFile() | Odczytano!";

    }
    emit countChanged();
    endResetModel(); // powiadomienie że dane się zmieniły
}

int RecipeBookModel::count() const {
    return m_items.count();
}
