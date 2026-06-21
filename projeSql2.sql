CREATE DATABASE FotoStudioDB;
USE FotoStudioDB;
USE FotoStudioDB;
CREATE TABLE Musteri (
    MusteriID INT PRIMARY KEY AUTO_INCREMENT,
    Ad VARCHAR(50) NOT NULL,
    Soyad VARCHAR(50) NOT NULL,
    Telefon VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    KayitTarihi DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE Calisan (
    CalisanID INT PRIMARY KEY AUTO_INCREMENT,
    Ad VARCHAR(50) NOT NULL,
    Soyad VARCHAR(50) NOT NULL,
    Pozisyon VARCHAR(50),
    Maas DECIMAL(10,2) CHECK (Maas > 0)
);

CREATE TABLE CekimTuru (
    CekimTuruID INT PRIMARY KEY AUTO_INCREMENT,
    Ad VARCHAR(50) NOT NULL,
    Aciklama VARCHAR(255)
);

CREATE TABLE FotoPaket (
    PaketID INT PRIMARY KEY AUTO_INCREMENT,
    PaketAdi VARCHAR(50) NOT NULL,
    Fiyat DECIMAL(10,2) NOT NULL CHECK (Fiyat > 0),
    Sure INT CHECK (Sure > 0)
);

CREATE TABLE Ekipman (
    EkipmanID INT PRIMARY KEY AUTO_INCREMENT,
    EkipmanAdi VARCHAR(100) NOT NULL,
    Durum ENUM('Uygun', 'Bakimda') DEFAULT 'Uygun',
    Tur VARCHAR(50)
);

CREATE TABLE StudyoOda (
    OdaID INT PRIMARY KEY AUTO_INCREMENT,
    OdaAdi VARCHAR(50) NOT NULL,
    Kapasite INT CHECK (Kapasite > 0),
    Durum ENUM('Uygun', 'Dolu') DEFAULT 'Uygun'
);

CREATE TABLE Randevu (
    RandevuID INT PRIMARY KEY AUTO_INCREMENT,
    MusteriID INT,
    CalisanID INT,
    PaketID INT,
    CekimTuruID INT,
    OdaID INT,
    Tarih DATE NOT NULL,
    Saat TIME NOT NULL,
    Notlar VARCHAR(255),
	Durum ENUM('Planlandi', 'Tamamlandi', 'Iptal') DEFAULT 'Planlandi',
    FOREIGN KEY (MusteriID) REFERENCES Musteri(MusteriID) ON DELETE CASCADE,
    FOREIGN KEY (CalisanID) REFERENCES Calisan(CalisanID) ON DELETE SET NULL,
    FOREIGN KEY (PaketID) REFERENCES FotoPaket(PaketID) ON DELETE SET NULL,
    FOREIGN KEY (CekimTuruID) REFERENCES CekimTuru(CekimTuruID) ON DELETE SET NULL,
    FOREIGN KEY (OdaID) REFERENCES StudyoOda(OdaID) ON DELETE SET NULL
);

CREATE TABLE Odeme (
    OdemeID INT PRIMARY KEY AUTO_INCREMENT,
    RandevuID INT UNIQUE,
    Tutar DECIMAL(10,2) CHECK (Tutar >= 0),
    OdemeTarihi DATE DEFAULT (current_date),
    OdemeTuru ENUM('Nakit', 'Kart') NOT NULL,
    FOREIGN KEY (RandevuID) REFERENCES Randevu(RandevuID) ON DELETE CASCADE
);
