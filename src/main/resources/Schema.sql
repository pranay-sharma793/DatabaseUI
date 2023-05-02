create table items (
   ITEM varchar(25),
   UNITWEIGHT decimal(10,2),
   primary key(ITEM)
);

create table busEntities (
   ENTITY varchar(25),
   SHIPLOC varchar(25),
   address varchar(25),
   PHONE int(10),
   WEB varchar(100),
   CONTACT int(20),
   primary key(ENTITY)
);

create table billOfMaterials(
PRODITEM varchar(25),
MATITEM varchar(25),
QTYMATPERITEM int(10),
primary key(PRODITEM, MATITEM)
--foreign key(PRODITEM) references items(ITEM),
--foreign key(MATITEM) references items(ITEM)
);

create table supplierDiscounts (
   SUPPLIER varchar(25),
   AMT1 int(10),
   DISC1 decimal(10,2),
   AMT2 int(10),
   DISC2 decimal(10,2),
   primary key(SUPPLIER)
);

create table supplyUnitPricing(SUPPLIER varchar(25),
ITEM varchar(25),
PPU int(10),
primary key(SUPPLIER,ITEM)
--foreign key(ITEM) references items(ITEM)
);

create table manufDiscounts(
MANUF varchar(25),
AMT1 int(10),
DISC1 decimal(10,2),
primary key(MANUF));

create table manufUnitPricing
(MANUF varchar(25),
PRODITEM varchar(25),
SETUPCOST int(10),
PRODCOSTPERUNIT int(10),
primary key(MANUF,PRODITEM)
--foreign key(PRODITEM) references items(ITEM)
);

create table shippingPricing(
SHIPPER varchar(25),
FROMLOC  varchar(25),
TOLOC varchar(25),
MINPACKAGEPRICE int(10),
PRICEPERLB int(10),
AMT1 int(10),
DISC1 decimal(10,2),
AMT2 int (10),
DISC2 decimal(10,2),
primary key (SHIPPER, FROMLOC, TOLOC));

create table customerDemand(
CUSTOMER varchar(25),
ITEM varchar(25),
QTY int(10),
primary key(CUSTOMER, ITEM)
--foreign key(ITEM) references items(ITEM),
--foreign key(CUSTOMER) references busEntities(ENTITY)
 );

create table supplyOrders(
ITEM varchar(25),
SUPPLIER varchar(25),
QTY int(10),
primary key(ITEM, SUPPLIER)
--foreign key(ITEM) references items(ITEM),
--foreign key(SUPPLIER) references BUSENTITIES(ENTITY)
);

create table manufOrders(
ITEM varchar(25),
MANUF varchar(25),
QTY int(10),
primary key(ITEM, MANUF)
--foreign key(ITEM) references items(ITEM),
--foreign key(MANUF) references BUSENTITIES(ENTITY)
);


create table shipOrders(
ITEM varchar(25),
SHIPPER varchar(25),
SENDER varchar(25),
RECIPIENT varchar(25),
QTY int(10),
primary key(ITEM, SHIPPER, SENDER, RECIPIENT)
--foreign key(SHIPPER) REFERENCES busEntities(ENTITY),
--foreign key(ITEM) REFERENCES items(ITEM),
--foreign key(sender) REFERENCES BUSENTITIES(ENTITY),
--foreign key(recipient) REFERENCES BUSENTITIES(ENTITY)
);



-- Name: PRANAY SHARMA
-- G# G01393761



-- Query 1

create view shippedVsCustDemand as
select cd.customer AS CUSTOMER, cd.item AS ITEM, SUM(IFNULL(so.qty, 0)) AS SUPPLIEDQTY, cd.qty AS DEMANDQTY
FROM customerDemand cd
LEFT JOIN shipOrders so ON cd.item = so.item AND cd.customer = so.recipient
GROUP BY cd.CUSTOMER, cd.ITEM, cd.QTY
ORDER BY cd.CUSTOMER, cd.ITEM;

-- Query 2
create view totalManufItems AS
select mo.item as ITEM, SUM(mo.QTY) as TOTALMANUFQTY
from manufOrders mo
group by ITEM
order by ITEM;


-- Query 3
create view matsUsedVsShipped as
select mo.manuf as MANUF, bom.matItem as MATITEM, SUM(mo.qty*bom.qtyMatPerItem) as REQUIREDQTY, IFNULL(s.shippedQty, 0) as SHIPPEDQTY from billOfMaterials bom
JOIN manufOrders mo ON mo.item = bom.prodItem
-- LEFT JOIN shipOrders so ON mo.manuf = so.recipient AND so.item = bom.matItem
LEFT OUTER JOIN (
    SELECT so.recipient, so.item, SUM(so.qty) AS shippedQty
    FROM shipOrders so
    GROUP BY so.recipient, so.item
) s ON mo.manuf = s.recipient AND s.item = bom.matItem
group by MANUF, MATITEM
order by MANUF, MATITEM;



-- Query 4
create view producedVsShipped as
select mo.item as ITEM, mo.manuf as MANUF,
       SUM(IFNULL(so.qty,0)) as SHIPPEDOUTQTY,
       SUM(mo.qty) as ORDEREDQTY
FROM manufOrders mo
LEFT OUTER JOIN shipOrders so
  ON mo.item = so.item AND mo.manuf = so.sender
GROUP BY ITEM, MANUF
ORDER BY ITEM, MANUF;


-- Query 5
create view suppliedVsShipped as
SELECT supplyOrders.item as ITEM, supplyOrders.supplier as SUPPLIER, SUM(supplyOrders.qty) AS SUPPLIEDQTY, IFNULL(s.shippedQty, 0) AS SHIPPEDQTY
FROM supplyOrders
-- LEFT OUTER JOIN shipOrders ON supplyOrders.item = shipOrders.item AND supplyOrders.supplier = shipOrders.sender
LEFT OUTER JOIN (
  SELECT so.item, so.sender, SUM(so.qty) as shippedQty
  FROM shipOrders so
  GROUP BY so.item, so.sender
) s ON supplyOrders.item = s.item AND supplyOrders.supplier = s.sender
GROUP BY supplyOrders.item, supplyOrders.supplier
ORDER BY supplyOrders.item, supplyOrders.supplier;

-- Query 6
create view perSupplierCost as
SELECT DISTINCT sd.supplier AS SUPPLIER,
IFNULL(CASE
    WHEN s.total_cost > sd.amt1 THEN (sd.amt1 + ((sd.amt2 - sd.amt1) * (1-sd.disc1)) + ((s.total_cost - sd.amt2)  * (1-sd.disc2)))
    WHEN s.total_cost BETWEEN sd.amt1 AND sd.amt2 THEN (sd.amt1 + ((sd.amt2 - sd.amt1) * (1-sd.disc1)))
    ELSE s.total_cost
    END, 0) AS COST
FROM supplierDiscounts sd
LEFT OUTER JOIN (
  SELECT t.supplier AS SUPPLIER, SUM(t.qty * t.ppu) AS total_cost
  FROM (
    SELECT so.supplier, so.qty, sup.ppu
    FROM supplyOrders so, supplyUnitPricing sup
    WHERE so.supplier = sup.supplier AND so.item = sup.item
  ) t
  GROUP BY t.supplier
) s ON sd.supplier = s.supplier
ORDER BY SUPPLIER;


-- Query 7
CREATE view v1 as
SELECT mo.manuf, mo.item, mo.qty, mup.setupCost, mup.prodCostPerUnit
FROM manufOrders mo
INNER JOIN manufUnitPricing mup
ON mo.manuf = mup.manuf AND mo.item = mup.prodItem;

CREATE view v2 as
SELECT m.manuf, SUM(m.prodCostPerUnit * m.qty + m.setupCost) AS base_cost
FROM v1 m
GROUP BY m.manuf;

CREATE view perManufCost as
SELECT md.manuf AS MANUF,
IFNULL(CASE
        WHEN m.base_cost > md.amt1 THEN ((m.base_cost - md.amt1) * (1 - md.disc1)) + md.amt1
        ELSE m.base_cost
    END, 0 ) AS COST
FROM manufDiscounts md
LEFT OUTER JOIN v2 m
ON md.manuf = m.manuf
ORDER BY MANUF;


-- Query 8
create view v3 as
SELECT so.shipper, s.shipLoc as fromLoc, r.shipLoc as toLoc, IFNULL(SUM(I.unitWeight * so.qty),0) as weight
from items I, shipOrders so, busEntities s, busEntities r
WHERE so.sender = s.entity and so.recipient = r.entity
and I.item = so.item
GROUP BY so.shipper, s.shipLoc, r.shipLoc;

create view v4 as
SELECT w.weight, sp.shipper, w.fromLoc, w.toLoc,
IFNULL(CASE
  WHEN (w.weight * sp.pricePerLb) <= sp.amt1
  THEN
      CASE
        WHEN sp.minPackagePrice > (w.weight * sp.pricePerLb) THEN sp.minPackagePrice
        ELSE (w.weight * sp.pricePerLb)
      END
  WHEN (w.weight * sp.pricePerLb) BETWEEN sp.amt1 AND sp.amt2
  THEN
      CASE
        WHEN sp.minPackagePrice > (sp.amt1 + (((w.weight * sp.pricePerLb) - sp.amt1) * (1 - sp.disc1))) THEN sp.minPackagePrice
        ELSE (sp.amt1 + (((w.weight * sp.pricePerLb) - sp.amt1) * (1 - sp.disc1)))
        END
  ELSE
      CASE
        WHEN sp.minPackagePrice > (sp.amt1 + ((sp.amt2 - sp.amt1) * (1 - sp.disc1)) + (((w.weight * sp.pricePerLb) - sp.amt2) * (1 - sp.disc2))) THEN sp.minPackagePrice
        ELSE (sp.amt1 + ((sp.amt2 - sp.amt1) * (1 - sp.disc1)) + (((w.weight * sp.pricePerLb) - sp.amt2) * (1 - sp.disc2)))
      END
 END,0) AS CostAfterDiscount
from shippingPricing sp
LEFT OUTER JOIN v3 w
  ON w.shipper = sp.shipper and w.fromLoc = sp.fromLoc and w.toLoc = sp.toLoc
ORDER BY sp.shipper;

create view perShipperCost as
SELECT v4.shipper as SHIPPER, SUM(v4.CostAfterDiscount) as COST from v4
GROUP BY SHIPPER
ORDER BY SHIPPER;


-- Query 9
create view totalCostBreakDown as
SELECT s.supplyCost AS SUPPLYCOST, m.manufCost AS MANUFCOST, sh.shippingCost AS SHIPPINGCOST, (s.supplyCost + m.manufCost + sh.shippingCost) AS TOTALCOST
FROM
(
  SELECT SUM(cost) AS supplyCost
  FROM perSupplierCost
) s,
(
  SELECT SUM(cost) AS manufCost
  FROM perManufCost
) m,
(
  SELECT SUM(cost) AS shippingCost
  FROM perShipperCost
) sh;


-- Query 10
CREATE view customersWithUnsatisfiedDemand AS
SELECT DISTINCT cd.customer AS CUSTOMER
FROM customerDemand cd
LEFT OUTER JOIN (
    SELECT so.recipient, so.item, IFNULL(SUM(so.qty), 0) AS shipped_qty
    FROM shipOrders so
    GROUP BY so.recipient, so.item
) AS so ON cd.customer = so.recipient AND cd.item = so.item
WHERE cd.qty > IFNULL(so.shipped_qty, 0)
ORDER BY CUSTOMER;


--Query 11
CREATE view suppliersWithUnsentOrders AS
SELECT DISTINCT sod.supplier AS SUPPLIER
FROM supplyOrders sod
LEFT OUTER JOIN (
    SELECT sender, item, IFNULL(SUM(qty), 0) AS SENT
    FROM shipOrders
    GROUP BY sender, item
) so ON sod.supplier = so.sender AND sod.item = so.item
WHERE IFNULL(sod.qty, 0) > IFNULL(so.SENT, 0)
ORDER BY sod.SUPPLIER;

-- Query 12
create view manufsWoutEnoughMats as
SELECT matsUsedVsShipped.MANUF FROM matsUsedVsShipped
WHERE matsUsedVsShipped.SHIPPEDQTY < matsUsedVsShipped.REQUIREDQTY
GROUP BY MANUF
ORDER BY MANUF;

-- Query 13
create view manufsWithUnsentOrders as
SELECT mo.manuf AS MANUF FROM manufOrders mo
LEFT OUTER JOIN shipOrders so ON so.sender = mo.manuf AND so.item = mo.item
WHERE mo.qty > IFNULL(so.qty, 0)
GROUP BY MANUF
ORDER BY MANUF;

CREATE VIEW testingViews AS
SELECT ENTITY, PHONE
FROM busEntities;
