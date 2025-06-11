#ifndef RECIPEBOOKDATA_H
#define RECIPEBOOKDATA_H

#include <QString>
#include <QAbstractListModel>

struct RecipeBookData {
    QString name;
    QString description;
    QStringList ingredients;
    QVariantList quantity;
};

class RecipeBookModel : public QAbstractListModel {
    Q_OBJECT
    QList<RecipeBookData> m_items;
public:
    //do ogloszenia zmiany wartosci
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_SIGNAL void countChanged();
    Q_INVOKABLE int count() const;

    enum ItemRoles { //enumeracja, nadajemy nazwy liczbom
        NameRole = 900,
        DescriptionRole,
        IngredientsRole,
        QuantityRole
    };
    RecipeBookModel(); //konstruktor
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void loadItemsFromFile();

    void addItem(const RecipeBookData &item);
    Q_INVOKABLE void addItem(const QString &name, QString description, QStringList ingredients, QVariantList quantity);
    Q_INVOKABLE void addItemToFile(const QString &name, QString description, QStringList ingredients, QVariantList quantity);
    void addItemToFile(const RecipeBookData &item);
    Q_INVOKABLE void removeItem(int index);

};

#endif // RECIPEBOOKDATA_H
