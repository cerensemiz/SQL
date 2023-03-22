-------------JOIN i�lemleri---------------------------
--Join birle�tirmek anlam�na gelir
-- En az 2 tablonun birle�tirilmesi i�in kullan�l�r
--Join �e�itleri--
--inner join (kesi�im)
--left join (soldan)
--right (sa�dan)
--outter(full) join 
--cross join (kartezyen)
--self join ( joinin ayn� tablolar �zerinde yap�lm�� haline verilen isim)
--composite join


--�RN: 10248 numaral� siparisi kim satmis ve hangi kargo gondermis

use NORTHWND 
select o.OrderID[Sipari� No] ,
e.FirstName+ '' +e.LastName+ '-' +e.Title [Sat��� Yapan �al��an] ,
s.CompanyName[Kargo Firmas�]
from Orders o (nolock)
join Employees e on e.EmployeeID = o.EmployeeID
join Shippers s on o.ShipVia = s.ShipperID
where o.OrderID = 10248


--left join
--Hi� sipari� verilmemi� �r�nler
select * from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID = od.ProductID
where od.OrderID is null

INSERT INTO [dbo].[Products]
           ([ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
     VALUES ( '503 deneme',10,5,'100 boxes',503,100,255,10,0 ),
			( '5030 deneme',10,5,'25 boxes',503,100,255,10,1 ),
			( '5031 deneme',10,5,'30 boxes',503,100,255,10,1 ),
			( '5032 deneme',10,5,'50 boxes',503,100,255,10,1 )

--right join
--Hi� �d�n� al�nmayan Kitaplar
use OduncKitapDB
select k.KitapAdi from OduncIslemler odnc
right join Kitaplar k on k.Id=odnc.KitapId --ana tablo table 2 yerine yaz�l�r 
where odnc.Id is null

--left
--Hi� sipari� verilmemi� urunler
use NORTHWND
select * from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID=od.ProductID
where od.OrderID is null

--right join 
select * from [Order Details] odetay (nolock)
right join Products p (nolock)
on p.ProductID = odetay.ProductID
where odetay.OrderID is null

--self join
--join i�leminde ayn� tablo kullan�ld���nda ozel tablo kullan�l�yor

use NORTHWND
select clsn.FirstName+ ''+ clsn.LastName [Calisan],
mdr.FirstName+ ''+ mdr.LastName [Bagli oldugu ustu]
from Employees clsn (nolock)
left join Employees mdr (nolock) on clsn.ReportsTo = mdr.EmployeeID

use NORTHWND
select clsn.FirstName+ ''+ clsn.LastName [Calisan],
mdr.FirstName+ ''+ mdr.LastName [Bagli oldugu ustu]
from Employees mdr (nolock)
right join Employees clsn (nolock) on clsn.ReportsTo = mdr.EmployeeID

use NORTHWND

select *
from Employees clsn (nolock)
 left join Employees mdr(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

select *
from Employees mdr (nolock)
 right join Employees clsn(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

--outer join 
--Right join i ve left join i bir arada gosterir.
use OduncKitapDB
select * from Kitaplar k (noloCK)
full outer join Turler t (NOLOCK)
on t.Id=k.TurId

select * from Kitaplar k (NOLock)
full outer join OduncIslemler oi
on oi.KitapId= k.Id

select * from Kitaplar k (NOLOck)
left join OduncIslemler oi
on oi.KitapId= k.Id

USE NORTHWND
SELECT *
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



USE [NORTHWND]
GO
--select City from Employees where EmployeeID =5
INSERT INTO [dbo].[Orders]
           ([CustomerID],[EmployeeID],[OrderDate]
           ,[RequiredDate],[ShippedDate] ,
		   [ShipVia],[Freight] ,
		   [ShipName] ,[ShipAddress]
           ,[ShipCity],[ShipRegion] ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           ( null, 5, GETDATE(), null, null, 3, 10, 
		   'Ceren Gemisi', (select Address from Employees where EmployeeID =5),
		   (select City from Employees where EmployeeID =5),
		   (select Region from Employees where EmployeeID =5),
		   (select PostalCode from Employees where EmployeeID =5),
		   (select Country from Employees where EmployeeID =5)

		   )
GO

use NORTHWND
SELECT *
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
where Customers.ContactName like '%eda%' or ContactName like '%zeynep%'

use NORTHWND
SELECT *
FROM Orders -- anda tablo
left JOIN  Customers on Customers.CustomerID=Orders.CustomerID



use NORTHWND
SELECT *
FROM Customers
right JOIN  Orders -- ana tablo table 2
on Customers.CustomerID=Orders.CustomerID





select  * from Orders
where CustomerID is null or CustomerID = ''


--select * from Employees

-- Gamze Turap -Laura Callahan onun amiri olacak �ekilde ekler misiniz

INSERT INTO [dbo].[Employees]
           ([LastName]           ,[FirstName]           ,[Title]
           ,[TitleOfCourtesy]           ,[BirthDate]           ,[HireDate]
           ,[Address]           ,[City]           ,[Region]
           ,[PostalCode]           ,[Country]
           ,[HomePhone]           ,[Extension]           ,[Photo]           ,[Notes]
           ,[ReportsTo]           ,[PhotoPath])
     VALUES
          ('Turap', 'Gamze', 'Software Developer', 'Miss', '19921114',
		  getdate(),
		  'Be�ikta�'  , 'ist', 'Avrupa yakas�', '34700','TR', null,
		  null, null, null, 
		  (select EmployeeID from Employees where FirstName ='Laura' and LastName ='Callahan')
		  , null )


		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
		  -- yeni a�l��an ekledik
		  INSERT INTO [dbo].[Customers]
           ([CustomerID]           ,[CompanyName]
           ,[ContactName]           ,[ContactTitle]
           ,[Address]           ,[City]
           ,[Region]           ,[PostalCode]
           ,[Country]           ,[Phone]           ,[Fax])
     VALUES
         ('ZEYNP', 'Wissen Akademi', 'Zeynep K�ro�lu', 'Software developer', 
		 'Be�ikta�', '�ST', 'Avrupa Yakas�', '34700','TR', null, null),
		 ('EDAKL', 'Wissen Akademi', 'Eda K�l�n�', 'Software developer', 
		 'Be�ikta�', '�ST', 'Avrupa Yakas�', '34700','TR', null, null)


--composite join
 --�al��anlar�mla ayn� �ehirde olan m��teriler
 use NORTHWND
 select * from Customers c
 join Employees e on
 e.Country=c.Country and e.City=c.City
and e.PostalCode=c.PostalCode

 --cross(kartezyen) join --> olas�l�k
select e.FirstName , e.LastName,  e2.LastName
from Employees e
cross join Employees e2 
--11 ^2 =121


--FUNCTIONS
-----MATHEMATICAL FUNCTIONS
select PI()
select pi() Sonuc 
select power(2,3) as Sonuc
select power(2,3) Sonuc
select sqrt(81)
select CEILING(9.0000001)
select floor(9.999999999)
select round(9.26442,2)

--DateTime Function
select getdate()
select year(getdate()) --int geri dondurur
select month(getdate())
select day(getdate())
select month('20230322')

select dateadd(day,3,getdate())
select dateadd(month,-3,getdate())
select dateadd(year,10,getdate())
select dateadd(year,10,'20230322')

--ORN:Siparisler verildigi tarihten itibaren tahmini 3 gun sonra kargolanacaktir.

select o.OrderID, o.OrderDate,
DATEADD(day,3,o.OrderDate) TahminiKargoTarihi
from Orders o (nolock) 

--datediff 2 tarih arasindaki farki alir
select DATEDIFF(day, '20220322','20230322')
select DATEDIFF(month, '20220322','20230322')
select DATEDIFF(year, '20220322','20230322')

--ORN: Siparisin verildigi ve kargolandigi tarih arasinda kac gun gecmistir?

select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [kac gunde kargolanmistir?]
from Orders(nolock) o
join Customers c on c.CustomerID=o.CustomerID
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate)>20  --20 gunu asan kargolar�n sorgulanmasi

--string Functions
select ASCII('A')
select char(65)
--
select CHARINDEX('a','pli ata bak')
select left('ceren',3)
select right('ceren',3)


--trim ifadedeki sag ve soldaki bosluklari siler

select trim('              Naber kuzum          ')
select ltrim('              Ceren              ')
select rtrim('              Ceren              ')


--substring ifadenin icinden bir kisim keser/alir
select SUBSTRING('ceren semiz',5,9)--ad, start position,length

--replace : yerine baska bir deger vermek
select REPLACE('bet�l','t�l','XXX')


select len(' b e t �   l')--bosluklari da sayiyor

--concat : Birlestirmek
select CONCAT ('betul' , 'aksan') 

select CONCAT(e.FirstName, ' ' , e.LastName) [Isim Soyisim]
from Employees e

select CONCAT(e.FirstName, ' ' , e.LastName, ' ', e.City, ' ', 
e.Country,  ' ', e.PostalCode, ' ', e.Address, ' ', e.HomePhone) 
from Employees e

--str icine yazilan ifadeyi string e cevirir
select str(503)

select str(75,3)--Ikinci parametre stringe donustugunde kac karakter olacagini belirler


--Fonksiyon icinde fonksiyon kullanabiliriz
select trim(str(503))
     
select len(str(75.83232323232,10,5))
select str(75.83232323232,10,2)


-- 22/03/2023

select concat( trim(str(day(o.OrderDate))),' / ',
trim(str(month(o.OrderDate))), ' / ',
trim(str(year(o.OrderDate))))
from Orders o

-- 
select CONCAT(day(o.OrderDate),' / ',MONTH(o.OrderDate),' / ',YEAR(o.OrderDate)) 
from Orders o (nolock)

-----------------------------------------------------
--case when then
--rownumber()
--order by
--aggregate functions
--group by having
--sub query
--view
--stored function
--Trigger
-- Transaction 

-----------------------------------------------------

--order by 
--Artan ya da azalan siralama yapar
--ORDER BY ifadesinden sonra
--Tek bir kolon vars tek kolona gore
--Birden cok kolon varsa once ilki sonra digerine gore

use OduncKitapDB
select * from Kitaplar 
where KitapAdi like '%harry%'
order by KitapAdi asc -- alfebetik olarak siralar

select * from Kitaplar 
where KitapAdi like '%harry%'
order by KitapAdi desc -- ters alfabetik siralar

select * from Kitaplar 
where KitapAdi like '%harry%'
order by KitapAdi desc, SayfaSayisi asc --ilk kitap adina gore kolonu siralar, ikinci kolonu sayfa sayisina gore

select *from Kitaplar
order by StokAdeti,
KitapAdi desc, TurId desc


--case when then
--�rn: Her sat�r i�in discount > 0 ise �nidirmli de�ilse indirimsiz yazan kolonu olu�tural�m.
use NORTHWND
select * ,
case 
when od.Discount >0 then '�ndirimli'
else '�ndirimsiz'
end [�ndirim Durumu]
from [Order Details] od (nolock)

--�RN: Sipari� detay tablosundaki her sat�rdaki �r�n i�in e�er
-- Quantity <3 ise Stok T�keniyor yazs�n 10 ile  50 aras�nda isem Kampanyay Uygun �r�n yazs�n 50den b�y�kse M�d�r Onay� Gerekli Hi�birine uymuyorsa ---- Yazs�n.
 use NORTHWND
select od.OrderID, od.ProductID, od.Quantity,
case 
when od.Quantity <3 then 'STOK T�KEN�YOR'
when od.Quantity between 10 and 50 then 'KAMPANYAYA UYGUN �R�N'
WHEN od.Quantity > 50 then 'M�d�r Onay� Gerekli'
else '-----'
end [Quantity'e G�re Durumlar]
from [Order Details] od

--�RN: Sipari� tablosundaki shipcountry alan�na bakal�m
-- i�inde xx ge�en kolonlara puan verelim
select o.OrderID, o.ShipCountry,
case 
when o.ShipCountry like '%an%' or o.ShipVia=3
then 100
else 0
end [Kargo �lke Puan�]
from Orders o (nolock)


--rownumber() : Veriye satir numarasi ekleyen fonksiyon

select ROW_NUMBER() over (order by p.ProductName) S�raNo,
p.ProductName, p.CategoryID, p.UnitPrice
from Products p (nolOCK)

use OduncKitapDB
select ROW_NUMBER() over(order by k.SayfaSayisi desc) S�raNo 
,* 
from Kitaplar k (nolock)

use OduncKitapDB
select ROW_NUMBER() over(order by k.SayfaSayisi desc) S�raNo 
,k.KitapAdi, t.TurAdi, CONCAT(y.YazarAdi, ' ', y.YazarSoyadi)
from Kitaplar k (nolock)
join Turler t on t.Id=k.TurId
join Yazarlar y on y.Id=k.YazarId
-----------------------------------------------------------------------------
--AGGREGATE FUNTIONS
--SUM: Bir sutundaki verileri toplar
--MAX: Bir kolondaki veriler arasindan en buyuk olani verir
--M�N: Bir kolondaki veriler arasindan en kucuk olani verir
--AVG: Bir kolondaki verilerin/degerlerin ortalamasini alir
--COUNT:Bir kolondaki verilerin sayisini verir.
------------
--DIPNOT: Hesaplama fonksiyonlari NULL olan degerleri dikkate almazlar.

use NORTHWND
select count(*) from Customers --Tablodaki butun verinin sayisi
select count(region) from Customers --Tablodaki null olmayan butun verinin sayisi

select max (Unitprice) [En Pahali Urunun Fiyati] from Products
select min (Unitprice) [En Ucuz Urunun Fiyati] from Products
select avg (Unitprice) [Ortalama Urun Fiyati] from Products
select sum (Unitprice) [Toplam Urun Fiyati] from Products

create table Deneme(
id int identity(1,1) primary key,
Deger int null
)

insert into Deneme(Deger) values(200), (null), (159), (200), (null), (50), (100), (200)
select aVG(DEGER) from Deneme--null degerleri dikkate almaz 809/6=134

select avg(isnull(Deger,0)) Sonuc from Deneme --809/8
select count(isnull(region, '')) Sonuc from Customers

---------------------------------------------------------------------------------------

--Group By -- having
--Genellikle aggregate func ile kullan�l�r. -- '*' kullanilmaz

--ORN: Hangi ulkede kac musterim var?

select c.City, count(*) [Musteri Sayisi]
from Customers (nolock) c
group by c.Country, c.City --kolonu grupluyoruz
order by [Musteri Sayisi] desc
--order by c.Country desc


use OduncKitapDB
select k.YazarId, y.YazarAdi, y.YazarSoyadi, 
count(*) [Kitap Sayisi]
from Kitaplar k (nolock)
join Yazarlar y (nolock) on k.YazarId=y.Id
group by k.YazarId, y.YazarAdi, y.YazarSoyadi

-- Kitaplar tablosunda yazar�n ka� adet kitab� var ?
use OduncKitapDB
select y.YazarAdi, y.YazarSoyadi,
count(*) [Kitap Say�s�] 
from Kitaplar k (nolock)
join Yazarlar y (nolock) on k.YazarId= y.Id
group by y.YazarAdi, y.YazarSoyadi

select count(*) from Kitaplar where YazarId=8

select * from Kitaplar where YazarId in (17)

update Kitaplar set YazarId=17 where Id=8
update Kitaplar set YazarId=17 where Id=61
update Kitaplar set YazarId=17 where Id=65
update Kitaplar set YazarId=17 where Id=66

--having: Having ile Group by ile gruplad���n�z kolonu ya da agregate func i�leminin sonucunu ko�ula tabi tutabilirsiniz.
--ORN: Hangi ulkede 5'ten fazla musterim var?
use NORTHWND
select c.Country, count(*) [Musteri Sayisi]
from Customers  (nolock) c
group by c.Country
having count(*) > 5 and c.Country !='USA'
order by c.Country desc

--DIPNOT: Performans acisindan
--NEDEN? Cunku once datadan USA'lari cikartti sonra grupladii
--sonra grupladigindan 5'ten buyukleri getirdi.
select c.Country, count(*) [Musteri Sayisi]
from Customers  (nolock) c
where c.Country != 'USA'
group by c.Country
having count(*) > 5 
order by c.Country desc

--ORN: Urun bazinda ciro
select top 300 * from [Order Details]
select od.ProductID, p.ProductName,
sum(od.UnitPrice * od.Quantity*(1-od.Discount)) [Ciro]
from [Order Details] od (nolock)
join Products p (nolock) on p.ProductID = od.ProductID
group by od.ProductID, p.ProductName

select  p.ProductName ,
sum(od.UnitPrice * od.Quantity* (1- od.Discount)) [Ciro]
from [Order Details] od (nolock)
join Products p (nolock) on p.ProductID= od.ProductID
group by   p.ProductName
order by Ciro desc


--ORN: En cok alisveris yapan musteri
select top 1 o.CustomerID,c.CompanyName, count(*) [Alisveris Sayisi] 
from Orders o (nolock)
join Customers c (nolock) on c.CustomerID=o.CustomerID
group by o.CustomerID, c.CompanyName
order by [Alisveris Sayisi] desc

--ORN: En cok satis yapan calisan 
select top 1 o.EmployeeID, e.FirstName, e.LastName, count(*) [Satis Sayisi]
from Orders (noloCk) o
join Employees e (nolock) on e.EmployeeID=o.EmployeeID
where e.City='London'
group by o.EmployeeID, e.FirstName, e.LastName
order by [Satis Sayisi] desc


--Ture gore odunc islem sayisi
use OduncKitapDB
select t.TurAdi, count(*) [Odunc Alinma Sayisi]
from OduncIslemler o
join Kitaplar k on o.KitapId=k.Id
join Turler t on t.Id=k.TurId
group by t.TurAdi

--select * from Kitaplar where Id in (53,2,3)


