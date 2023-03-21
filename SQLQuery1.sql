---21.02.2023 SALI 503 SQL 
-----DML Data Manipulation Language

--insert into tabloAdi(kolon1, kolon2) 
--values (deger1, deger2)
--metinsel, tarih tek t�rnak
--�RN: �r�nler tablosuna veriler ekleyelim.

use CafeDB 
insert into Urunler(Birim_Fiyat, Kategori_Id, Urun_Adi,  
Birim_Fiyati_Deneme1_182, Birim_Fiyati_Deneme2_184, Birim_Fiyati_Deneme3_money) 
values (10 ,2, '�ay', 10.5, 10.5556 ,10.202)

insert into Urunler(Urun_Adi, 
Kategori_Id, 
Birim_Fiyat)
values
('Kahve', --�r�n ad�
2, --kategori id
35)

insert into Urunler
(Urun_Adi, Kategori_Id, Birim_Fiyat)
values 
('Limonata',2,30),
('S�cak �ikolata',2,20),
('Portakal Suyu',2,30),
('Oralet',2,15)

USE [CafeDB]
GO

--->Tabloya Sa�a t�k 
INSERT INTO [dbo].[Urunler]
           ([Kategori_Id]
           ,[Urun_Adi]
           ,[Birim_Fiyat]
           ,[Birim_Fiyati_Deneme1_182]
           ,[Birim_Fiyati_Deneme2_184]
           ,[Birim_Fiyati_Deneme3_money])
     VALUES
           (1, 'S�tla�' , 25, null, null, null),
		   (1, 'Kaday�f Dolmas�', 30, 30.99, 30.9999, 30.63)
GO

--> DQL Data Query Language 
--Select komutu se�me/listeleme yapar
--select kolon adlar� from tablo ad�
--select * from tabloadi

select * from Urunler

select  Urun_Adi, Birim_Fiyat from  Urunler

select *,*,* from Urunler --k�t� kullan�m

select Birim_Fiyati_Deneme3_money, * from Urunler --k�t� kullan�m!

select top 2 * from Urunler --Bilmedi�in bir tablonun i�eri�ini g�rmek istedi�inde 
--top kullan�m� best practice tir

--no lock 
select * from Urunler (nolock)
select * from Urunler with (nolock)

--Takma �sim ALIAS
--1. nedeni --> Tabloya takma isim vererek kolonlara daha kolay ula�mak
--2. nedeni--> JOIN konusunda a��klanacak
--3. nedeni--> SUBQUERY lerde derived table'� isimlendirmek i�indir.

select u.Urun_Adi as [Cafemizin �r�nleri], 
u.Birim_Fiyat as Bu_�r�n�n_Fiyat�
from 
Urunler as u --1,2,3 harfli takma isim

--Bir tablonun kolonuna tabloda olan ba�ka bir kolonun ismini takma isim olarak vermeyiniz.
select u.Urun_Adi [Cafemizin �r�nleri], 
u.Birim_Fiyat Bu_�r�n�n_Fiyat�
from 
Urunler u --1,2,3 harfli takma isim(kolon ismi yaz�p bir bo�luk b�rak�p sonraki yazd���m�z harf kolona takt���m�z takma add�r)

--kolonlarla i�lemler yapmak

select 10+10 AS sonuc
select 10+10 sonuc
select 10 + '10' sonuc -->
select 10 + 'bet�l' sonuc
select '10' + 'bet�l' sonuc
select 99.8 + '10'
select  '31.75'+ 99.8 

--�r�nlerin ismi fiyat� �zdrine %10 zam  kolonuna ihtiyac�m var

select u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10[%10 Eklenmi� Yeni Fiyat TL] --Bu y�ld�z �arpma i�lemi
from Urunler u

select '21/02/2023' Tarih, u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10[%10 Eklenmi� Yeni Fiyat TL]
from Urunler u

--WHERE KOMUTU
--Mevcuttaki tabloya baz� ko�ullar uygulayarak
--tablodaki verilere filtreleme yapabiliriz.

use OduncKitapDB
select * from Kitaplar
where KitapAdi = 'Camdaki K�z'

--sayfa say�s� 350 den fazla olan kitaplar

select * from Kitaplar
where SayfaSayisi >= 350

--turID 6 lan ve sayfa say�s� 350den fazla olan kitaplar

select* from Kitaplar
where TurId = 6 and SayfaSayisi >= 350

select* from Kitaplar
where TurId = 6 or SayfaSayisi >= 350

--Farkl� operat�rleri ayn� anda kullan�rsak PARANTEZ Kullan!

select * from Kitaplar
where SayfaSayisi > 350 and (TurId=6  or TurId=8)

---E�it de�il, Farkl�d�r, NOT operat�rleri

----Sistemdeki turId'si 6 olmayan kitaplar
select*from Kitaplar k(nolock)
where k.TurId !=6 --E��T DE��LD�R

select*from Kitaplar k(nolock) 
where k.TurId <> 6 --FARKLIDIR

--NOT OPERAT�R�

select * from Kitaplar
where not (SayfaSayisi > 350 and (TurId=6  or TurId=8))

select * from Kitaplar
where not (TurId=6  or TurId=8)

--and or not bir arada kullan�labilir fakat parantez onceligine onem verilmelidir.
--Fakat parantez onceligine onem verilmelidir.
select * from Kitaplar
where not(YazarId=1 and SayfaSayisi> 350)
and StokAdeti>10

select*from Kitaplar
where not YazarId=19

----WHERE komutunun KULLANIMLARI -------------------------------------------------
--   --1)Kar��la�t�rma ( <,> =,>=,<=,=!)
--   --2)Mant�ksal (AND, OR, NOT)
--   --3)Aral�k sorgulama (between...and)
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
---best practice TAR�H veren Sorgulama
select*from Kitaplar k (nolock)
where k.KayitTarihi >= '20220114' and k.KayitTarihi < '20220115'

select*from Kitaplar k (nolock)
where k.KayitTarihi between '20220114' and  '20220115'

--2022 ocak ay�
select*from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi < '20220201'

select*from Kitaplar k (nolock)
where k.KitapAdi between 'Ezbere Ya�ayanlar' and 'Momo'

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


---2022 den �nceki y�llardaki t�m kitaplar� stok 0 ve SilindiMi 1 yapal�m
select *from Kitaplar (nolock)k
where k.KayitTarihi < '20220101'


SELECT * INTO Kitaplar20230321 -- tablonun yede�ini ald�k
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
where k.TurId in ('Camdaki K�z' , 'Hayata D�n')

select*from Kitaplar (nolock) k
where k.KayitTarihi in ('20220114', '20220115',
'2022-01-14 14:42:35.603')

--5) Like Komutu 
--% i�areti herhangibir karakter anlam�na gelir
-- _alt tire i�areti tek bir karakter anlam�na gelir.

select*from Kitaplar (nolock) k
where k.KitapAdi like 'C%' --C ile ba�layan kitaplar

--c ile ba�lay�p i�inde r olan 
select*from Kitaplar (nolock) k
where k.KitapAdi like 'C%r%'

--herhangi bir yerde en yan yana olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '%en%'

--ikinci harf r olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '_r%'

--ilk harf s ���nc� r olsun 
select * from Kitaplar (nolock) k
where k.KitapAdi like 's_r%'

select * from Kitaplar (nolock) k
where k.KitapAdi like '%n_d'

--sonu l_r ile bitsin (ler lar lur l�r ...lxr)
select * from Kitaplar (nolock) k
where k.KitapAdi like '%l_r'

--sadece d�rt harfliler
select * from Kitaplar (nolock) k
where k.KitapAdi like '____'

--[] Aral�k belirtmek i�in
select * from Kitaplar (nolock) k
where k.KitapAdi like '[a-K]__e_[B-Z]%' --ilk harfi a ile k aras�nda olsun son harfi b ile z aras�nda

-- ^ de�ili
select * from Kitaplar (nolock) k
where k.KitapAdi like '[^a-K]%'

select * from Kitaplar (nolock) k
where k.KitapAdi like '[^M]___'

--Ba��nda 1 olmayan 4 harfliler
select * from Kitaplar (nolock) k
where k.KitapAdi like '[^1]___'

--Like Not Kullan�m� 
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

values (getdate(),'Z�mr�t', 1, 1,1,1,null, 0)


--distinct komutu 
--Sorgu sonucunda gelen kolonun i�inde ayn� de�erler
--tekrar etmesin istersek o kolonun �n�ne tekille�tirme anlamn�na 
--gelen distinct komutunu ekleriz

select distinct TurId from Kitaplar(NOLOCK)

select distinct TurId, SayfaSayisi from Kitaplar(NOLOCK)--distinct tekrar� �nl�yor.

----group by da bu soruyu ��zece�iz
----Kitaplar tablosunda yazar�n ka� adet kitab� var?
-------------------------------------------------------------------------------------
------------------------JOIN ISLEMLERI-----------------------------------------------
----en az iki tablonun birle�tirilmesi i�in kullan�l�r
----Join Cesitleri--
----inner join (kesisim)
----left join (soldan)
----right join (sa�dan)
----outter(d��) join
----cross join(kartezyen)
----Self join (joinin ayn� tablolar �zerinde yap�lm�� haline verilen isim)
----composite join
-------------------------------------------------------------------------------------

--inner join (Kesisim)

select*from Kitaplar  (nolock) 
inner join Turler (noloCK)
on TurId=Turler.Id

select*from Kitaplar k (nolock) --k alyanst�r.
inner join Turler t(noloCK) --hangi alanlar uzerinde eslesme yapilacak
on k.TurId=t.Id

select k.KitapAdi, k.SayfaSayisi, t.TurAdi 
from Kitaplar k  (nolock)    --table 1
inner join Turler t(noloCK)  --table 2
on k.TurId=t.Id              -- kesisim sa�lanacak kolon

-- Bir kitab�n adi, turu ve yazarin adi soyadi

select k.KitapAdi, t.TurAdi,
y.YazarAdi + ' ' + y.YazarSoyadi as Yazar
from Kitaplar k (NOLOCK)
inner join Turler t (NOLock) on t.Id=k.TurId
join Yazarlar Y (noLOcK) on k.YazarId=y.Id
where k.SayfaSayisi > 300 and t.TurAdi like '%a%'