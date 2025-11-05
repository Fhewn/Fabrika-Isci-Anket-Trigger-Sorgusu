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




