-- SAVE TRANSACTION / ROLLBACK TRANSACTION Örneği (Savepoint Example)
BEGIN TRANSACTION 
INSERT INTO Person 
VALUES('Mouse', 'Micky','500 South Buena Vista Street, Burbank','California',43)
SAVE TRANSACTION InsertStatement -- Kayıt Noktası oluşturur
DELETE Person WHERE PersonID=3
SELECT * FROM Person 
ROLLBACK TRANSACTION InsertStatement -- Bu noktaya geri döner, DELETE işlemi iptal olur
COMMIT -- Kalan INSERT işlemini onaylar
SELECT * FROM Person
-------------------------------

-- COMMIT ve @@TRANCOUNT Örneği (COMMIT and @@TRANCOUNT Example)
Begin Tran
Update Customers
Set CompanyName = 'Batuhan',
ContactName ='Ozler'
Where CustomerID = '1'
Select @@TRANCOUNT As OpenTransactions -- Açık işlem sayısını gösterir (1)
Commit Tran
Select @@TRANCOUNT As OpenTransactions -- İşlem kapatıldı (0)

-- ROLLBACK Örneği (ROLLBACK Example)
Begin Tran
Update Customers
Set CompanyName = 'Batuhan',
ContactName = 'Ozler'
Where CustomerID = '3'
Select * From Customers Where CustomerID = 3 -- Değişmiş veriyi gösterir
Rollback Tran -- Değişikliği geri alır
Select * From Customers Where CustomerID = 3 -- Eski veriyi gösterir
