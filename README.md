## Fitness Club Project

Project of database is designed for a local fitness club.
The database stores information about:
* members: name, surname, date of birth, e-mail address, address of residence
* trainers working in the club: name, surname, their experience in profession, address of residence
* trainers' certificates
* members' sports performance
* types of exercise rooms in the gym
* equipment: their type, name, quantity
* sports organized in the club: hour of start, duration, trainer, difficulty level, room, in which their are organized

 The 'czlonkostwo' (membership) table contains information about the types of passes, their type, price and short description.
 
 The gym also has the option of lending equipment to club members. Information on who rented the specific equipment and in what quantity is contained in a separate table *'sprzet_czlonek_wypozyczalnia'* (equipment_member_rental).
 Each member has the option to sign up for sports activities: '*ogólnorozwojowe'* (general development), *'Zumba*', *'dwubój olimpijski*' (olimpic weightlifting) and *'trójbój siłowy'* (powerlifting). Each of them is conducted on various levels of difficulty: *'początkujący'* (beginner), *'średnio-zaawansowany'* (intermediate), *'zaawansowany'* (advanced) and *'pro'*.
 Information about signed up members for specific classes on a specific day are stored in the *'czlonkowie_i_zajecia'* (members_and_classes) table.

Information about the certificates and courses of each trainer can be found in the table *'trenerzy_i_certyfikaty'* (trainers_and_certificates).

### ERD Diagram
![ERd_diagram](https://github.com/wrobel2131/Fitness_Club_Database/blob/main/DiagramERD_fitness_club.png?raw=true)

### Procedures
Project contains couple of procedures, some of them below:
*'Pokaz_Wszystkich_Czlonkow'* (Show_All_Members) - shows information(name, surname, date of birth, email address) of all members of the fitness club

*'Dodaj_czlonka'* (Add_member) - allows to add new member to the database, you need to enter name, surname, date of birth, email address and type of membership.

*'Dodaj_wynik_dla_czlonka'* (add_results_for_member) - allows to add sports results, for example in squat, pull ups or deadlift for specific member, with specific name, surname and date of birth.

*'Pokaz_5_najlepszych_wynikow'* (Show_5_best_scores) - allows to show 5 best results in given discipline along with the members to whom the results belongs.
When performing the procedure, one of the following disciplines should be specified: *'Trójbój'* (Powerlifting), *'Dwubój'* (olimpic weightlifting), *'Crossfit'*, *'Kalistenika'* (Calisthenics).

### Views
*'v_czlonkowie_i_wyniki'* (v_members_and_results) - shows all members signed up to a specific day of the week for specific classes at a specific time

*'v_dzien_tygodnia_i_zapisy'* (v_day_of_the_week_and_entries) - shows the number of entries for each day of the week

*'v_trenerzy_certyfikaty'* (v_trainers_certificates) - shows all certificates of each trainer

*'v_wypozyczalnia_sprzet_czlonkowie'* (rental_equipment_members) - shows members, who rented the equipment as well as the quantity, type and name of the equipment

### Triggers
Trigger example:
*'wyniki_before_insert_check'* - checks when entering sports results if any of the scores is below zero. If so, an error message is displayed

<small>*Project made by Dawid Wróbel for database classes.*<small>

