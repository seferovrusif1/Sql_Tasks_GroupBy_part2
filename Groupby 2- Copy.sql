--CREATE DATABASE AzMB101_Rusif1
--use AzMB101_Rusif1

------------------------------------- Create Table's and Insert Values -----------------------------------------------

--CREATE TABLE Vezifeler
--(
--	Id int identity primary key,
--	Name nvarchar(30)
--)
--insert Vezifeler values('Kassir'),(N'Baş Kassir'),('Satıcı')

--CREATE TABLE Ischi
--(
--	Id int identity primary key,
--	Name nvarchar(30),
--	Surname nvarchar(30),
--	FatherName nvarchar(30),
--	Salary tinyint,
--	PositionId int REFERENCES Vezifeler(Id)
--)
--Alter table Ischi
--Alter COLUMN Salary money
--insert Ischi values('Kamran',N'Kerimli','Ali','600',3),('Esed',N'Aliyev','Ali','800',1),('Nihad',N'Seferli','Cavid','900',2)

--CREATE TABLE Filallar
--(
--	Id int identity primary key,
--	Name nvarchar(60)
--)
--insert Filallar values('Huseyn Cavid'),(N'Elmler'),('Kaktus dairesi'),('28 May')

--CREATE TABLE Mehsullar
--(
--	Id int identity primary key,
--	Name nvarchar(60),
--	PurchasePrice money,
--	SalePrice money
--)
--insert Mehsullar values(N'Şəkər tozu','1','1.3'),(N'Alma','0.5','0.7'),(N'Banan','2.4','2.8'),(N'Makaron','1.5','1.8')

--insert Mehsullar values('sas','2.67','89.55')

--CREATE TABLE Satish
--(
--	Id int identity primary key,
--	WorkerId int REFERENCES Ischi(Id),
--	FilialId int REFERENCES Filallar(Id),
--	SaleDate datetime
--)
--CREATE TABLE SatishMehsul
--(
--	Id int identity primary key,
--	SatishId int REFERENCES Satish(Id),
--	MehsulId int REFERENCES Mehsullar(Id)
	
--)
--insert Satish values(1,2,'2023-09-11 12:01:00'),(3,2,'2023-09-11 20:00:00'),(3,4,'2023-09-11 19:34:00'),(2,3,'2023-09-11 23:00:00'),(2,3,'2023-09-11 15:13:23')
--insert Satish values(1,1,'2023-11-11 09:00:00')
--insert Satish values(2,3,'2023-11-08 10:00:00')

--insert SatishMehsul values(1,1),(1,2),(1,3),(2,1),(2,5),(3,4),(4,3),(4,4),(5,4),(5,1)
--insert SatishMehsul values(7,1),(7,3)
--insert SatishMehsul values(8,5),(8,4)

------------------------------------- Query -----------------------------------------------

------- 1    

--SELECT i.Name as N'İşçi',m.Name as N'Məhsul', f.Name as Filial,m.PurchasePrice as N'Alış Qiyməti',m.SalePrice as  N'Satış Qiyməti' FROM Satish AS s
--JOIN SatishMehsul AS sm
--ON s.Id=sm.SatishId
--JOIN Mehsullar as m
--ON m.Id=sm.MehsulId
--JOIN Filallar AS f
--ON f.Id=s.FilialId
--JOIN Ischi AS i
--ON i.Id=s.workerId

--------- 2               
---------Group by isletmek ucun filial uzre ayri ayri total hesabladim


--Select f.Name as Filial,SUM(m.SalePrice) as 'Filial uzre total satish' FROM Satish AS s
--JOIN SatishMehsul AS sm
--ON s.Id=sm.SatishId
--JOIN Mehsullar AS m
--ON m.Id=sm.MehsulId
--JOIN Filallar as f
--ON f.Id=s.FilialId
--Group BY f.Name

--------- 3
---------Group by isletmek ucun filial uzre ayri ayri total hesabladim

--Select f.Name as Filial, Sum(m.SalePrice-m.PurchasePrice) as 'Cari Ayda Filial uzre Qazanc' FROM Satish AS s
--JOIN SatishMehsul AS sm
--ON s.Id=sm.SatishId
--JOIN Mehsullar AS m
--ON m.Id=sm.MehsulId
--JOIN Filallar as f
--ON f.Id=s.FilialId
--Where MONTH(GETDATE())=MONTH(s.SaleDate)
--Group BY f.Name










------------------------------------------- TAskin davami ikinci task-------------------------------------------

-------- 4

--select i.Name+' '+i.Surname+' '+i.FatherName as Fullname_ASA,Count(MehsulId) AS MEHSUL_SAYI from Satish as s
--JOIN SatishMehsul as sm
--ON s.Id=sm.SatishId
--Join Ischi as i
--ON i.Id=s.WorkerId
--GROUP BY i.Name+' '+i.Surname+' '+i.FatherName


---------- 5

----Her filial ve hemin filialda gun erzinde satilmish mehsullarin sayini gosteren cedvel ucun view

--Create view vw_FilalMehsul
--as
--select FilialId,COUNT(MehsulID)as say from Satish as s
--JOIN SatishMehsul as sm
--ON s.Id=sm.SatishId
--WHERE  DATEDIFF(DAY, SaleDate, GETDATE())=0
--Group by FilialId


----Yuxardaki view'a esasen

--Declare @max int
--Set @max=(Select max(a.say) from dbo.vw_FilalMehsul as a)
--Select Name from dbo.vw_FilalMehsul as a 
--Join Filallar as f
--ON f.Id=a.FilialId
--where say=@max 


----NETICE BOSH GELE BILER CUNKI BU GUNU GET DATE ILE GOTURUREM HEMIN VAXTA UYGUN INPUT OLMAYACAQ CHOX GUMANKI



-------- 6
---view

--Create view vw_MehsulSay
--as
--select m.Name,Count(m.Name)as say from Satish as s
--JOIN SatishMehsul as sm
--ON s.Id=sm.SatishId
--Join Mehsullar as m
--On m.Id=sm.MehsulId
--WHERE  DATEDIFF(MONTH, SaleDate, GETDATE())=0
--Group by m.Name

---- Select

--SELECT * FROM  dbo.vw_MehsulSay as ms
--where ms.say=(SELECT max(ms.say) FROM  dbo.vw_MehsulSay as ms)

