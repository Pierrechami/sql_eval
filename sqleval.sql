CREATE DATABASE IF NOT EXISTS cinema_reservation_complex;

USE cinema_reservation_complex;

-- création des tables -- 

CREATE TABLE complex_cinema (
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR (60) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE cinema(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    adress VARCHAR(250) NOT NULL,
    city VARCHAR (60) NOT NULL,
    id_complex_cinema INT(10),
    id_administrateur INT(10),
    FOREIGN KEY (id_complex_cinema) REFERENCES complex_cinema(id),
    FOREIGN KEY (id_administrateur) REFERENCES adminstrateur(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE seance(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    hall INT(1) NOT NULL,
    nbr_place INT(5) NOT NULL,
    id_cinema INT(10),
    FOREIGN KEY (id_cinema) REFERENCES cinema(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE film(
    id INT(100) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    time TIME NOT NULL,
    id_genre INT(100) NOT NULL,
    FOREIGN KEY (id_genre) REFERENCES genre(id)
   )ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE genre(
    id INT(100) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom_genre VARCHAR(60) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE tarif(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    price DECIMAL(4,2)NOT NULL,
    type_price VARCHAR (60) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE reservation (
    id CHAR(36) NOT NULL PRIMARY KEY,
    start_movie DATETIME NOT NULL,
    id_customer CHAR(36) NOT NULL,
    id_film INT(100) NOT NULL,
    id_seance INT(60) NOT NULL,
    id_cinema INT(10) NOT NULL,
    FOREIGN KEY (id_cinema) REFERENCES cinema(id),
    FOREIGN KEY (id_customer) REFERENCES customer(id),
    FOREIGN KEY (id_film) REFERENCES film(id),
    FOREIGN KEY (id_seance) REFERENCES seance(id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE paiement(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    type_paiement VARCHAR(60)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE customer(
    id CHAR(36) PRIMARY KEY NOT NULL,
    last_name VARCHAR(20) NOT NULL ,
    first_name VARCHAR(20) NOT NULL ,
    age INT(2) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    passeword CHAR(60) NOT NULL,
    id_paiement INT(10) NOT NULL,
    id_tarif INT(10) NOT NULL,
    FOREIGN KEY (id_tarif) REFERENCES tarif(id),
    FOREIGN KEY (id_paiement) REFERENCES paiement(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE administrateur(
    id INT(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(60) NOT NULL ,
    first_name VARCHAR(60) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- Ajout des valeurs -- 

insert into administrateur (first_name, last_name) values ('Rhonda', 'Ingle');
insert into administrateur (first_name, last_name) values ('Vera', 'Rickson');
insert into administrateur (first_name, last_name) values ('Aileen', 'Papps');
insert into administrateur (first_name, last_name) values ('Isaiah', 'Lamey');

insert into complex_cinema (id, name) values ('1','Gaumont');

insert into cinema(id, name, adress, city, id_complex_cinema, id_administrateur) values ('1','confluence', 'Rue des cerisiers', 'Paris 1', '1', '1');
insert into cinema(id, name, adress, city, id_complex_cinema, id_administrateur) values ('2','Les 2 rivières', 'Rue des eaux', 'Paris 2', '1', '2');
insert into cinema(id, name, adress, city, id_complex_cinema, id_administrateur) values ('3','Le fleuve', 'Rue du coin', 'Paris 3', '1', '3');
insert into cinema(id, name, adress, city, id_complex_cinema, id_administrateur) values ('4','La Seine', 'Rue de rivoli', 'Paris 4', '1', '4');


insert into seance(hall, nbr_place, id_cinema) values ('1', '50', '1'), ('2', '70', '1'), ('3','100','1');
insert into seance(hall, nbr_place, id_cinema) values ('1', '50', '2'), ('2', '70', '2'), ('3','100','2');
insert into seance(hall, nbr_place, id_cinema) values ('1', '50', '3'), ('2', '70', '3'), ('3', '100', '3');
insert into seance(hall, nbr_place, id_cinema) values ('1', '50', '4'), ('2', '70', '4'), ('3', '100', '4');

insert into genre(nom_genre) values ('action'), ('aventure'), ('fantastique'), ('horreur');

insert into film(name, time, id_genre) 
values 
('Matrix', '02:00:00', '1'), 
('Le seigneur des anneaux', '02:50:00', '3'), 
('Walking dead le film', '01:40:30', '4'), 
('Tomb raider', '01:30:00', '2');

insert into paiement(type_paiement) values ('Sur place'), ('En ligne');

insert into tarif(price, type_price) values (9.20, 'plein tarif'), (7.60, 'Etudiant'), (5.90, 'Moins de 14 ans');

insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Agg', 'Pete', '69', 'pagg0@kickstarter.com', '$2y$10$JoijpyBCUSCIx2rto/OE8OYCqTPKUS5faaIn4KpLj6YSqjRPUXOL2', '2', '1' );
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Diter', 'Malynda', '60', 'mditer1@illinois.edu', '$2y$10$jalmkG/1ouh8nk6qqlnFPOpZ8RqgDQW8Ax16rqh/SH1Pr8BNW0a1a', '2', '1');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Borzoni', 'Erica', '20', 'eborzoni2@seattletimes.com', '$2y$10$HtBkFytS16t.Oq7snMeVEuPu58j3q5Hg.e4pXrNqvFzOTJYTDB6s2', '1', '2');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Probate', 'Bartholomeus', '14', 'bprobate3@google.co.jp', '$2y$10$w1QdEUCIBOkhKYW.WMP2BuN3dNls/YIcy64kPTOPWSZI9xL8V2s3.', '1', '3');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Waitland', 'Jo-ann', '26', 'jwaitland4@java.com', '$2y$10$Euoo7TITdIPALCAzet0XGOrbPUwYlsmQRywG7yAkvEXEkNFamCUc.', '1', '1');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Fairlamb', 'Drusilla', '31', 'dfairlamb5@odnoklassniki.ru', '$2y$10$CXTxGIuCid27W3IWvMWCquQUKmeGzj5Ge7jTlfhLKl1sjpCaQNUKm', '1', '1');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Matignon', 'Garvy', '13', 'gmatignon6@gizmodo.com', '$2y$10$tthFeedBxfx0mlunoriZL.FPeGG.lkgykWUH1bmP.fDOqAYhyNthK', '1', '3');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Kardos', 'Justis', '66', 'jkardos7@nbcnews.com',' $2y$10$EM8vLuJWOhZdTn3aM7QsWulTzQUkOtP74hIp5V0g6I3fCyq21FkdG', '1', '1');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Denley', 'Cozmo', '21', 'cdenley8@wiley.com',' $2y$10$Jo/Imjn3WyWxo4Efvj1hAe2eqbr9tN9ESiP/MqVVsOXRrVe9E057O', '2', '2');
insert into customer (id, last_name, first_name, age, email, passeword, id_paiement, id_tarif) values (UUID(), 'Curthoys', 'Kori', '11', 'kcurthoys9@devhub.com', '$2y$10$IbSjaEw1jxB/nP29htbZgOPYGiMNE/v7Vl.eIyRc44VOWRxxP1THm', '2', '3');

INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 10:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '1', '2', '1', '1');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 10:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '1', '2', '1', '1');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 10:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '1', '2', '1', '1');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 10:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '1', '2', '1', '1');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 11:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '2', '3', '2', '2');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 11:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '2', '3', '2', '2');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 11:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '2', '3', '2', '2');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 12:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '4', '1', '3', '3');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 12:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '4', '1', '3', '3');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 14:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '3', '4', '4', '4');
INSERT INTO reservation (id, start_movie, id_customer, id_film, id_seance, id_cinema) VALUES (UUDI(), '2021-09-03 14:30:00' , '562008b0-0e2f-11ec-82a8-0242ac130003' , '3', '4', '4', '4');



-- Requêtes sql permettant de démontrr la fiabilité de la BDD par rapport aux exigences clients --


-- Reservation d'un film dans plusieurs cinéma

SELECT reservation.id  AS 'Numéro de reservation' , film.id AS 'Nom du film' , cinema.name AS 'Nom du cinema'
FROM reservation
JOIN film ON film.id = reservation.id_film
JOIN cinema ON  cinema.id = reservation.id_cinema
JOIN cinema ON cinema.id_seance = cinema.id
ORDER BY cinema.name;

-- Voir les tarifs

SELECT * FROM tarif ;

-- Tableau récapitulatifs pour savoir si les clients ont payé sur place ou en ligne

SELECT reservation.id AS 'Numero de reservation' , CONCAT(customers.last_name, ' ' , customer.first_name) AS 'Nom et prenom du client', paiement.type_paiement AS ' Choix du paiement'
FROM reservation 
JOIN customers ON reservation.id_customer = customers.id
JOIN paiement ON reservation.id_paiement = paiement.id;

-- Tableau permettant de connaitre l'administrateur du cinéma 

SELECT cinema.name 'Nom du cinéma', CONCAT (administrateur.first_name, ' ', administrateur.last_name) AS 'Nom, prenom'
FROM cinema;
JOIN id ON cinema.id = cinema.id
JOIN administrateur ON infos.id_administrateur = administrateur.id;



-- Utilisation d'un utilitaire de sauvegarde et restauration de la base de données
mysqldump -u root -h localhost:8889 -p root > sqleval.sql