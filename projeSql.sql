use fotostudiodb;
-- 3 farklı tabloya kayıt ekleme yaptık
INSERT INTO Musteri (Ad, Soyad, Telefon, Email,KayitTarihi)
VALUES ('islam', 'Dzhalilov', '89200045227', 'dzhalilov.islam@gmail.com', '2025-09-23');

INSERT INTO Calisan (Ad, Soyad, Pozisyon, Maas)
VALUES ('Ahmet', 'Yılmaz', 'Fotoğrafçı', 18000);

INSERT INTO StudyoOda (OdaAdi, Kapasite, Durum)
VALUES ('Studio X', 6, 'Uygun');

-- 5 farklı kaydı aynı tabloya ekledik
INSERT INTO Randevu
( MusteriID, CalisanID, PaketID, CekimTuruID,Tarih, Saat, Durum, Notlar)
VALUES
(31, 10, 2, 1, '2026-05-05', '10:00', 'Planlandi', 'Stüdyo çekimi'),
(29, 15, 11, 2, '2025-06-12', '11:30', 'Planlandi', 'Dış mekan çekimi'),
(15, 24, 30, 26, '2025-02-25', '13:00', 'Tamamlandi', 'Konser çekimi'),
(10, 5, 7, 3, '2025-04-14', '15:00', 'Iptal', 'Düğün hazırlık'),
(16, 27, 14, 7, '2025-11-05', '16:30', 'Planlandi', 'Aile çekimi');

-- 3 farklı tabloda güncelleme işlemi
UPDATE Musteri
SET Telefon = '5504856694'
WHERE MusteriID = 22;

UPDATE Calisan
SET Maas = Maas + 1000
WHERE CalisanID = 28;

UPDATE FotoPaket
SET Fiyat = 1600
WHERE PaketID = 3;

-- 3 farklı tablodan silme işlemi
DELETE FROM Odeme
WHERE OdemeID = 10;

DELETE FROM Randevu
WHERE RandevuID = 15;

DELETE FROM Ekipman
WHERE EkipmanID = 6;

-- where karşılaştırma operatörleri
SELECT * FROM Musteri WHERE MusteriID > 5;
SELECT * FROM FotoPaket WHERE Fiyat >= 1000;
SELECT * FROM Calisan WHERE Maas < 15000;

-- where ile aritmetik operatörleri
SELECT *, Fiyat * 1.18 AS KDVliFiyat FROM FotoPaket WHERE Fiyat * 1.18 > 1000;
SELECT CalisanID, Maas - 500 AS IndirimliMaas FROM Calisan WHERE Maas - 500 < 15000;
SELECT PaketID, Sure + 10 AS YeniSure FROM FotoPaket WHERE Sure + 10 >= 50;

-- where ile mantıksal operatörler
SELECT * FROM Musteri WHERE Ad = 'Ayşe' AND Soyad = 'Kara';
SELECT * FROM Calisan WHERE Maas > 15000 OR Pozisyon = 'Asistan';
SELECT * FROM Ekipman WHERE Durum = 'Uygun' AND Tur = 'Işık';

-- ÖZEL OPERATÖRLER (BETWEEN – LIKE – IN - İS NULL – EXISTS)
-- BETWEEN
 SELECT * FROM FotoPaket WHERE Fiyat BETWEEN 500 AND 2000;
 -- LİKE
 SELECT * FROM Musteri WHERE Ad LIKE 'A%';
 -- İN
 SELECT * FROM Calisan WHERE Pozisyon IN ('Fotoğrafçı', 'Makyöz');
 -- EXİSTS
Select * From Musteri m Where
Exists (
Select 1 From Randevu r 
Where r.RandevuID = m.MusteriID
);
-- İS NULL
SELECT * FROM Randevu WHERE CalisanID IS NULL;

-- ORDER BY 3 sorgu
SELECT * FROM Musteri ORDER BY Ad ASC;
SELECT * FROM Calisan ORDER BY Maas DESC;
SELECT * FROM FotoPaket ORDER BY Fiyat ASC;

-- DISTINCT
SELECT DISTINCT Pozisyon FROM Calisan;
SELECT DISTINCT Durum FROM Ekipman;
SELECT DISTINCT OdemeTuru FROM Odeme;

-- STRİNG fonksiyonları
SELECT UPPER(Ad) FROM Musteri where MusteriID < 5;
SELECT LOWER(Soyad) FROM Musteri where Soyad like 'K%' ;
SELECT CONCAT(Ad, ' ', Soyad) AS TamAd FROM Musteri;
SELECT LENGTH(Ad) FROM Musteri;
SELECT SUBSTRING(Email, 1, 5) FROM Musteri;
SELECT REPLACE(Email, '@gmail.com', '@example.com') FROM Musteri where MusteriID < 5;
SELECT LEFT(Ad, 2) FROM Musteri;

-- sayısal fonksiyonlar 
SELECT ABS(Maas) FROM calisan;
SELECT CEIL(Tutar) FROM Odeme;
SELECT FLOOR(Fiyat) FROM FotoPaket;
SELECT ROUND(Maas, 2) FROM calisan;
SELECT MOD(Sure, 2) FROM FotoPaket;
SELECT POWER(Fiyat, 2) FROM FotoPaket;
SELECT SQRT(Tutar) FROM Odeme;

-- tarihi fonksiyonlar
SELECT CURDATE();
SELECT NOW();
SELECT DATE_ADD(Tarih, INTERVAL 5 DAY) FROM Randevu;
SELECT DATE_SUB(Tarih, INTERVAL 2 DAY) FROM Randevu;
SELECT YEAR(Tarih) FROM Randevu;
SELECT MONTH(Tarih) FROM Randevu;
SELECT DAY(Tarih) FROM Randevu;
SELECT DAYNAME(Tarih) FROM Randevu;
SELECT DATEDIFF(CURDATE(), KayitTarihi) FROM Musteri;
SELECT TIMESTAMPDIFF(HOUR, '2025-02-01', '2025-02-05');

-- toplu fonksiyonlar 
SELECT COUNT(*) FROM Musteri;
SELECT MIN(Fiyat) FROM FotoPaket;
SELECT MAX(Maas) FROM Calisan;
SELECT SUM(Fiyat) FROM FotoPaket;
SELECT AVG(Maas) FROM Calisan;

-- limit
SELECT * FROM Randevu
ORDER BY Tarih ASC
LIMIT 1;

-- rollup
SELECT CalisanID, COUNT(*)
FROM Randevu
GROUP BY CalisanID WITH ROLLUP;

-- group by ile 3 sorgu
-- çekim türüne göre randevu sayısı 
SELECT CekimTuruID, COUNT(*) AS ToplamRandevu
FROM Randevu
GROUP BY CekimTuruID;
-- duruma göre randevu sayısı
SELECT Durum, COUNT(*) AS Adet
FROM Randevu
GROUP BY Durum;
-- tarihe göre randevu sayısı
SELECT Tarih, COUNT(*) AS GunlukRandevu
FROM Randevu
GROUP BY Tarih;

-- Toplu fonkdiyonlar ile 3 sorgu 
-- toplam randevu sayısı
SELECT COUNT(*) AS ToplamRandevu
FROM Randevu;
-- en erken ve en geç tarihli randevu sayısı 
SELECT 
MIN(Tarih) AS EnErkenRandevu,
MAX(Tarih) AS EnGecRandevu
FROM Randevu;
-- stüdyoların ortalama kapasite
SELECT AVG(Kapasite) AS OrtalamaKapasite
FROM StudyoOda;

-- Having ile 3 sorgu
-- 2 den fazla randevu olan çalışanlar 
SELECT CalisanID, COUNT(*) AS RandevuSayisi
FROM Randevu
GROUP BY CalisanID
HAVING COUNT(*) >= 2;
-- en az 2 kez yapılan çekim türleri
SELECT CekimTuruID, COUNT(*) AS Adet
FROM Randevu
GROUP BY CekimTuruID
HAVING COUNT(*) >= 2;
-- stüdyo kapasitesi 5 ten fazla olanlar (ortalama)
SELECT OdaAdi, AVG(Kapasite) AS OrtKapasite
FROM StudyoOda
GROUP BY OdaAdi
HAVING AVG(Kapasite) > 5;

-- LEFT JOIN
-- muşterinin ismini soyismini ve ona bağlı çekim türünü gösterir
SELECT m.Ad, m.Soyad, c.Ad AS CekimTuru
 FROM Musteri m LEFT JOIN Randevu r ON m.MusteriID=r.MusteriID
 LEFT JOIN CekimTuru c ON r.CekimTuruID=c.CekimTuruID;
 
 -- RIGHT JOIN
 -- Çalışanın ismini ,soyismini, pozisyonunu ve ona bağlı paket adını listeler
 SELECT c.Ad, c.Soyad, c.Pozisyon , f.PaketAdi 
 FROM Calisan c  
 RIGHT JOIN Randevu r ON c.CalisanID=r.CalisanID
 RIGHT JOIN FotoPaket f ON r.PaketID=f.PaketID;
 
 -- 2 tabloyu birleştirerek 3 Join sorgusu
 -- oda adını ve randevudan saati ve notları listeler
 SELECT d.OdaAdi, r.Saat, r.Notlar
 FROM StudyoOda d INNER JOIN
 Randevu r On d.OdaID=r.OdaID;
 -- müşterilerin randevu durumunu görüntülüyor
SELECT m.Ad, m.Soyad, r.Durum
FROM Musteri m LEFT JOIN 
Randevu r ON m.MusteriID=r.MusteriID;
 -- müşterilerin adını mailini ve saatini listeliyor
 SELECT m.AD, m.Email, r.Saat 
 FROM Musteri m RIGHT JOIN
 Randevu r ON m.MusteriID=r.MusteriID;
 
 -- 3 tabloyu birleştirerek 3 Joın orgusu
 -- Müşterini adı mailini ve çekim türünü listel,yor
 SELECT m.Ad, m.Email, ct.Ad As CekimTuru
 FROM Musteri m 
 LEFT JOIN Randevu r ON m.MusteriID=r.MusteriID
 LEFT JOIN CekimTuru ct ON r.CekimTuruID=ct.CekimTuruID
 WHERE r.MusteriID > 79;
 -- çekimden açıklamayı alıp odeme turunu ve tutarını listelemek 
 SELECT ct.Aciklama, od.Tutar, od.OdemeTuru
 FROM Randevu r
 RIGHT JOIN CekimTuru ct ON  r.CekimTuruID = ct.CekimTuruID
 RIGHT JOIN Odeme od ON r.RandevuID=od.RandevuID;
 -- Ödeme Idsini , randevu tarihini ve paket adını listeledik 
 SELECT od.OdemeID, r.Tarih, p.PaketAdi
 FROM Odeme od
 INNER JOIN Randevu r ON od.RandevuID = r.RandevuID
 INNER JOIN FotoPaket p ON r.PaketID = p.PaketID;
 
 






