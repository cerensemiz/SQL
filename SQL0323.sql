---SELECT SORGUSUNUN ÇALIÞMA SIRASI
-- 1) FROM 
-- 2,5) Varsa join join çalýþýr yoksa 2'ye geç
-- 2) WHERE 
-- 3) Varsa Group by çalýþýr
-- 4) HAVING çalýþýr
-- 5) SELECT çalýþýr
-- 6) ORDER BY çalýþýr --> Alias kullanýlabilir (Select'ten sonra çalýþtýðý için)

--23.03.2023 503 SQL 
-- örn: Hangi kitap kaç kere ödünç alýnmýþ
use OduncKitapDB
select k.KitapAdi , count(*) [Kaç Kere Ödünç Alýnmýþtýr?]
from OduncIslemler (nolock) odnc
join Kitaplar k (nolock) on k.Id= odnc.KitapId
group by k.KitapAdi

select k.KitapAdi , count(*) [Kaç Kere Ödünç Alýnmýþtýr?]
from Kitaplar k (nolock) 
join OduncIslemler odnc (nolock) on k.Id= odnc.KitapId
group by k.KitapAdi

--ÖRN: 1996 yýlýnda en az kazandýran çalýþaným
use NORTHWND
select top 1 concat(e.FirstName, ' ', e.LastNAme) [Çalýþan], 
count (*) [Satis Sayisi]
from Orders o (nolock) 
join Employees e (nolock) on e.EmployeeID=o.EmployeeID
where o.OrderDate >= '19960101' and o.OrderDate < '19970101'
group by e.FirstName, e.LastName
order by [Satis Sayisi]

--ÖRN: 1997 yýlýnda kazancý min 7000 olup birim fiyatý min 20 ve içinde ff geçmeyen ürünlerden kazandýðým
select top 10 * from [Order Details]
select p.ProductName , cast(sum(od.UnitPrice * od.Quantity * (1- od.Discount)) as decimal(18,0)) [Kazanç] 
from [Order Details] od (nolock)
join Orders o (nolock) on o.OrderID=od.OrderID
join Products p (nolock) on p.ProductID=od.ProductID
where od.UnitPrice >=20 and p.ProductName not like '%ff%'
and o.OrderDate >='19970101' and o.OrderDate <'19980101'
group by p.ProductName
having sum(od.UnitPrice * od.Quantity * (1- od.Discount)) >=7000


--cast komutu --Bir fonksiyonun içinde ',' diðer parametreye geçmek demektir.
select cast(13948.6799926758 as decimal(18,0))

--------------------------------------------------------------------------------------
--DELETE ISLEMI DML KOMUTU

--> hard delete --> delete komutunu yazarak tablodan o veriyi yok etmek/silmek

--> soft delete --> tabloya SilindiMi/AktifMi gibi kolonlar ekleyerek bu kolonlarý güncellemek

use OduncKitapDB
select * from Kitaplar 
where KitapAdi like '%Zümrüt%'
order by Id desc    --en son eklenen kitapalri getirir


use OduncKitapDB
delete from Kitaplar where Id=69 --hard delete

update Kitaplar set SilindiMi=1 where Id=53 --> UPDATE ÝSLEMÝ : SOFT DELETE islemidir.

select * from Kitaplar where KitapAdi like '%cam%'

--case when then
--rownumber()
--order by
--aggregate functions
--group by having
--delete
--sub query
--deðiþken , döngü
--view
--stored function
--Trigger
-- Transaction 
-----------------------------------------------------------------------------------------------------------
--View: Kod ile de olusturulur.Object Explorer penceresinden views >> New View ile designer penceresinden de olusturulur.

create View KitapveYazarView
as
select k.Id, k.KayitTarihi, k.KitapAdi, t.TurAdi,
concat(y.YazarAdi,  ' ', y.YazarSoyadi)[Yazar], k.SayfaSayisi, k.StokAdeti,
k.ResimLink, k.SilindiMi
from Kitaplar k (nolock)
join Yazarlar y (nolock) on y.Id=k.YazarId
join Turler t (nolock) on t.Id=k.TurId


--Burada view ile sanal bir tablo oluþturuyoruz
 use NORTHWND
create view ProductCiro1997 
as 
select p.ProductName , sum(od.UnitPrice * od.Quantity * (1- od.Discount)) [Kazanç] 
from [Order Details] od (nolock)
join Orders o (nolock) on o.OrderID=od.OrderID
join Products p (nolock) on p.ProductID=od.ProductID
where od.UnitPrice >=20 and p.ProductName not like '%ff%'
and o.OrderDate >='19970101' and o.OrderDate <'19980101'
group by p.ProductName

select * from ProductCiro1997 --//gercek bir tablo olmadigi select update delete olmaz 

--------------------------------------------------------------------------------------
--sub query: Alt sorgu anlamýna gelir. Ýc ice select sorgusu yazmaktir.
--Orn: hipper Seepd Express isimli kargoyla verilen siparisler
use NORTHWND
select * from Orders o (nolock)
where o.ShipVia=(
select ShipperID from Shippers where CompanyName='Speedy Express')


--Derived Turetilmis tablo:
--Parantez icine alinan AltSorguya TAKMA ÝSÝM (alias) verilerek 
--turetilmis tablo haline getirip kullanabilirsiniz.

--ORN: Kargoda 30 gunu asan siparisler 
select * from
(
select o.OrderID, O.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate,o.ShippedDate)[Kac Gunde Kargolandi?]
from Orders o (nolock)) kargoGunleri --kargoGunler : turetilmis table der
where [Kac Gunde Kargolandi?] > 35


--ÖRN ***** 35 günü aþan kargoya verme iþlemi problem oluþturmakatadýr. (baþarýsýz gönderim iþlemi sayýlmaktadýr) Firmanýn yýl bazýnda kaç defa baþarýsýz gönderim iþlemi olmuþtur?

select year(kargoGunleri.OrderDate) Yýl , count(*) [Kaç Kere baþarýsýz gönderim iþlemi Olmuþ?]
from 
(select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate, o.ShippedDate) [Kaç Günde Kargolandi?]
from Orders (nolock) o 
where DATEDIFF(day, o.OrderDate, o.ShippedDate) > 35) kargoGunleri 
group by year(kargoGunleri.OrderDate)



select yýlSonuc.OrderYear, sum(yýlSonuc.[Kaç Kere baþarýsýz gönderim iþlemi Olmuþ?]) HowManyTimesCargoFailed  from
(select year(kargoGunleri.orderdate) [OrderYear], count(*) [Kaç Kere baþarýsýz gönderim iþlemi Olmuþ?]
from 
	(
	select o.OrderID,o.OrderDate, DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolandi?]
	from Orders o) as kargoGunleri
	where kargoGunleri.[Kaç Günde Kargolandi?] > 35
	group by kargoGunleri.OrderDate) as yýlSonuc
group by yýlSonuc.OrderYear

--------------------------------------------------------------------------
--Degisken, Kosul, Dongu
--degisken tanimlama
declare @durum nvarchar(6)
set @durum= 'denemfdgfdgdfge'
--select @durum Sonuc
select
case 
@durum when 'deneme' then 'EVET deneme yazýyor'
else 'HAYIR deneme Yazmýyor'
end Sonuc 

--if kullanimi
declare @sayi int
Set @sayi =200
if(@sayi > 100)
begin 
select 'Bu sayi 100 den buyuktur'
end 
else
begin
select 'Bu sayi 100 den kucuktur'
end

--Dongu While
declare @sayac int, @sonuc int
set @sayac=1 set @sonuc=1
while (@sayac < 6)
begin
if(@sayac =1) begin break end
set @sonuc += @sayac 
set @sayac+=1
end
print concat('Sonuc =', @sonuc)
select concat('Sonuc =', @sonuc)



--ORN: icinde cam olan kitap var mi? EVET HAYIR

--use OduncKitapDB
--declare @kitapAdi nvarchar(50)
--set @kitapAdi = 'cam'
--if (EXISTS(select * from Kitaplar k (nolOCK)
--where k.KitapAdi like '%'+@kitapAdi+'%'))
--begin
--print 'Bu Kitaptan VAR'
--end 
--else
--begin 
--select 'Bu Kitaptan Yok' Sonuc
--end


declare @kitapAdi nvarchar(50)
set @kitapAdi='er'
if(EXISTS(select * from Kitaplar k (nolock)
where k.KitapAdi like '%'+@kitapAdi+'%' ))
begin
-- kitabýn türünü istiyor
select t.TurAdi from Turler t (nolock) 
where t.Id in (select k.TurId from Kitaplar k (nolock)
where k.KitapAdi like '%'+@kitapAdi+'%' )
end
else
begin
select 'Bu kitaptan YOK!' Sonuc
end

---------------------------------------------------------------------------
--Stored Procedure 
--C# dilindeki metotlara karsilik gelir.
--Parametreli, parametresiz ve geriye deðer gonderebilir(output), geriye deger gondermeyebilir.
--SP kisaltmasiyla bilinirler
--Tekrar tekrar yazilmasi/islenmesi gereken islemleri tek bir sefer yazip tekrar tekrar kullaniriz.

--Parametre almayan bir ornek
--Orn: Tum kategorileri getiren prosedur

alter procedure spTumKAtegorileriGetir
as
begin
select * from Kitaplar (nolock) --begin end arasnda calistiracagin komutu yaziyorsun
end 


--SP NAsil Cagirilir?
execute spTumKAtegorileriGetir
exec spTumKAtegorileriGetir


--parametre alan sp
--ORN: Disardan verilen kitap adini arayip getiren prosedur


create procedure sp_KitapAra(@kitapAdi nvarchar(50)) 
as begin
select * from Kitaplar (nolock)
where KitapAdi like '%'+@kitapAdi+'%'
end 

exec sp_KitapAra 'cam'

--Var olan prosedürün içeriðini düzenliyoruz
alter procedure sp_KitapAra(@kitapAdi nvarchar(50))
as begin
declare @adet int 
select @adet = count (*) from Kitaplar (nolock)
where KitapAdi like '%'+@kitapAdi+'%'
if(@adet > 0)
begin 
select concat('Bu kitaptan', @adet, 'vardýr') Sonuc
end
else
begin
select 'Bu kitaptan YOK' Sonuc
end
end
exec sp_KitapAra'a'


--ORN: Yeni cafeyi ekleyen prosedur ile ekleyelim.
use CafeDB
create procedure sp_YeniCafeEkle(@trh datetime2(7), @ad nvarchar(50), @adres nvarchar(100), @tel char(13), @katSayisi tinyint)
as
begin
insert into Cafeler([Eklenme_Tarihi], Ýletisim_Telefon, Acik_Adresi, Adi, Kac_Katli)
values (@trh, @tel, @adres, @ad, @katSayisi)
end

exec sp_YeniCafeEkle '20230223', 'Cerens Cafe', 'Besiktas', null, 2
--select*from Cafeler

--ORN: Prosedur ile guncelleme yapalim
use OduncKitapDB


--ÖRN: Dýþardan idsini aldýðýmý kitabýn stok adedini 2 katýna çýkaran prosedür  

alter procedure sp_Stogu2KatinaCikar (@kitapid int)
as begin
if(exists(select * from Kitaplar (nolock) where Id=@kitapid))
begin
declare @stok int
select @stok= StokAdeti  from Kitaplar (nolock) where Id=@kitapid
update Kitaplar set StokAdeti = @stok  * 2 where Id=@kitapid
end
else
print 'Kitap YOK Stok artýþý yapýlamaz!'
end

select * from Kitaplar where Id=53 --19 stok
exec sp_Stogu2KatinaCikar 53


--Trigger --Tetikleyici
--Cagrilmasinin sartlar saglandigi surece otomatik tetiklenen SQL sorgularini yazdigimiz yapidir.
--Triggerlar bir tabloya bagli olarak calisir.
--Insert Update Delete islemlerinden sonra ya da islemlerin YERÝNe yaizilirlar
--Triggerýn 2 cesidi vardir:
--AFTER Trigger: Insert/Update/Delete islemlerinden SONRA calisir.
--INSTEAD OF: Insert/Update/Delete yerine calisir.Kimin yerine calisirsa o komutu diskalifiye etmis gibi düsünebilirsiniz.

--ORN: Cafeler tablosuna ekleme yapildiginda tabloyu listeleyen trigger
--ekleme yapilacak sonra listeleme(After trigger)

use CafeDB
create trigger tg_CafeListele
on Cafeler --hangi tabloya bagli kalacak
after insert -- cesidi(after) insert(islem)
as begin
select * from Cafeler
order by Id desc
end

exec sp_YeniCafeEkle '20230323', '503 Cafe','Besiktas',null,2

insert into Cafeler (Eklenme_Tarihi,Ýletisim_Telefon,Acik_Adresi,Adi,Kac_Katli)
values ('20230323', null, 'Besiktas', 'Mems Cafe',2)

alter trigger tg_CafeListele2
on Cafeler -- hangi tabloya baðlý çalýþacak?
after update -- çeþidi (after) insert(iþlem)
as begin
select * from Cafeler
order by Id desc
end


--ORN: Odunç islemden sonra kitaplar tablosunda kitabin stok adedini azaltalim. 
--after insert
use OduncKitapDB
alter trigger tg_StokAzalt
on OduncIslemler
after insert
as begin 
declare @kitapId int, @stok int
select @kitapId= KitapId from inserted
select @stok= StokAdeti  from Kitaplar (nolock) 
where Id=@kitapId
if(@stok >=1)
update Kitaplar set StokAdeti= @stok-1 where Id=@kitapId
end

select * from Kitaplar --68 stok =1  -- 46 stok= 28

insert into OduncIslemler (KayitTarihi, UyeId, KitapId, PersonelId, OduncAlinmaTarihi, OduncBitisTarihi,TeslimEttigiTarih, TeslimEttiMi)
values(getdate(),1,69,1,getdate(),dateadd(DAY,30, getdate()),null,0 )

--instead of Trigger Komutun yerine calisir

--Orn: Cafeler tablosundan hic bir kayit silinemesin.
use CafeDB
create Trigger tg_Silemez
on Cafeler
instead of delete
as begin
print 'KAYIT SILINEMEZ'
end

select * from Cafeler

delete from Cafeler where Id=5

use CafeDB
--Triggeri komut ile disableenable etme islemi
ALTER TABLE Cafeler DISABLE TRIGGER tg_CafeListele

ALTER TABLE Cafeler	ENABLE TRIGGER tg_CafeListele

--enable Triggers on a Table

Disable TRIGGER ALL ON Cafeler
Enable TRIGGER ALL ON Cafeler
--Enable Triggers on a Database


ENABLE TRIGGER ALL On DATABASE ---?



USE NORTHWND
SELECT * FROM Orders WHERE ShipName='Hanari Carnes'


use CafeDB
Create Unique INDEX idx_KategoriAdi
on Kategoriler (Ad);


insert into Kategoriler (Ad) values ('Betül')

Create index idx_Calisanlar
on Calisanlar(Ad, Soyad)
+