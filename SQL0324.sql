--ORN: KitaplarYedek siimli bir tablo olmali. Kitaplar tablosundan kayit güncellendiginde bir 
--onceki halinin bilgileri KitaplarYedek kablosuna eklensin.
use OduncKitapDB
alter trigger tg_KitapYedek
on Kitaplar
instead of update
as begin
declare @kayitTarihi datetime2(7),@kitapAdi nvarchar(50),
@turId tinyint, @yazarId int, @sayfa int, @stok int,
@resimLink char(100), @silindiMi bit, @id int

select @id=Id from inserted

select @kayitTarihi=KayitTarihi, @kitapAdi=KitapAdi,
@turId=TurId, @yazarId=YazarId,@sayfa=SayfaSayisi,
@stok=StokAdeti, @resimLink=ResimLink, @silindiMi=SilindiMi
from Kitaplar (nolock)
where Id=@id

insert into KitaplarYedek (Id,KayitTarihi,KitapAdi,TurId,
YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) values 
(@id,@kayitTarihi,@kitapAdi, @turId,@yazarId, @sayfa,@stok,@resimLink,@silindiMi) 

select 
@kayitTarihi=KayitTarihi, @kitapAdi=KitapAdi,@turId=TurId, @yazarId=YazarId,@sayfa=SayfaSayisi,
@stok=StokAdeti, @resimLink=ResimLink, @silindiMi=SilindiMi,
@id=Id
from inserted

update Kitaplar set KayitTarihi=@kayitTarihi,
KitapAdi=@kitapAdi, SayfaSayisi=@sayfa, StokAdeti=@stok,
SilindiMi=@silindiMi, ResimLink=@resimLink, YazarId=@yazarId,
TurId=@turId
where Id=@id
end

select * from Kitaplar where Id=53
update Kitaplar set KitapAdi='Camda Guzellikli Kız'where Id=53
select * from KitaplarYedek

--TRANSACTION
use master 
select * from sys.objects
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[503TransactionOrnek]') AND type in (N'U'))
DROP TABLE [dbo].[503TransactionOrnek]
GO
CREATE TABLE dbo.[503TransactionOrnek] (col1 INT NOT NULL)
GO

select * from [503TransactionOrnek]

insert into[503TransactionOrnek] (col1) values(100), (200), (503)

insert into[503TransactionOrnek] (col1) values(300)
insert into[503TransactionOrnek] (col1) values('Betul')
--Burada biri ekleniyor digeri eklenemiyor.

begin tran
insert into[503TransactionOrnek] (col1) values(400)
insert into[503TransactionOrnek] (col1) values('Betul')
commit --commit iceridekileri uygular

begin tran
insert into[503TransactionOrnek] (col1) values(500)
insert into[503TransactionOrnek] (col1) values(500)
rollback --Transın icindekileri hic gormuyor

CREATE TABLE dbo.[TransactionOrnek] (
id int identity(1,1) primary key,
deger INT NOT NULL
)

SELECT * FROM TransactionOrnek

insert into TransactionOrnek (deger) values(100), (200), (503)

begin tran
insert into[TransactionOrnek] (deger) values(400)
insert into[TransactionOrnek] (deger) values(500)
commit

--SQL Server’da Identity kolon içeren tablolar ile çalışırken, yeni üretilen identity değerine ihtiyacımız olur.​
--@@IDENTITY, SCOPE_IDENTITY() ve IDENT_CURRENT() aynı işi farklı yöntemlerle yapar; son üretilen identity değerini döndürmek.
--SELECT @@IDENTITY
--Açılmış olan bağlantıda son üretilen identity değerini döndürür. @@IDENTITY tablo ve scope bakmaksızın, connection’da üretilen son identity’yi verir. Dikkat : Eğer Insert yaptığınız tablo’da Trigger varsa, yanlış identity alabilirsiniz.
--SELECT SCOPE_IDENTITY()
--Açılmış olan bağlantıda ve sorgunun çalıştığı scope’ta son üretilen identity’yi döndürür. Trigger kullanılan tablolarda @@IDENTITY yerine SCOPE_IDENTITY() kullanılması tavsiye edilir.
--SELECT IDENT_CURRENT(tablename)
--Bağlantı ve scope bakmaksızın, parametre olarak verilen tabloda üretilen son identity değerini döndürür.

create trigger tg_KitapxeEkle
on Kitaplar 
after insert
as begin
declare @kayitTarihi datetime2(7),@kitapAdi nvarchar(50),
@turId tinyint, @yazarId int, @sayfa int, @stok int,
@resimLink char(100), @silindiMi bit, @id int

select 
@kayitTarihi=KayitTarihi, @kitapAdi=KitapAdi,@turId=TurId, @yazarId=YazarId,@sayfa=SayfaSayisi,
@stok=StokAdeti, @resimLink=ResimLink, @silindiMi=SilindiMi,
@id=Id
from inserted

insert into KitaplarX (KayitTarihi,SayfaSayisi, StokAdeti,
SilindiMi,KitapAdi, ResimLink, TurId, YazarId ) 
values (@kayitTarihi, @sayfa, @stok, @silindiMi, @kitapAdi
, @resimLink, @turId,@yazarId) 
end


insert into Kitaplar (KayitTarihi,SayfaSayisi, StokAdeti,
SilindiMi,KitapAdi, ResimLink, TurId, YazarId ) 
values  ( getdate(), 100, 100, 0 , 'Deneme SQL Mola', null, 3,3)


select @@IDENTITY
select SCOPE_IDENTITY()
select IDENT_CURRENT('KitaplarX')


select top 1 * from Kitaplar order by Id desc
select top 1 * from KitaplarX order by Id desc


--------------------------------------------------------------------
use AdventureWorks2019
select count (*) from [Production].[Product]



















