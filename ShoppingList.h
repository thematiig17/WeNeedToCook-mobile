#ifndef SHOPPINGLIST_H
#define SHOPPINGLIST_H
#include <QString>
#include <QAbstractListModel>

struct ShoppingListData {
    QString name;
    int count;
    QString unit;
};

class ShoppingListModel : public QAbstractListModel {
    Q_OBJECT
    QList<ShoppingListData> m_items;
public:
    //do ogloszenia zmiany wartosci
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_SIGNAL void countChanged();
    Q_INVOKABLE int count() const;

    enum ItemRoles { //enumeracja, nadajemy nazwy liczbom
        NameRole = Qt::UserRole + 1,
        CountRole,
        UnitRole
    };
    ShoppingListModel(); //konstruktor
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void loadItemsFromFile();

    void addItem(const ShoppingListData &item);
    Q_INVOKABLE void addItem(const QString &name, int count, QString unit);
    Q_INVOKABLE void addItemToFile(const QString &name, int count, QString unit);
    void addItemToFile(const ShoppingListData &item);
    Q_INVOKABLE void removeItem(int index);

};
#endif // SHOPPINGLIST_H
