CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE client (
    idclient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(30),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

CREATE TABLE product (
    idproduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletronico','Vestimenta','Brinquedo','Alimentos','Moveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

CREATE TABLE payment (
    idclient INT,
    id_payment INT,
    typePayment ENUM('Boleto','Cartão','Dois cartões'),
    limiteAvailable FLOAT,
    PRIMARY KEY (idclient, id_payment),
    CONSTRAINT fk_payment_client FOREIGN KEY (idclient) REFERENCES client(idclient)
);

CREATE TABLE orders (
    idorder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('cancelado','Confirmado','Em processamento') NOT NULL,
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_order_client FOREIGN KEY (idOrderClient) REFERENCES client(idclient)
);

SELECT idclient, Fname, Lname, CPF FROM client;

SELECT idproduct, Pname, category, avaliacao FROM product;

SELECT Fname, Lname, CPF
FROM client
WHERE Lname = 'Silva';

SELECT Pname, category, avaliacao
FROM product
WHERE category = 'Eletronico';

SELECT 
    idclient,
    CONCAT(Fname, ' ', Minit, ' ', Lname) AS Nome_Completo
FROM client;

SELECT 
    idorder,
    sendValue,
    (sendValue + 50) AS Valor_Total_Pedido
FROM orders;

SELECT Pname, category, avaliacao
FROM product
ORDER BY avaliacao DESC;

SELECT Fname, Lname
FROM client
ORDER BY Lname ASC;

SELECT 
    idOrderClient,
    COUNT(idorder) AS Total_Pedidos
FROM orders
GROUP BY idOrderClient
HAVING COUNT(idorder) > 1;

SELECT 
    orderStatus,
    AVG(sendValue) AS Media_Frete
FROM orders
GROUP BY orderStatus
HAVING AVG(sendValue) > 10;

SELECT 
    c.Fname,
    c.Lname,
    o.idorder,
    o.orderStatus
FROM client c
INNER JOIN orders o
    ON c.idclient = o.idOrderClient;

SELECT 
    c.Fname,
    c.Lname,
    o.idorder,
    o.orderStatus,
    p.typePayment
FROM client c
INNER JOIN orders o
    ON c.idclient = o.idOrderClient
INNER JOIN payment p
    ON c.idclient = p.idclient;

SELECT 
    c.Fname,
    c.Lname,
    COUNT(o.idorder) AS Total_Pedidos
FROM client c
LEFT JOIN orders o
    ON c.idclient = o.idOrderClient
GROUP BY c.idclient, c.Fname, c.Lname;
```
