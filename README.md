# 💾 SQL Server Tetikleyicileri ve İşlemleri (Triggers & Transactions) Örnekleri

Bu depo, **SQL Server** veritabanı yönetim sisteminde kullanılan **Tetikleyiciler (Triggers)** ve **İşlemler (Transactions)** kavramlarını uygulamalı olarak gösteren `trigger.sql` dosyasını içermektedir.

Bu örnekler, veri bütünlüğünü sağlamak, denetim (auditing) kayıtları tutmak ve veritabanı olaylarına otomatik olarak tepki vermek için bu güçlü araçların nasıl kullanılacağını anlamanıza yardımcı olmayı amaçlar.

## 🇹🇷 Türkçe Anlatım

### 📝 Proje Başlığı
SQL Server Tetikleyicileri ve İşlemleri (Triggers & Transactions) Örnekleri

### Proje Amacı
Bu SQL dosyası (`trigger.sql`), SQL Server'da DML (Veri Manipülasyon Dili) olaylarına otomatik yanıt veren **Tetikleyicilerin** oluşturulmasını ve kullanılmasını gösteren çeşitli örnekler sunar. Ayrıca, bir dizi SQL komutunu tek bir mantıksal çalışma birimi olarak yürüten ve veri bütünlüğünü sağlayan **İşlem (Transaction)** bloklarına dair uygulamalar da mevcuttur.

### 🔑 Anahtar Kavramlar

* **DML Tetikleyicileri (DML Triggers):** `INSERT`, `UPDATE` ve `DELETE` gibi DML olaylarına yanıt veren, veritabanı tarafında çalışan özel saklı yordamlardır.
* **AFTER/FOR Tetikleyicileri:** DML olayı tamamlandıktan **sonra** çalışan tetikleyicilerdir. Genellikle denetim (logging) veya karmaşık veri bütünlüğü işlemlerinde kullanılırlar.
* **Sanal Tablolar (`INSERTED` ve `DELETED`):** Tetikleyicilerin içinde, işlemden etkilenen verileri geçici olarak tutan özel sanal tablolardır:
    * **`INSERTED`:** Yeni eklenen veya güncellenen satırların (yeni değerler) kopyasını içerir.
    * **`DELETED`:** Silinen veya güncellenen satırların (eski değerler) kopyasını içerir.
* **İşlemler (Transactions):** Bir dizi SQL komutunun atomik (bölünmez) bir şekilde yürütülmesini sağlayan bloklardır.
    * `BEGIN TRAN / COMMIT TRAN`: İşlemi başlatır ve sonlandırır (başarıyla kaydeder).
    * `ROLLBACK TRAN`: İşlemi geri alır ve veritabanını işlemin başlangıç durumuna döndürür.
    * `SAVE TRANSACTION`: İşlem içinde geri alma noktası (Savepoint) oluşturur.

### 🛠️ Dosya İçeriği Özeti

`trigger.sql` dosyası, aşağıdaki temel işlevleri gösteren SQL kod parçalarını içerir:

| İşlev Türü | Örnek Tetikleyiciler / İşlemler | Açıklama |
| :--- | :--- | :--- |
| **Denetim (Audit) Tetikleyicileri** | `dbo.trgEmployeeUpdate`, `dbo.trgEmployeeInsert`, `trgAnketSonuc` | `Employee` ve `Kisi` gibi tablolardaki DML olaylarından sonra `EmpLog` ve `AnketLog` tablolarına kayıt ekleyerek değişiklikleri izler. |
| **Veri Girişi Örneği** | `INSERT INTO Kisi...` | `Kisi` tablosuna standart veri ekleme işlemi. |
| **Karmaşık Tetikleyici Örneği** | `trgAnketSonucInsert` | `Kisi` tablosu için `AFTER INSERT` tetikleyicisi, karmaşık mantık ve **kendini tetikleme** (self-INSERT) risklerine dair bir örneği gösterir. |
| **Rastgele Veri Seçme** | `ORDER BY NEWID()` | `Kisi` tablosundan rastgele bir kayıt seçme yöntemi. |
| **İşlem (Transaction) Örnekleri** | `SAVE TRANSACTION`, `ROLLBACK TRANSACTION`, `@@TRANCOUNT` | İşlem içinde belirli bir noktaya geri dönme, işlem sayısını kontrol etme ve başlatılan bir işlemi geri alma uygulamaları. |

---

## 🇬🇧 English Explanation

### 📝 Project Title
SQL Server Triggers and Transactions Examples

### Project Goal
This SQL file (`trigger.sql`) provides various examples illustrating how to create and use **Triggers** in SQL Server that automatically respond to DML (Data Manipulation Language) events. It also includes applications of **Transaction** blocks, which execute a series of SQL commands as a single logical unit of work and ensure data integrity.

### 🔑 Key Concepts

* **DML Triggers:** Special stored procedures that execute on the database side in response to DML events like `INSERT`, `UPDATE`, and `DELETE`.
* **AFTER/FOR Triggers:** Triggers that execute **after** the DML event is completed. They are commonly used for auditing (logging) or enforcing complex data integrity rules.
* **Virtual Tables (`INSERTED` and `DELETED`):** Special virtual tables that temporarily hold the data affected by the operation inside the triggers:
    * **`INSERTED`:** Contains a copy of the newly added or updated rows (new values).
    * **`DELETED`:** Contains a copy of the deleted or updated rows (old values).
* **Transactions:** Blocks that ensure a series of SQL commands are executed atomically (as one indivisible unit).
    * `BEGIN TRAN / COMMIT TRAN`: Starts and terminates the transaction (successfully saves the changes).
    * `ROLLBACK TRAN`: Reverts the transaction, returning the database to the state before the transaction began.
    * `SAVE TRANSACTION`: Creates a savepoint within the transaction for partial rollback.

### 🛠️ File Content Summary

The `trigger.sql` file contains SQL snippets demonstrating the following core functionalities:

| Function Type | Example Triggers / Transactions | Description |
| :--- | :--- | :--- |
| **Auditing Triggers** | `dbo.trgEmployeeUpdate`, `dbo.trgEmployeeInsert`, `trgAnketSonuc` | Tracks changes by inserting records into `EmpLog` and `AnketLog` tables after DML events on tables like `Employee` and `Kisi`. |
| **Data Insertion Example** | `INSERT INTO Kisi...` | Standard data insertion into the `Kisi` table. |
| **Complex Trigger Example** | `trgAnketSonucInsert` | An `AFTER INSERT` trigger for the `Kisi` table, showing complex logic and an example of the risks associated with **self-triggering** (recursive INSERT). |
| **Random Data Selection** | `ORDER BY NEWID()` | A method for selecting a random record from the `Kisi` table. |
| **Transaction Examples** | `SAVE TRANSACTION`, `ROLLBACK TRANSACTION`, `@@TRANCOUNT` | Applications of reverting to a specific point within a transaction, checking the transaction count, and canceling a started transaction's changes. |





### 1. Tetikleyici Tanımlamaları (Trigger Definitions)
Bu blok, farklı tablolar için denetim (audit) ve loglama amacıyla kullanılan çeşitli `AFTER/FOR` Tetikleyicilerini içerir.

| Tetikleyici Adı | Tablo | Olay | Amaç |
| :--- | :--- | :--- | :--- |
| `trgAnektSonuc` | `Secim` | `INSERT` | Denetim amaçlı veri yakalama (Ancak kodda `Employee_Test_Audit` tablosuna INSERT yapılıyor). |
| `dbo.trgEmployeeUpdate` | `Employee` | `UPDATE` | `EmpLog` tablosuna güncelleme kaydı ekler. |
| `dbo.trgEmployeeInsert` | `Employee` | `INSERT` | `EmpLog` tablosuna ekleme kaydı ekler. |
| `trgAnketSonuc` | `Kisi` | `INSERT` | `AnketLog` tablosuna ekleme kaydı ekler. |




```
CREATE TRIGGER trgAnektSonuc 
ON  Secim
FOR INSERT
AS
declare @RecID int;
declare @empname varchar(100);
declare @empsal decimal(10,2);
declare @audit_action varchar(100);
select @empid=i.Emp_ID from inserted i;
select @empname=i.Emp_Name from inserted i;
select @empsal=i.Emp_Sal from inserted i;
set @audit_action='Inserted ';

insert into Employee_Test_Audit
(Emp_ID,Emp_Name,Emp_Sal,Audit_Action,Audit_Timestamp)
values(@empid,@empname,@empsal,@audit_action,getdate());

PRINT 'Triger İşlemi Tamamlandı.'
GO


CREATE TRIGGER dbo.trgEmployeeUpdate
ON dbo.Employee
AFTER UPDATE
AS
    INSERT INTO dbo.EmpLog(EmpID, Operation, UpdatedDate)
    SELECT EmployeeID,'UPDATE', GETDATE() FROM DELETED;



CREATE TRIGGER dbo.trgEmployeeInsert
ON dbo.Employee
FOR INSERT	
AS
    INSERT INTO dbo.EmpLog(EmpID, Operation, UpdatedDate)
    SELECT EmployeeID ,'INSERT',GETDATE() FROM INSERTED; --virtual table INSERTED
	
	
	
CREATE TRIGGER trgAnketSonuc
ON Kisi
FOR INSERT	
AS
    INSERT INTO AnketLog(SicilId, GirisTarihi, AdSoyad)
    SELECT RecId ,'INSERT',GETDATE() FROM INSERTED; 

Select * from Kisi
Select * from AnketLog

INSERT INTO Kisi(SiciIid
           ,AdSoyad
           ,Cinsiyet
           ,Yas
           ,Statunuz
           ,DepartmanAdi
		   ,Ay
           ,Yil)
     VALUES(0039
           ,'BatuhanOzler'
           ,'Erkek'
           ,18
           ,'Bilgi İşlem'
           ,12
           ,22)



Alter Trigger trgAnketSonucInsert
On Kisi
After Insert
As
Begin
Declare @RecId int ;
Set @RecId=(Select Top 1 RecId From Kisi Order By RecId Desc)
------------------------Giriş Tarihi------------------------
Declare @GirisTarihi datetime
Set @GirisTarihi=(Select GETDATE())
print @GirisTarihi
------------------------SicilId-----------------------
Declare @SicilId int
Set @SicilId =(Select Top 1 RecId From Kisi Order By SiciIid Desc)
------------------------Ad Soyad-----------------------
Declare @AdSoyad nvarchar(50)
Set @AdSoyad = (Select Top 1 AdSoyad From Kisi Order By  RecId Desc)
--------------------------------------------------------------------
Insert Into Kisi(RecId,SiciIid,AdSoyad)
Values(@RecId,@SicilId,@AdSoyad)
End
--------------------------------------------------------------------


Select Top 1 * From Kisi WHERE RecId Between 1 And 146 Order By NEWID();



BEGIN TRANSACTION 
INSERT INTO Person 
VALUES('Mouse', 'Micky','500 South Buena Vista Street, Burbank','California',43)
SAVE TRANSACTION InsertStatement
DELETE Person WHERE PersonID=3
SELECT * FROM Person 
ROLLBACK TRANSACTION InsertStatement
COMMIT
SELECT * FROM Person
-------------------------------
Begin Tran
Update Customers
Set CompanyName = 'Batuhan',
ContactName ='Ozler'
Where CustomerID = '1'
Select @@TRANCOUNT As OpenTransactions
Commit Tran
Select @@TRANCOUNT As OpenTransactions


Begin Tran
Update Customers
Set CompanyName = 'Batuhan',
ContactName = 'Ozler'
Where CustomerID = '3'
Select * From Customers Where CustomerID = 3
Rollback Tran
Select *  From Customers Where CustomerID = 3	
```

