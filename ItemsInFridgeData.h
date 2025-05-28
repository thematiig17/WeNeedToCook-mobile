#ifndef ITEMSINFRIDGEDATA_H
#define ITEMSINFRIDGEDATA_H

#include <QString>
#include <QAbstractListModel>

struct ItemsInFridgeData {
    QString name;
    int count;
};

class ItemsInFridgeModel : public QAbstractListModel {
    Q_OBJECT
    QList<ItemsInFridgeData> m_items;
public:
    enum ItemRoles { //enumeracja
        NameRole = Qt::UserRole + 1,
        CountRole
    };
    ItemsInFridgeModel(); //konstruktor
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addItem(const ItemsInFridgeData &item);
    Q_INVOKABLE void addItem(const QString &name, int count);
    Q_INVOKABLE void removeItem(int index);

};

#endif // ITEMSINFRIDGEDATA_H
