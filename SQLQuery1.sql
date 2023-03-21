---21.02.2023 SALI 503 SQL 
-----DML Data Manipulation Language

--insert into tabloAdi(kolon1, kolon2) 
--values (deger1, deger2)
--metinsel, tarih tek týrnak
--ÖRN: Ürünler tablosuna veriler ekleyelim.

use CafeDB 
insert into Urunler(Birim_Fiyat, Kategori_Id, Urun_Adi,  
Birim_Fiyati_Deneme1_182, Birim_Fiyati_Deneme2_184, Birim_Fiyati_Deneme3_money) 
values (10 ,2, 'Çay', 10.5, 10.5556 ,10.202)

insert into Urunler(Urun_Adi, 
Kategori_Id, 
Birim_Fiyat)
values
('Kahve', --Ürün adý
2, --kategori id
35)

insert into Urunler
(Urun_Adi, Kategori_Id, Birim_Fiyat)
values 
('Limonata',2,30),
('Sýcak Çikolata',2,20),
('Portakal Suyu',2,30),
('Oralet',2,15)

USE [CafeDB]
GO

--->Tabloya Saða týk 
INSERT INTO [dbo].[Urunler]
           ([Kategori_Id]
           ,[Urun_Adi]
           ,[Birim_Fiyat]
           ,[Birim_Fiyati_Deneme1_182]
           ,[Birim_Fiyati_Deneme2_184]
           ,[Birim_Fiyati_Deneme3_money])
     VALUES
           (1, 'Sütlaç' , 25, null, null, null),
		   (1, 'Kadayýf Dolmasý', 30, 30.99, 30.9999, 30.63)
GO

--> DQL Data Query Language 
--Select komutu seçme/listeleme yapar
--select kolon adlarý from tablo adý
--select * from tabloadi

select * from Urunler

select  Urun_Adi, Birim_Fiyat from  Urunler

select *,*,* from Urunler --kötü kullaným

select Birim_Fiyati_Deneme3_money, * from Urunler --kötü kullaným!

select top 2 * from Urunler --Bilmediðin bir tablonun içeriðini görmek istediðinde 
--top kullanýmý best practice tir

--no lock 
select * from Urunler (nolock)
select * from Urunler with (nolock)

--Takma Ýsim ALIAS
--1. nedeni --> Tabloya takma isim vererek kolonlara daha kolay ulaþmak
--2. nedeni--> JOIN konusunda açýklanacak
--3. nedeni--> SUBQUERY lerde derived table'ý isimlendirmek içindir.

select u.Urun_Adi as [Cafemizin Ürünleri], 
u.Birim_Fiyat as Bu_Ürünün_Fiyatý
from 
Urunler as u --1,2,3 harfli takma isim

--Bir tablonun kolonuna tabloda olan baþka bir kolonun ismini takma isim olarak vermeyiniz.
select u.Urun_Adi [Cafemizin Ürünleri], 
u.Birim_Fiyat Bu_Ürünün_Fiyatý
from 
Urunler u --1,2,3 harfli takma isim(kolon ismi yazýp bir boþluk býrakýp sonraki yazdýðýmýz harf kolona taktýðýmýz takma addýr)

--kolonlarla iþlemler yapmak

select 10+10 AS sonuc
select 10+10 sonuc
select 10 + '10' sonuc -->
select 10 + 'betül' sonuc
select '10' + 'betül' sonuc
select 99.8 + '10'
select  '31.75'+ 99.8 

--ürünlerin ismi fiyatý üzdrine %10 zam  kolonuna ihtiyacým var

select u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10[%10 Eklenmiþ Yeni Fiyat TL] --Bu yýldýz çarpma iþlemi
from Urunler u

select '21/02/2023' Tarih, u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10[%10 Eklenmiþ Yeni Fiyat TL]
from Urunler u

--WHERE KOMUTU
--Mevcuttaki tabloya bazý koþullar uygulayarak
--tablodaki verilere filtreleme yapabiliriz.

use OduncKitapDB
select * from Kitaplar
where KitapAdi = 'Camdaki Kýz'

--sayfa sayýsý 350 den fazla olan kitaplar

select * from Kitaplar
where SayfaSayisi >= 350

--turID 6 lan ve sayfa sayýsý 350den fazla olan kitaplar

select* from Kitaplar
where TurId = 6 and SayfaSayisi >= 350

select* from Kitaplar
where TurId = 6 or SayfaSayisi >= 350

--Farklý operatörleri ayný anda kullanýrsak PARANTEZ Kullan!

select * from Kitaplar
where SayfaSayisi > 350 and (TurId=6  or TurId=8)

---Eþit deðil, Farklýdýr, NOT operatörleri

----Sistemdeki turId'si 6 olmayan kitaplar
select*from Kitaplar k(nolock)
where k.TurId !=6 --EÞÝT DEÐÝLDÝR

select*from Kitaplar k(nolock) 
where k.TurId <> 6 --FARKLIDIR

--NOT OPERATÖRÜ

select * from Kitaplar
where not (SayfaSayisi > 350 and (TurId=6  or TurId=8))

select * from Kitaplar
where not (TurId=6  or TurId=8)

--and or not bir arada kullanýlabilir fakat parantez onceligine onem verilmelidir.
--Fakat parantez onceligine onem verilmelidir.
select * from Kitaplar
where not(YazarId=1 and SayfaSayisi> 350)
and StokAdeti>10

select*from Kitaplar
where not YazarId=19

----WHERE komutunun KULLANIMLARI -------------------------------------------------
--   --1)Karþýlaþtýrma ( <,> =,>=,<=,=!)
--   --2)Mantýksal (AND, OR, NOT)
--   --3)Aralýk sorgulama (between...and)
--   --4)Listesel sorgulama (in)
--   --5)Like komutu
--   --6)Null verileri sorgulama (is)
----------------------------------------------------------------------------------
--^3) ARALIK SORGULAMA(between ... and)
select*from Kitaplar(NOLOCK) k
where k.SayfaSayisi between 200 and 300 

--Turid 5 olan sayfasayisi 200 ile 300 arasinda olan
--(sayfasayisi >2=00 ve <=300 mantigi var)
select*from Kitaplar(NOLOCK) k
where k.SayfaSayisi between 200 and 300 
and k.TurId=5

select * from Kitaplar k (nolock) 
where k.KayitTarihi between '20190321' and '20190321'

select * from Kitaplar k (nolock)
where k.KayitTarihi <= '20220114' and k.KayitTarihi >= '20220114'

select * from Kitaplar k (nolock) 
where k.KayitTarihi between '20220101' and '20220122'

--14ocak 2022
---best practice TARÝH veren Sorgulama
select*from Kitaplar k (nolock)
where k.KayitTarihi >= '20220114' and k.KayitTarihi < '20220115'

select*from Kitaplar k (nolock)
where k.KayitTarihi between '20220114' and  '20220115'

--2022 ocak ayý
select*from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi < '20220201'

select*from Kitaplar k (nolock)
where k.KitapAdi between 'Ezbere Yaþayanlar' and 'Momo'

insert into Kitaplar (KayitTarihi, KitapAdi, TurId, YazarId, 
SayfaSayisi, StokAdeti, ResimLink, SilindiMi)

values (getdate(), 'Deneme503', 1, 1,1,1, '', 0)

select*from Kitaplar where Id=67

--20220114
--update TabloAdi set kolon1=YeniDegeri1, kolon2=YeniDegeri2 ... 
--where kosul

--update Kitaplar set KayitTarihi='2022-01-14 00:00:00.000', SilindiMi=1
--where Id=67

--update Kitaplar set KitapAdi='Ceren'
--where Id=67


---2022 den önceki yýllardaki tüm kitaplarý stok 0 ve SilindiMi 1 yapalým
select *from Kitaplar (nolock)k
where k.KayitTarihi < '20220101'


SELECT * INTO Kitaplar20230321 -- tablonun yedeðini aldýk
from Kitaplar

select*from Kitaplar20230321

update Kitaplar set StokAdeti=0 , SilindiMi=1
where KayitTarihi < '20220101'

--4) Listesel Sorgulama (in)
select*from Kitaplar (nolock) k
where k.TurId =8 or k.TurId =6

select*from Kitaplar(nolock) k
where k.TurId in (8,6,2,4)

select*from Kitaplar(nolock) k
where k.TurId in ('Camdaki Kýz' , 'Hayata Dön')

select*from Kitaplar (nolock) k
where k.KayitTarihi in ('20220114', '20220115',
'2022-01-14 14:42:35.603')

--5) Like Komutu 
--% iþareti herhangibir karakter anlamýna gelir
-- _alt tire iþareti tek bir karakter anlamýna gelir.

select*from Kitaplar (nolock) k
where k.KitapAdi like 'C%' --C ile baþlayan kitaplar

--c ile baþlayýp içinde r olan 
select*from Kitaplar (nolock) k
where k.KitapAdi like 'C%r%'

--herhangi bir yerde en yan yana olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '%en%'

--ikinci harf r olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '_r%'

--ilk harf s üçüncü r olsun 
select * from Kitaplar (nolock) k
where k.KitapAdi like 's_r%'

select * from Kitaplar (nolock) k
where k.KitapAdi like '%n_d'

--sonu l_r ile bitsin (ler lar lur lür ...lxr)
select * from Kitaplar (nolock) k
where k.KitapAdi like '%l_r'

--sadece dört harfliler
select * from Kitaplar (nolock) k
where k.KitapAdi like '____'

--[] Aralýk belirtmek için
select * from Kitaplar (nolock) k
where k.KitapAdi like '[a-K]__e_[B-Z]%' --ilk harfi a ile k arasýnda olsun son harfi b ile z arasýnda

-- ^ deðili
select * from Kitaplar (nolock) k
where k.KitapAdi like '[^a-K]%'

select * from Kitaplar (nolock) k
where k.KitapAdi like '[^M]___'

--Baþýnda 1 olmayan 4 harfliler
select * from Kitaplar (nolock) k
where k.KitapAdi like '[^1]___'

--Like Not Kullanýmý 
select * from Kitaplar (nolock) k
where k.KitapAdi not like 'm%'

--6) Null Verileri Sorgulamak (is)
select * from Kitaplar (nolock) k
where k.ResimLink is null 

--Resmi olmayan Kitaplar 
select * from Kitaplar (nolock) k
where k.ResimLink is null or k.ResimLink = ''

--null olmayan is not null
select * from Kitaplar (nolock) k
where k.ResimLink is not null

--Resmi olan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is not null and k.ResimLink<> ''

select * from Kitaplar (nolock) k
where k.ResimLink is not null and not k.ResimLink=''



insert into Kitaplar (KayitTarihi, KitapAdi, TurId, YazarId, 
SayfaSayisi, StokAdeti, ResimLink, SilindiMi)

values (getdate(),'Zümrüt', 1, 1,1,1,null, 0)


--distinct komutu 
--Sorgu sonucunda gelen kolonun içinde ayný deðerler
--tekrar etmesin istersek o kolonun önüne tekilleþtirme anlamnýna 
--gelen distinct komutunu ekleriz

select distinct TurId from Kitaplar(NOLOCK)

select distinct TurId, SayfaSayisi from Kitaplar(NOLOCK)--distinct tekrarý önlüyor.

----group by da bu soruyu çözeceðiz
----Kitaplar tablosunda yazarýn kaç adet kitabý var?
-------------------------------------------------------------------------------------
------------------------JOIN ISLEMLERI-----------------------------------------------
----en az iki tablonun birleþtirilmesi için kullanýlýr
----Join Cesitleri--
----inner join (kesisim)
----left join (soldan)
----right join (saðdan)
----outter(dýþ) join
----cross join(kartezyen)
----Self join (joinin ayný tablolar üzerinde yapýlmýþ haline verilen isim)
----composite join
-------------------------------------------------------------------------------------

--inner join (Kesisim)

select*from Kitaplar  (nolock) 
inner join Turler (noloCK)
on TurId=Turler.Id

select*from Kitaplar k (nolock) --k alyanstýr.
inner join Turler t(noloCK) --hangi alanlar uzerinde eslesme yapilacak
on k.TurId=t.Id

select k.KitapAdi, k.SayfaSayisi, t.TurAdi 
from Kitaplar k  (nolock)    --table 1
inner join Turler t(noloCK)  --table 2
on k.TurId=t.Id              -- kesisim saðlanacak kolon

-- Bir kitabýn adi, turu ve yazarin adi soyadi

select k.KitapAdi, t.TurAdi,
y.YazarAdi + ' ' + y.YazarSoyadi as Yazar
from Kitaplar k (NOLOCK)
inner join Turler t (NOLock) on t.Id=k.TurId
join Yazarlar Y (noLOcK) on k.YazarId=y.Id
where k.SayfaSayisi > 300 and t.TurAdi like '%a%'