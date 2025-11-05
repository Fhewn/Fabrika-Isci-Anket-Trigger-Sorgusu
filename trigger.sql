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