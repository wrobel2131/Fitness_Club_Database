-- Tworzenie tabel

DROP TABLE IF EXISTS `adres`;
CREATE TABLE `adres`  (
  `id_adres` int NOT NULL AUTO_INCREMENT,
  `ulica` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `budynek` int NULL DEFAULT NULL,
  `lokal` int NULL DEFAULT NULL,
  `kod_pocztowy` int(5) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `miasto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_adres`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `certyfikat`;
CREATE TABLE `certyfikat`  (
  `id_certyfikat` int NOT NULL AUTO_INCREMENT,
  `nazwa_certyfikat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `opis_certyfikat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_certyfikat`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `czlonek`;
CREATE TABLE `czlonek`  (
  `id_czlonek` int NOT NULL AUTO_INCREMENT,
  `imie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nazwisko` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `data_urodzenia` date NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id_adres` int NULL DEFAULT NULL,
  `id_czlonkostwo` int NOT NULL,
  `id_wyniki` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_czlonek`) USING BTREE,
  INDEX `id_czlonkostwo`(`id_czlonkostwo`) USING BTREE,
  INDEX `id_wyniki`(`id_wyniki`) USING BTREE,
  INDEX `id_adres`(`id_adres`) USING BTREE,
  CONSTRAINT `czlonek_ibfk_2` FOREIGN KEY (`id_czlonkostwo`) REFERENCES `czlonkostwo` (`id_czlonkostwo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `czlonek_ibfk_3` FOREIGN KEY (`id_wyniki`) REFERENCES `wyniki_sportowe` (`id_wyniki`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `czlonek_ibfk_4` FOREIGN KEY (`id_adres`) REFERENCES `adres` (`id_adres`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `czlonkostwo`;
CREATE TABLE `czlonkostwo`  (
  `id_czlonkostwo` int NOT NULL AUTO_INCREMENT,
  `typ_czlonkostwo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cena_czlonkostwo` int NOT NULL,
  `opis_czlonkostwo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_czlonkostwo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `czlonkowie_i_zajecia`;
CREATE TABLE `czlonkowie_i_zajecia`  (
  `id_czlonek` int NOT NULL,
  `id_dzien_tygodnia_zajecia` int NOT NULL,
  PRIMARY KEY (`id_dzien_tygodnia_zajecia`, `id_czlonek`) USING BTREE,
  INDEX `id_czlonek`(`id_czlonek`) USING BTREE,
  CONSTRAINT `czlonkowie_i_zajecia_ibfk_1` FOREIGN KEY (`id_czlonek`) REFERENCES `czlonek` (`id_czlonek`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `czlonkowie_i_zajecia_ibfk_2` FOREIGN KEY (`id_dzien_tygodnia_zajecia`) REFERENCES `zajecia_dzien_tygodnia` (`id_dzien_tygodnia_zajecia`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `dzien_tygodnia`;
CREATE TABLE `dzien_tygodnia`  (
  `id_dzien_tygodnia` int NOT NULL AUTO_INCREMENT,
  `nazwa_dzien` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_dzien_tygodnia`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `poziom_trudnosci_zajec`;
CREATE TABLE `poziom_trudnosci_zajec`  (
  `id_poziom_trudnosci` int NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_poziom_trudnosci`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `sala_cwiczen`;
CREATE TABLE `sala_cwiczen`  (
  `id_sala` int NOT NULL AUTO_INCREMENT,
  `nazwa` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_sala`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `sprzet`;
CREATE TABLE `sprzet`  (
  `id_sprzet` int NOT NULL AUTO_INCREMENT,
  `nazwa_sprzet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ilosc` int NULL DEFAULT NULL,
  `id_typ_sprzet` int NOT NULL,
  PRIMARY KEY (`id_sprzet`) USING BTREE,
  INDEX `id_typ_sprzet`(`id_typ_sprzet`) USING BTREE,
  CONSTRAINT `sprzet_ibfk_1` FOREIGN KEY (`id_typ_sprzet`) REFERENCES `typ_sprzetu` (`id_typ_sprzet`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `sprzet_czlonek_wypozyczalnia`;
CREATE TABLE `sprzet_czlonek_wypozyczalnia`  (
  `id_czlonek` int NOT NULL,
  `id_sprzet` int NOT NULL,
  `ilosc_wypozyczona` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_sprzet`, `id_czlonek`) USING BTREE,
  INDEX `id_czlonek`(`id_czlonek`) USING BTREE,
  CONSTRAINT `sprzet_czlonek_wypozyczalnia_ibfk_1` FOREIGN KEY (`id_czlonek`) REFERENCES `czlonek` (`id_czlonek`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sprzet_czlonek_wypozyczalnia_ibfk_2` FOREIGN KEY (`id_sprzet`) REFERENCES `sprzet` (`id_sprzet`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `trener`;
CREATE TABLE `trener`  (
  `id_trener` int NOT NULL AUTO_INCREMENT,
  `imie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nazwisko` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `doswiadczenie` int NULL DEFAULT NULL,
  `id_adres` int NULL DEFAULT NULL,
  PRIMARY KEY (`id_trener`) USING BTREE,
  INDEX `id_adres`(`id_adres`) USING BTREE,
  CONSTRAINT `trener_ibfk_1` FOREIGN KEY (`id_adres`) REFERENCES `adres` (`id_adres`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `trenerzy_i_certyfikaty`;
CREATE TABLE `trenerzy_i_certyfikaty`  (
  `id_trener` int NOT NULL,
  `id_certyfikat` int NOT NULL,
  PRIMARY KEY (`id_trener`, `id_certyfikat`) USING BTREE,
  INDEX `id_certyfikat`(`id_certyfikat`) USING BTREE,
  CONSTRAINT `trenerzy_i_certyfikaty_ibfk_1` FOREIGN KEY (`id_trener`) REFERENCES `trener` (`id_trener`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `trenerzy_i_certyfikaty_ibfk_2` FOREIGN KEY (`id_certyfikat`) REFERENCES `certyfikat` (`id_certyfikat`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `typ_sprzetu`;
CREATE TABLE `typ_sprzetu`  (
  `id_typ_sprzet` int NOT NULL AUTO_INCREMENT,
  `nazwa_typ_sprzet` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_typ_sprzet`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `typ_zajec`;
CREATE TABLE `typ_zajec`  (
  `id_typ` int NOT NULL AUTO_INCREMENT,
  `nazwa_typ` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_typ`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `wyniki_sportowe`;
CREATE TABLE `wyniki_sportowe`  (
  `id_wyniki` int NOT NULL AUTO_INCREMENT,
  `przysiad` int NULL DEFAULT 0,
  `wyciskanie_lezac` int NULL DEFAULT 0,
  `martwy_ciag` int NULL DEFAULT 0,
  `rwanie` int NULL DEFAULT 0,
  `podrzut` int NULL DEFAULT 0,
  `crossfit_complex` time NULL DEFAULT '00:00:00',
  `pompki` int NULL DEFAULT 0,
  `podciagniecia_bw` int NULL DEFAULT 0,
  PRIMARY KEY (`id_wyniki`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `zajecia_dzien_tygodnia`;
CREATE TABLE `zajecia_dzien_tygodnia`  (
  `id_dzien_tygodnia_zajecia` int NOT NULL AUTO_INCREMENT,
  `id_zajecia` int NOT NULL,
  `id_dzien_tygodnia` int NOT NULL,
  PRIMARY KEY (`id_dzien_tygodnia_zajecia`) USING BTREE,
  INDEX `id_zajecia`(`id_zajecia`) USING BTREE,
  INDEX `id_dzien_tygodnia`(`id_dzien_tygodnia`) USING BTREE,
  CONSTRAINT `zajecia_dzien_tygodnia_ibfk_1` FOREIGN KEY (`id_zajecia`) REFERENCES `zajecia_sportowe` (`id_zajecia`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `zajecia_dzien_tygodnia_ibfk_2` FOREIGN KEY (`id_dzien_tygodnia`) REFERENCES `dzien_tygodnia` (`id_dzien_tygodnia`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `zajecia_sportowe`;
CREATE TABLE `zajecia_sportowe`  (
  `id_zajecia` int NOT NULL AUTO_INCREMENT,
  `poczatek_zajecia` time NOT NULL,
  `koniec_zajecia` time GENERATED ALWAYS AS (addtime(`poczatek_zajecia`,`czas_trwania_zajecia`)) STORED NULL,
  `id_typ` int NOT NULL,
  `id_trener` int NOT NULL,
  `id_poziom_trudnosci` int NOT NULL,
  `id_sala` int NOT NULL,
  `czas_trwania_zajecia` time NOT NULL,
  PRIMARY KEY (`id_zajecia`) USING BTREE,
  INDEX `id_typ`(`id_typ`) USING BTREE,
  INDEX `id_trener`(`id_trener`) USING BTREE,
  INDEX `id_poziom_trudnosci`(`id_poziom_trudnosci`) USING BTREE,
  INDEX `id_sala`(`id_sala`) USING BTREE,
  CONSTRAINT `zajecia_sportowe_ibfk_1` FOREIGN KEY (`id_typ`) REFERENCES `typ_zajec` (`id_typ`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `zajecia_sportowe_ibfk_2` FOREIGN KEY (`id_trener`) REFERENCES `trener` (`id_trener`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `zajecia_sportowe_ibfk_3` FOREIGN KEY (`id_poziom_trudnosci`) REFERENCES `poziom_trudnosci_zajec` (`id_poziom_trudnosci`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `zajecia_sportowe_ibfk_4` FOREIGN KEY (`id_sala`) REFERENCES `sala_cwiczen` (`id_sala`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;




