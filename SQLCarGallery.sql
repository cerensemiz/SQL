--Deneme DataBase Olusturma 24.03.2023

create Database CarGalleryDB

use CarGalleryDB

--tablo olusturma
create table Marka(
Id int not null primary key,
Ad varchar(40) not null,
Logo varchar(50) not null,
)

create table Calisanlar(
Id int not null identity(1,1) primary key,
Calisan_Tipi_Id int not null,
Eklenme_Tarihi datetime2(7)  not null,
IseBaslamaTarihi datetime not null,
Ad nvarchar(50) not null,
Soyad nvarchar(50) not null,
Dogum_Tarihi date,
Cep char(10),
AktifMi bit
)

