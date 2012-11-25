CREATE TABLE users(userID INTEGER PRIMARY KEY AUTOINCREMENT, mail VARCHAR(100), name VARCHAR(20), female BOOLEAN, age INTEGER, height DOUBLE, weight DOUBLE);
CREATE TABLE weights(weightID INTEGER PRIMARY KEY AUTOINCREMENT,  time INTEGER, weight DOUBLE);
CREATE TABLE rounds(roundID INTEGER PRIMARY KEY AUTOINCREMENT, startTime INTEGER, endTime INTEGER, targetWeight DOUBLE, status INTEGER);

CREATE TABLE sections(sectionID INTEGER PRIMARY KEY AUTOINCREMENT,sectionName VARCHAR(50), sectionOffset DOUBLE);
CREATE TABLE categories(categoryID INTEGER PRIMARY KEY, categoryName VARCHAR(100) NOT NULL, refSectionID INTEGER, FOREIGN KEY(refSectionID) REFERENCES sections(sectionID));
CREATE TABLE items(itemID INTEGER PRIMARY KEY AUTOINCREMENT, itemName TEXT, location TEXT, isRead BOOLEAN, isMarked BOOLEAN, releasedTime INTEGER, markedTime INTEGER, refCategoryID INTEGER, FOREIGN KEY(refCategoryID) REFERENCES categories(cagegoryID));
CREATE TABLE sections_import(sectionName VARCHAR(50), sectionOffset DOUBLE);
CREATE TABLE categories_import(categoryID INTEGER PRIMARY KEY, categoryName VARCHAR(100) NOT NULL, refSectionID INTEGER, FOREIGN KEY(refSectionID) REFERENCES sections(sectionID));
CREATE TABLE items_import(itemName TEXT, location TEXT, isRead BOOLEAN, isMarked BOOLEAN, releasedTime INTEGER, markedTime INTEGER, refCategoryID INTEGER, FOREIGN KEY(refCategoryID) REFERENCES categories(cagegoryID));

.separator "|"
.import ./sections.csv sections_import
.import ./categories.csv  categories_import
.import ./items.csv items_import
INSERT INTO sections(sectionName, sectionOffset) SELECT * FROM sections_import;
INSERT INTO categories(categoryID, categoryName, refSectionID) SELECT * FROM categories_import;
INSERT INTO items(itemName, location, isRead, isMarked, releasedTime, markedTime, refCategoryID) SELECT * FROM items_import;

DROP TABLE sections_import;
DROP TABLE categories_import;
DROP TABLE items_import;

UPDATE items SET releasedTime=64092211200;