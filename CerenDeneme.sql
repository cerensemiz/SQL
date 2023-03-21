--20.03.2023 503 SQL
--SQL komutlarýnda büyük küçük harf kullanýlamaz.

create DATABase CerenDenemeDB

--tablo oluþturalým
use CafeDB
create table CalisanTipleri (
Id int not null identity(1,1) primary key,
Tip_Adi nvarchar(50) not null
)

create table Calisanlar(
Id int identity(1,1),
Calisan_Tipi_Id int not null,
Eklenme_Tarihi datetime2(7) not null,
IseBaslamaTarihi datetime not null,
Ad nvarchar(50) not null,
Soyad nvarchar(50) not null,
Dogum_Tarihi date,
Cep char(10),
AktifMi bit,
Primary Key(Id)
)

create table Cafe_Kat(
Id int,
CafeId int,
KatId int,
KatAcikMi bit
)

alter table Cafe_Kat
Alter column CafeId int not null
alter table Cafe_Kat
Alter column KatId int not null
alter table Cafe_Kat
Alter column KatAcikMi bit not null

alter table Cafe_Kat
Alter column Id int not null

Alter table Cafe_Kat
ADD CONSTRAINT PK_Cafe_KAT PRIMARY KEY (Id)

create table CafeKat_Masa(
Id int not null identity(1,1) primary key,
CafeKat_id int not null,
Masa_id int not null,
)

create table Siparisler(
Id int not null identity(1,1) primary key,
CafeKat_Masa_Id int not null,
UrunId int not null,
Adet tinyint not null,
Tutar decimal(18,2) not null,
GarsonId int not null
)

create Table Hesaplar(
Id int not null identity(1,1) primary key,
Tarih datetime not null,
SiparisId int not null,
ToplamTutar decimal(18,2) not null
)

