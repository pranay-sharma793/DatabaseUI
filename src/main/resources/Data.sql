INSERT INTO items (item, unitWeight)
VALUES ('drawer', 10),
       ('leg', 10),
       ('table top', 20),
       ('desk top', 15),
       ('end table', 50),
       ('desk', 65),
       ('table', 70),
       ('round table', 30);


INSERT INTO busEntities (entity, shipLoc, address, web, contact)
VALUES
('UPS', 'New York', 'Manhattan', 'ups@gmail.com', 1234),
('FedEx', 'California', 'LA', 'fedex@gmail.com', 2345),
('manuf1', 'Washington', 'Man1 St', 'manf1@yahoo.com', 3575),
('manuf2', 'California', 'Man2 Bd', 'manuf2@hotmail.com', 3576),
('manuf3', 'California', 'Man3 Bd', 'manuf3@hotmail.com', 3577),
('supplier1', 'New York', 'Supp1 Ave', 'supplier1@hotmail.com', 1975),
('supplier2', 'California', 'Supp2 Dr', 'supplier2@gmail.com', 1976),
('supplier3', 'New York', 'Supp3 Dr', 'supplier3@gmail.com', 1977),
('customer1', 'Washington', 'Cust1 Dr', 'customer1@yahoo.com', 7531),
('customer2', 'Washington', 'Cust2 Dr', 'customer2@yahoo.com', 7532),
('customer3', 'California', 'Cust3 Dr', 'customer3@gmail.com', 7533);

INSERT INTO billOfMaterials (prodItem, matItem, qtyMatPerItem)
VALUES
('end table', 'leg', 4),
('end table', 'drawer', 1),
('table', 'leg', 4),
('table', 'table top', 1),
('desk', 'desk top', 1),
('desk', 'leg', 4),
('round table', 'table top', 1),
('round table', 'leg', 1);

INSERT INTO supplierDiscounts (supplier, amt1, disc1, amt2, disc2)
VALUES
('supplier1', 2000, 0.15, 3000, 0.25),
('supplier2', 1500, 0.12, 2500, 0.28),
('supplier3', 1700, 0.18, 2000, 0.22);

INSERT INTO supplyUnitPricing (supplier, item, ppu)
VALUES
('supplier1', 'drawer', 200),
('supplier1', 'leg', 150),
('supplier1', 'table top', 350),
('supplier1', 'desk top', 300),
('supplier1', 'table', 2000),
('supplier1', 'end table', 1000),
('supplier1', 'round table', 1750),
('supplier1', 'desk', 1750),
('supplier2', 'drawer', 215),
('supplier2', 'leg', 125),
('supplier2', 'table top', 365),
('supplier2', 'desk top', 290),
('supplier2', 'table', 2079),
('supplier2', 'end table', 1100),
('supplier2', 'round table', 1475),
('supplier2', 'desk', 1549),
('supplier3', 'drawer', 325),
('supplier3', 'leg', 253),
('supplier3', 'table top', 345),
('supplier3', 'desk top', 350),
('supplier3', 'table', 2179),
('supplier3', 'end table', 1895),
('supplier3', 'round table', 1575),
('supplier3', 'desk', 1149);

INSERT INTO manufDiscounts (manuf, amt1, disc1)
VALUES ('manuf1', 8000, 0.18),
       ('manuf2', 7200, 0.13),
       ('manuf3', 6200, 0.11);

INSERT INTO manufUnitPricing (manuf, prodItem, setUpCost, prodCostPerUnit)
VALUES ('manuf1', 'table', 5000, 1200),
       ('manuf1', 'desk', 4735, 1075),
       ('manuf1', 'round table', 3945, 895),
       ('manuf1', 'end table', 1500, 445),
       ('manuf2', 'table', 3000, 2200),
       ('manuf2', 'desk', 2700, 1575),
       ('manuf2', 'round table', 3945, 1895),
       ('manuf2', 'end table', 2000, 445),
       ('manuf3', 'table', 3200, 1500),
       ('manuf3', 'desk', 2500, 1475),
       ('manuf3', 'round table', 2945, 1895),
       ('manuf3', 'end table', 2200, 545);

INSERT INTO shippingPricing (shipper, FROMLOC, TOLOC, MINPACKAGEPRICE, PRICEPERLB, amt1, disc1, amt2, disc2)
VALUES
    ('UPS', 'New York', 'New York', 200, 10, 300, 0.10, 800, 0.22),
    ('UPS', 'New York', 'Washington', 500, 15, 300, 0.12, 800, 0.3),
    ('UPS', 'New York', 'California', 500, 25, 500, 0.2, 2000, 0.39),
    ('UPS', 'Washington', 'New York', 400, 14, 285, 0.12, 915, 0.3),
    ('UPS', 'Washington', 'Washington', 320, 11, 457, 0.11, 627, 0.4),
    ('UPS', 'Washington', 'California', 400, 20, 500, 0.18, 1800, 0.28),
    ('UPS', 'California', 'New York', 500, 22, 470, 0.16, 1700, 0.19),
    ('UPS', 'California', 'Washington', 1500, 17, 523, 0.12, 1200, 0.55),
    ('UPS', 'California', 'California', 1300, 14, 559, 0.11, 875, 0.33),
    ('FedEx', 'New York', 'New York', 200, 10, 300, 0.10, 800, 0.22),
    ('FedEx', 'New York', 'Washington', 350, 14, 285, 0.11, 700, 0.3),
    ('FedEx', 'New York', 'California', 625, 24, 700, 0.21, 1800, 0.34),
    ('FedEx', 'Washington', 'New York', 450, 13, 500, 0.17, 1815, 0.35),
    ('FedEx', 'Washington', 'Washington', 385, 13, 475, 0.12, 875, 0.33),
    ('FedEx', 'Washington', 'California', 800, 20, 625, 0.15, 2000, 0.38),
    ('FedEx', 'California', 'New York', 625, 21, 450, 0.15, 1700, 0.2),
    ('FedEx', 'California', 'Washington', 750, 17, 400, 0.1, 1300, 0.4),
    ('FedEx', 'California', 'California', 600, 15, 375, 0.1, 1000, 0.35);

INSERT INTO customerDemand (customer, item, qty)
VALUES ('customer1', 'table', 6),
('customer1', 'drawer', 12),
('customer1', 'desk', 3),
('customer2', 'round table', 15),
('customer2', 'leg', 10),
('customer2', 'end table', 5),
('customer3', 'end table', 7),
('customer3', 'desk top', 14),
('customer3', 'desk', 21);


INSERT INTO supplyOrders (item, supplier, qty)
VALUES ('table', 'supplier1', 15),
('table', 'supplier2', 20),
('drawer', 'supplier3', 18),
('desk', 'supplier1', 17);


INSERT INTO manufOrders (item, manuf, qty)
VALUES ('desk', 'manuf1', 15),
       ('end table', 'manuf1', 5),
       ('desk', 'manuf2', 10),
       ('end table', 'manuf3', 150);

INSERT INTO shipOrders (item, shipper, sender, recipient, qty)
VALUES ('table', 'FedEx', 'supplier1', 'customer1', 12),
       ('table', 'FedEx', 'supplier2', 'customer1', 40),
       ('desk', 'UPS', 'supplier1', 'customer2', 2),
       ('leg', 'FedEx', 'supplier1', 'manuf1', 150),
       ('desk top', 'FedEx', 'supplier2', 'manuf1', 70),
       ('drawer', 'UPS', 'supplier3', 'manuf1', 100),
       ('leg', 'UPS', 'supplier3', 'manuf2', 200),
       ('desk top', 'FedEx', 'supplier1', 'manuf2', 200),
       ('drawer', 'UPS', 'supplier2', 'manuf3', 5),
       ('leg', 'FedEx', 'supplier3', 'manuf3', 50),
       ('desk', 'FedEx', 'manuf1', 'customer2', 14),
       ('desk', 'UPS', 'manuf2', 'customer1', 10),
       ('round table', 'FedEx', 'manuf3', 'customer1', 2),
       ('end table', 'UPS', 'manuf3', 'customer1', 2),
       ('desk', 'UPS', 'supplier2', 'customer1', 15),
       ('drawer', 'UPS', 'manuf2', 'customer1', 15),
       ('end table', 'UPS', 'manuf1', 'customer3', 1);
