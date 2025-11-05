```
🇹🇷 Türkçe Anlatım
📝 Proje Başlığı: SQL Server Tetikleyicileri ve İşlemleri (Triggers & Transactions) Örnekleri
Bu SQL dosyası (trigger.sql), SQL Server veritabanı yönetim sisteminde kullanılan Tetikleyiciler (Triggers) ve İşlemler (Transactions) kavramlarını göstermektedir. Dosya, veritabanı olaylarına (INSERT, UPDATE, DELETE gibi DML işlemleri) otomatik olarak tepki veren özel saklı yordamlar olan tetikleyicilerin nasıl oluşturulacağını ve kullanılacağını gösteren çeşitli örnekler içermektedir. Ayrıca, veri bütünlüğünü sağlamak için kullanılan işlem bloklarına (BEGIN TRANSACTION, COMMIT, ROLLBACK TRANSACTION) dair uygulamalar da mevcuttur.

🔑 Anahtar Kavramlar
DML Tetikleyicileri (DML Triggers): INSERT, UPDATE ve DELETE gibi Veri Manipülasyon Dili (DML) olaylarına yanıt veren tetikleyiciler.

AFTER/FOR Tetikleyicileri: DML olayından sonra çalışan tetikleyicilerdir, genellikle denetim (logging) veya veri bütünlüğü işlemlerinde kullanılırlar.

Sanal Tablolar (INSERTED ve DELETED): Tetikleyicilerin içinde, işlemden etkilenen verileri geçici olarak tutan özel sanal tablolardır.

INSERT tetikleyicilerinde INSERTED tablosu yeni eklenen satırları içerir.

UPDATE tetikleyicilerinde INSERTED yeni, DELETED eski satırları içerir.

İşlemler (Transactions): Bir dizi SQL komutunu tek bir mantıksal çalışma birimi olarak yürüten bloklardır; ya hepsi başarılı olur (COMMIT) ya da hepsi başarısız olursa geri alınır (ROLLBACK).

BEGIN TRAN / COMMIT TRAN: İşlemi başlatır ve sonlandırır.

ROLLBACK TRAN: İşlemi veya bir işlem içindeki kayıt noktasını (Savepoint) geri alır.

SAVE TRANSACTION: İşlem içinde geri alma noktası (Savepoint) oluşturur.

🛠️ Dosya İçeriği Özeti
Dosya, aşağıdaki işlemleri gerçekleştiren SQL kod parçalarını içerir:

Denetim (Audit) Tetikleyicileri:

trgAnektSonuc (Muhtemelen Secim tablosu için INSERT sonrası denetim amaçlı).

dbo.trgEmployeeUpdate ( Employee tablosu için UPDATE sonrası EmpLog tablosuna kayıt ekleme).

dbo.trgEmployeeInsert ( Employee tablosu için INSERT sonrası EmpLog tablosuna kayıt ekleme).

trgAnketSonuc ( Kisi tablosu için INSERT sonrası AnketLog tablosuna kayıt ekleme).

Veri Girişi Örneği: Kisi tablosuna veri ekleme (INSERT).

Karmaşık Tetikleyici Örneği: trgAnketSonucInsert ( Kisi tablosu için AFTER INSERT tetikleyicisi, karmaşık mantık ve hatalı kendi kendine INSERT girişimi içeriyor).

Rastgele Veri Seçme: Kisi tablosundan rastgele bir kayıt seçme örneği (NEWID() kullanımı).

İşlem (Transaction) Örnekleri:

SAVE TRANSACTION ve ROLLBACK TRANSACTION kullanarak bir işlem içinde belirli bir noktaya geri dönme.

Basit UPDATE işlemi ve @@TRANCOUNT ile işlem sayısını kontrol etme.

Başlatılan bir işlemin ROLLBACK ile geri alınarak tablodaki değişimin iptal edilmesi.
```
🇬🇧 English Explanation
📝 Project Title: SQL Server Triggers and Transactions Examples
This SQL file (trigger.sql) demonstrates the concepts of Triggers and Transactions used within the SQL Server database management system. The file contains various examples illustrating how to create and use triggers—special stored procedures that automatically respond to database events (DML operations like INSERT, UPDATE, DELETE). It also includes applications of transaction blocks (BEGIN TRANSACTION, COMMIT, ROLLBACK TRANSACTION) used to ensure data integrity.

🔑 Key Concepts
DML Triggers: Triggers that respond to Data Manipulation Language (DML) events such as INSERT, UPDATE, and DELETE.

AFTER/FOR Triggers: Triggers that execute after the DML event, commonly used for auditing (logging) or data integrity processes.

Virtual Tables (INSERTED and DELETED): Special virtual tables that temporarily hold the data affected by the operation inside the triggers.

In INSERT triggers, the INSERTED table contains the newly added rows.

In UPDATE triggers, INSERTED contains the new rows, and DELETED contains the old rows.

Transactions: Blocks that execute a series of SQL commands as a single logical unit of work; either all succeed (COMMIT) or all are reverted if any fail (ROLLBACK).

BEGIN TRAN / COMMIT TRAN: Starts and terminates the transaction.

ROLLBACK TRAN: Reverts the transaction or a savepoint within a transaction.

SAVE TRANSACTION: Creates a savepoint within the transaction for partial rollback.

🛠️ File Content Summary
The file contains SQL code snippets that perform the following operations:

Auditing Triggers:

trgAnektSonuc (Likely for auditing purposes after an INSERT on the Secim table).

dbo.trgEmployeeUpdate (Inserts a record into the EmpLog table after an UPDATE on the Employee table).

dbo.trgEmployeeInsert (Inserts a record into the EmpLog table after an INSERT on the Employee table).

trgAnketSonuc (Inserts a record into the AnketLog table after an INSERT on the Kisi table).

Data Insertion Example: Inserting data into the Kisi table (INSERT).

Complex Trigger Example: trgAnketSonucInsert (AFTER INSERT trigger for Kisi table, containing complex logic and an erroneous self-INSERT attempt).

Random Data Selection: Example of selecting a random record from the Kisi table (using NEWID()).

Transaction Examples:

Using SAVE TRANSACTION and ROLLBACK TRANSACTION to revert to a specific point within a transaction.

Simple UPDATE operation and checking the transaction count with @@TRANCOUNT.

Canceling a change in a table by rolling back a started transaction.

