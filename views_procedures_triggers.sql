-- Widoki

DROP VIEW IF EXISTS `v_czlonkowie_i_wyniki`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_czlonkowie_i_wyniki` AS select `c`.`imie` AS `imie`,`c`.`nazwisko` AS `nazwisko`,concat((`w`.`przysiad` + `w`.`wyciskanie_lezac` + `w`.`martwy_ciag`),' kg') AS `Total Trójbój > 400`,concat((`w`.`rwanie` + `w`.`podrzut`),' kg') AS `Total Dwubój > 180` from (`czlonek` `c` join `wyniki_sportowe` `w`) where ((`c`.`id_wyniki` = `w`.`id_wyniki`) and (((`w`.`przysiad` + `w`.`wyciskanie_lezac` + `w`.`martwy_ciag`) > 400) and ((`w`.`rwanie` + `w`.`podrzut`) > 180)));

-- ---------------------------------------------------------------------

DROP VIEW IF EXISTS `v_czlonkowie_na_zajeciach`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_czlonkowie_na_zajeciach` AS select `c`.`imie` AS `Imie`,`c`.`nazwisko` AS `Nazwisko`,`d`.`nazwa_dzien` AS `Dzień tygodnia`,concat(`zt`.`nazwa_typ`,' ',`pt`.`nazwa`) AS `Zajęcia`,`zs`.`poczatek_zajecia` AS `Godzina rozpoczęcia` from ((((((`czlonek` `c` join `dzien_tygodnia` `d`) join `zajecia_dzien_tygodnia` `zdt`) join `czlonkowie_i_zajecia` `ciz`) join `typ_zajec` `zt`) join `poziom_trudnosci_zajec` `pt`) join `zajecia_sportowe` `zs`) where ((`c`.`id_czlonek` = `ciz`.`id_czlonek`) and (`ciz`.`id_dzien_tygodnia_zajecia` = `zdt`.`id_dzien_tygodnia_zajecia`) and (`zdt`.`id_dzien_tygodnia` = `d`.`id_dzien_tygodnia`) and (`zdt`.`id_zajecia` = `zs`.`id_zajecia`) and (`zs`.`id_typ` = `zt`.`id_typ`) and (`zs`.`id_poziom_trudnosci` = `pt`.`id_poziom_trudnosci`)) order by `c`.`imie`;

-- ---------------------------------------------------------------------

DROP VIEW IF EXISTS `v_dzien_tygodnia_i_zapisy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_dzien_tygodnia_i_zapisy` AS select `d`.`nazwa_dzien` AS `Dzien tygodnia`,count(`ciz`.`id_czlonek`) AS `Liczba zapisów na zajęcia` from ((`dzien_tygodnia` `d` join `zajecia_dzien_tygodnia` `dtz`) join `czlonkowie_i_zajecia` `ciz`) where ((`ciz`.`id_dzien_tygodnia_zajecia` = `dtz`.`id_dzien_tygodnia_zajecia`) and (`dtz`.`id_dzien_tygodnia` = `d`.`id_dzien_tygodnia`)) group by `d`.`nazwa_dzien` order by `d`.`id_dzien_tygodnia`;

-- ---------------------------------------------------------------------

DROP VIEW IF EXISTS `v_trenerzy_certyfikaty`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_trenerzy_certyfikaty` AS select `t`.`imie` AS `Imie`,`t`.`nazwisko` AS `Nazwisko`,`t`.`doswiadczenie` AS `Doswiadczenie(lata)`,`c`.`nazwa_certyfikat` AS `Nazwa ukończonego kursu`,`c`.`opis_certyfikat` AS `Informacje o kursie` from ((`trener` `t` join `certyfikat` `c`) join `trenerzy_i_certyfikaty` `wszys`) where ((`wszys`.`id_certyfikat` = `c`.`id_certyfikat`) and (`wszys`.`id_trener` = `t`.`id_trener`));

-- ---------------------------------------------------------------------

DROP VIEW IF EXISTS `v_wypozyczony_sprzet_czlonkowie`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_wypozyczony_sprzet_czlonkowie` AS select `c`.`imie` AS `Imie`,`c`.`nazwisko` AS `Nazwisko`,concat(`wyp`.`ilosc_wypozyczona`,' x ',`s`.`nazwa_sprzet`,'(',`t`.`nazwa_typ_sprzet`,')') AS `Wypożyczony sprzęt` from (((`czlonek` `c` join `sprzet_czlonek_wypozyczalnia` `wyp` on((`c`.`id_czlonek` = `wyp`.`id_czlonek`))) join `sprzet` `s` on((`wyp`.`id_sprzet` = `s`.`id_sprzet`))) join `typ_sprzetu` `t` on((`s`.`id_typ_sprzet` = `t`.`id_typ_sprzet`))) order by `c`.`imie`;

-- ---------------------------------------------------------------------

-- Procedury

DROP PROCEDURE IF EXISTS `Dodaj_adres`;
delimiter ;;
CREATE PROCEDURE `Dodaj_adres`(IN `vulica` varchar(100),IN `vbudynek` int,IN `vlokal` int,IN `vkod_pocztowy` int,IN `vmiasto` varchar(100))
BEGIN
	insert into adres(ulica, budynek, lokal, kod_pocztowy, miasto) values (vulica, vbudynek, vlokal, vkod_pocztowy, vmiasto);

END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Dodaj_adres_dla_czlonka`;
delimiter ;;
CREATE PROCEDURE `Dodaj_adres_dla_czlonka`(IN `vimie` varchar(100),IN `vnazwisko` varchar(100),IN `vdata_urodzenia` date,IN `vulica` varchar(100),IN `vbudynek` int,IN `vlokal` int,IN `vkod_pocztowy` int,IN `vmiasto` varchar(100))
BEGIN
	call Dodaj_adres(vulica, vbudynek, vlokal, vkod_pocztowy, vmiasto);
	UPDATE czlonek c
	set c.id_adres = LAST_INSERT_ID()
	WHERE c.imie = vimie and c.nazwisko = vnazwisko and c.data_urodzenia = vdata_urodzenia;

END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Dodaj_czlonka`;
delimiter ;;
CREATE PROCEDURE `Dodaj_czlonka`(IN `vimie` varchar(100),IN `vnazwisko` varchar(100),IN `vdata_urodzenia` date,IN `vemail` varchar(100),IN `vid_czlonkostwo` int)
BEGIN
	insert into czlonek(imie, nazwisko, data_urodzenia, email, id_adres, id_czlonkostwo, id_wyniki) values (vimie, vnazwisko, vdata_urodzenia, vemail, NULL, vid_czlonkostwo, NULL);
END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Dodaj_wynik_dla_czlonka`;
delimiter ;;
CREATE PROCEDURE `Dodaj_wynik_dla_czlonka`(IN `vimie` varchar(100),IN `vnazwisko` varchar(100),IN `vdata_urodzenia` date,IN `vprzysiad` int,IN `vwyciskanie_lezac` int,IN `vmartwy_ciag` int,IN `vrwanie` int,IN `vpodrzut` int,IN `vcrossfit_complex` time,IN `vpompki` int,IN `vpodciagniecia` int)
BEGIN
	CALL Dodaj_wynik_sportowy(vprzysiad, vwyciskanie_lezac, vmartwy_ciag, vrwanie, vpodrzut, vcrossfit_complex, vpompki, vpodciagniecia);
	update czlonek c
	SET c.id_wyniki = LAST_INSERT_ID()
	where c.imie = vimie and c.nazwisko = vnazwisko and c.data_urodzenia = vdata_urodzenia;

END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Dodaj_wynik_sportowy`;
delimiter ;;
CREATE PROCEDURE `Dodaj_wynik_sportowy`(IN `vprzysiad` int,IN `vwyciskanie_lezac` int,IN `vmartwy_ciag` int,IN `vrwanie` int,IN `vpodrzut` int,IN `vcrossfit_complex` time,IN `vpompki` int,IN `vpodciagniecia` int)
BEGIN
	insert into wyniki_sportowe(przysiad, wyciskanie_lezac, martwy_ciag, rwanie, podrzut, crossfit_complex, pompki, podciagniecia_bw) values (vprzysiad, vwyciskanie_lezac, vmartwy_ciag, vrwanie, vpodrzut, vcrossfit_complex, vpompki, vpodciagniecia);

END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Pokaz_5_najlepszych_wynikow`;
delimiter ;;
CREATE PROCEDURE `Pokaz_5_najlepszych_wynikow`(IN `dyscyplina` varchar(100))
BEGIN

	Case
		when dyscyplina = "Trójbój" then 
			select c.imie, c.nazwisko, concat(w.przysiad + w.wyciskanie_lezac + w.martwy_ciag, " kg") as "Trójbój Total" from 			czlonek c, wyniki_sportowe w where c.id_wyniki = w.id_wyniki and (w.przysiad + w.wyciskanie_lezac + w.martwy_ciag) 				> 420 ORDER BY (w.przysiad + w.wyciskanie_lezac + w.martwy_ciag) DESC limit 5;
		when dyscyplina = "Dwubój" then
			select c.imie, c.nazwisko, concat(w.rwanie + w.podrzut, " kg") as "Dwubój Total" from czlonek c, wyniki_sportowe w 				where c.id_wyniki = w.id_wyniki and (w.rwanie + w.podrzut) > 180 ORDER BY (w.rwanie + w.podrzut) DESC limit 5;
		when dyscyplina = "Crossfit" then
			select c.imie, c.nazwisko, w.crossfit_complex as "Full Crossfit Complex" from czlonek c, wyniki_sportowe w where c.				id_wyniki = w.id_wyniki and w.crossfit_complex < CAST("00:03:00" as time) and w.crossfit_complex != CAST( "00:00:00" as time) ORDER BY w.crossfit_complex limit 5;
		when dyscyplina = "Kalistenika" then
			select c.imie, c.nazwisko, w.pompki as "Ilość pompek", w.podciagniecia_bw as "Ilość podciągnięć na drążku z własną 	masą ciała" from czlonek c, wyniki_sportowe w where c.id_wyniki = w.id_wyniki and w.pompki > 30 and w.podciagniecia_bw > 10 order by (w.podciagniecia_bw+w.pompki) DESC limit 5;
		else
			signal SQLSTATE '45000'
				set MESSAGE_TEXT = 'Blędna dyscyplina';
				end case;

END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `Pokaz_Wszystkich_Czlonkow`;
delimiter ;;
CREATE PROCEDURE `Pokaz_Wszystkich_Czlonkow`()
begin
	select c.imie as "Imie", c.nazwisko as "Nazwisko", c.data_urodzenia as "Data urodzenia", c.email as "Adres email" from czlonek c;
end
;;
delimiter ;

-- ---------------------------------------------------------------------

-- Wyzwalacze


DROP TRIGGER IF EXISTS `dane_before_insert`;
delimiter ;;
CREATE TRIGGER `dane_before_insert` BEFORE INSERT ON `czlonek` FOR EACH ROW BEGIN
set new.imie = trim(new.imie);
set new.nazwisko = trim(new.nazwisko);
END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP TRIGGER IF EXISTS `dane_capitalize_before_insert`;
delimiter ;;
CREATE TRIGGER `dane_capitalize_before_insert` BEFORE INSERT ON `czlonek` FOR EACH ROW begin
		set new.imie = CONCAT(UCASE(LEFT(new.imie,1)), SUBSTRING(new.imie, 2));
		set new.nazwisko = CONCAT(UCASE(LEFT(new.nazwisko,1)), SUBSTRING(new.nazwisko, 2));
END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP TRIGGER IF EXISTS `dane_capitalize_before_update`;
delimiter ;;
CREATE TRIGGER `dane_capitalize_before_update` BEFORE UPDATE ON `czlonek` FOR EACH ROW begin
		set new.imie = CONCAT(UCASE(LEFT(new.imie,1)), SUBSTRING(new.imie, 2));
		set new.nazwisko = CONCAT(UCASE(LEFT(new.nazwisko,1)), SUBSTRING(new.nazwisko, 2));
end
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP TRIGGER IF EXISTS `dane_before_update`;
delimiter ;;
CREATE TRIGGER `dane_before_update` BEFORE UPDATE ON `czlonek` FOR EACH ROW BEGIN
set new.imie = trim(new.imie);
set new.nazwisko = trim(new.nazwisko);
END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP TRIGGER IF EXISTS `wyniki_before_insert_check`;
delimiter ;;
CREATE TRIGGER `wyniki_before_insert_check` BEFORE INSERT ON `wyniki_sportowe` FOR EACH ROW begin
		if (new.przysiad < 0 or new.wyciskanie_lezac < 0 or new.martwy_ciag < 0 or new.podrzut < 0 or new.rwanie < 0 or new.pompki < 0 or new.podciagniecia_bw < 0) then
			signal sqlstate '45000' set message_text = "Wynik w ćwiczeniu  nie może być ujemny";
		else
				set new.przysiad = new.przysiad;
				set new.wyciskanie_lezac = new.wyciskanie_lezac;
				set new.martwy_ciag = new.martwy_ciag;
				set new.podrzut = new.podrzut;
				set new.rwanie = new.rwanie;
				set new.pompki = new.pompki;
				set new.podciagniecia_bw = new.podciagniecia_bw;
			end if;
END
;;
delimiter ;

-- ---------------------------------------------------------------------

DROP TRIGGER IF EXISTS `wyniki_before_update_check`;
delimiter ;;
CREATE TRIGGER `wyniki_before_update_check` BEFORE UPDATE ON `wyniki_sportowe` FOR EACH ROW begin
		if (new.przysiad < 0) then
				set new.przysiad = 0;
		end if;
		if (new.wyciskanie_lezac < 0) then
				set new.wyciskanie_lezac = 0;
		end if;
		if (new.martwy_ciag < 0) then
				set new.martwy_ciag = 0;
		end if;
		if (new.podrzut < 0) then
				set new.podrzut = 0;
		end if;
		if (new.rwanie < 0) then
				set new.rwanie = 0;
		end if;
		if (new.pompki < 0) then
				set new.pompki = 0;
		end if;
		if (new.podciagniecia_bw < 0) then
				set new.podciagniecia_bw = 0;
		end if;
		
END
;;
delimiter ;

-- ---------------------------------------------------------------------

