CREATE SCHEMA IF NOT EXISTS pizzaoc;
USE pizzaoc;

CREATE TABLE ingredients (
  idIngredient INT PRIMARY KEY,
  Name VARCHAR(255),
  Quantity INT
);

CREATE TABLE recipe (
  idRecipe INT PRIMARY KEY,
  Name VARCHAR(255),
  CookingTime VARCHAR(255)
);

CREATE TABLE recipe_ingredient (
  id INT PRIMARY KEY AUTO_INCREMENT,
  idRecipe INT,
  idIngredient INT,
  IngredientQuantity INT,
  FOREIGN KEY (idRecipe) REFERENCES recipe(idRecipe),
  FOREIGN KEY (idIngredient) REFERENCES ingredients(idIngredient)
);

CREATE TABLE pizza (
  idPizza INT PRIMARY KEY,
  Name VARCHAR(255),
  Price DECIMAL(10, 2),
  Available TINYINT,
  idRecipe INT,
  FOREIGN KEY (idRecipe) REFERENCES recipe(idRecipe)
);

CREATE TABLE address (
  idAddress INT PRIMARY KEY,
  Street VARCHAR(255),
  City VARCHAR(255),
  State VARCHAR(255),
  ZipCode VARCHAR(10)
);

CREATE TABLE client (
  idConnexionClient INT PRIMARY KEY,
  ClientName VARCHAR(255),
  ClientAddressID INT,
  FOREIGN KEY (ClientAddressID) REFERENCES address(idAddress)
);

CREATE TABLE employee (
  idConnexionEmployee INT PRIMARY KEY,
  EmployeeName VARCHAR(255),
  Role ENUM('Manager', 'Chef', 'Delivery Driver')
);


CREATE TABLE pizzeria (
  idPizzeria INT PRIMARY KEY,
  PizzeriaName VARCHAR(255),
  PizzeriaAddressID INT,
  FOREIGN KEY (PizzeriaAddressID) REFERENCES address(idAddress)
);

CREATE TABLE shopping_cart (
  idCart INT PRIMARY KEY,
  idConnexionClient INT,
  TotalPrice DECIMAL(10, 2),
  FOREIGN KEY (idConnexionClient) REFERENCES client(idConnexionClient)
);

CREATE TABLE shopping_cart_pizza (
  idCart INT,
  idPizza INT,
  Quantity INT,
  PRIMARY KEY (idCart, idPizza),
  FOREIGN KEY (idCart) REFERENCES shopping_cart(idCart),
  FOREIGN KEY (idPizza) REFERENCES pizza(idPizza)
);

CREATE TABLE orders (
  idOrder INT PRIMARY KEY,
  idCart INT,
  idConnexionClient INT,
  idPizzeria INT,
  OrderDate DATE,
  PaymentStatus ENUM('Pending', 'Paid', 'Cancelled'),
  Status ENUM('Processing', 'Delivered', 'Cancelled'),
  Lost BOOLEAN,
  FOREIGN KEY (idCart) REFERENCES shopping_cart(idCart),
  FOREIGN KEY (idConnexionClient) REFERENCES client(idConnexionClient),
  FOREIGN KEY (idPizzeria) REFERENCES pizzeria(idPizzeria)
);

INSERT INTO ingredients (idIngredient, Name, Quantity)
VALUES
  (1090, 'Tomato Sauce', 50),
  (1290, 'Mozzarella Cheese', 100),
  (1390, 'Pepperoni', 30),
  (1490, 'Mushrooms', 20),
  (1590, 'Onions', 15),
  (1690, 'Green Peppers', 15),
  (1790, 'Olives', 10),
  (1890, 'Basil', 25);

INSERT INTO recipe (idRecipe, Name, CookingTime)
VALUES
  (1, 'Margarita', '15 minutes'),
  (2, 'Royale', '20 minutes'),
  (3, 'Vegan', '18 minutes');

INSERT INTO recipe_ingredient (idRecipe, idIngredient, IngredientQuantity)
VALUES
  (1, 1090, 50),
  (1, 1290, 100),
  (1, 1890, 25),
  (2, 1090, 50),
  (2, 1290, 100),
  (2, 1390, 30),
  (2, 1490, 20),
  (3, 1090, 50),
  (3, 1290, 100),
  (3, 1490, 20),
  (3, 1590, 15),
  (3, 1690, 15);

INSERT INTO pizza (idPizza, Name, Price, Available, idRecipe)
VALUES
  (1, 'Margarita Pizza', 10.99, 1, 1),
  (2, 'Royale Pizza', 12.99, 1, 2),
  (3, 'Vegan Pizza', 11.99, 0, 3);

INSERT INTO address (idAddress, Street, City, State, ZipCode)
VALUES
  (1, '123 Main St', 'Cityville', 'Stateville', '12345'),
  (2, '456 Elm St', 'Townville', 'Stateville', '67890'),
  (3, '789 Oak St', 'Villageville', 'Stateville', '45678'),
  (4, '10 Maple Ave', 'Suburbville', 'Stateville', '98765');

INSERT INTO client (idConnexionClient, ClientName, ClientAddressID)
VALUES
  (1, 'John Doe', 1),
  (2, 'Jane Smith', 2);

INSERT INTO pizzeria (idPizzeria, PizzeriaName, PizzeriaAddressID)
VALUES
  (1, 'Pizzeria 1', 3),
  (2, 'Pizzeria 2', 4);


INSERT INTO shopping_cart (idCart, idConnexionClient, TotalPrice)
VALUES
  (1, 1, 10.99),
  (2, 2, 23.98);

INSERT INTO shopping_cart_pizza (idCart, idPizza, Quantity)
VALUES
  (1, 1, 1),
  (2, 2, 2);

INSERT INTO orders (idOrder, idCart, idConnexionClient, idPizzeria, OrderDate, PaymentStatus, Status, Lost)
VALUES
  (1, 1, 1, 1, '2023-06-07', 'Pending', 'Processing', true),
  (2, 2, 2, 2, '2023-06-08', 'Paid', 'Delivered', false);


INSERT INTO employee (idConnexionEmployee, EmployeeName, Role)
VALUES
  (1, 'John Doe', 'Manager'),
  (2, 'Jane Smith', 'Chef'),
  (3, 'Alex Johnson', 'Delivery Driver');
