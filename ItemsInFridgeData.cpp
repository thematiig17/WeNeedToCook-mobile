#include "ItemsInFridgeData.h"

ItemsInFridgeModel::ItemsInFridgeModel()
{
    addItem({"Banana", 5});
    addItem({"Apple", 10});
    addItem({"Orange", 7});
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

void ItemsInFridgeModel::removeItem(int index)
{
    if (index < 0 || index >= m_items.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}
