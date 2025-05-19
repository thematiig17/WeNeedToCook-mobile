#include "ItemsInFridgeData.h"

ItemsInFridgeModel::ItemsInFridgeModel()
{
    addItem({"Banana", "Yellow fruit", 5});
    addItem({"Apple", "Red or green", 10});
    addItem({"Orange", "Citrus fruit", 7});
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
    case DescriptionRole: return item.desc;
    case CountRole: return item.count;
    default: return QVariant();
    }
}

QHash<int, QByteArray> ItemsInFridgeModel::roleNames() const
{
    return {
        { NameRole, "name" },
        { DescriptionRole, "description" },
        { CountRole, "count" }
    };
}

void ItemsInFridgeModel::addItem(const ItemsInFridgeData &item)
{
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
    m_items.append(item);
    endInsertRows();
}
