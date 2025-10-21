SHOW DATABASES;

DROP DATABASE if EXISTS Netflix;
CREATE DATABASE Netflix;
USE Netflix;
create table Dim_titles(
id varchar(255) primary key,
title varchar(255),
type enum('SHOW','MOVIE'),
seasons int,
description varchar(8000),
release_year int,
age_certification varchar(255),
runtime int
);
create table Dim_Country(
id_country int primary key,
country varchar(255)
);
create table Fact_imdb(
imdb_id varchar(255) primary key,
imdb_votes int,
imdb_score float,
id_country int,
id varchar(255),
date date, 
FOREIGN KEY (id_country)
REFERENCES Dim_Country (id_country)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (id)
REFERENCES Dim_titles (id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
create table Dim_Genre(
id_genre int primary key,
genre varchar(255)
);
create table Dim_person(
person_id int primary key,
name varchar(255)
);
create table Dim_person_title(
id varchar(255),
person_id int,
character_name varchar(8000),
role varchar(255),
CONSTRAINT PRIMARY KEY
(id, person_id),
FOREIGN KEY (id)
REFERENCES Dim_titles (id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (person_id)
REFERENCES Dim_person (person_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

create table Dim_title_country(
id varchar(255),
id_country int,
CONSTRAINT PRIMARY KEY
(id, id_country),
FOREIGN KEY (id)
REFERENCES Dim_titles (id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (id_country)
REFERENCES Dim_Country (id_country)
ON DELETE CASCADE
ON UPDATE CASCADE
);
create table Dim_title_genre(
id varchar(255),
id_genre int,
CONSTRAINT PRIMARY KEY
(id, id_genre),
FOREIGN KEY (id)
REFERENCES Dim_titles (id)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (id_genre)
REFERENCES Dim_Genre (id_genre)
ON DELETE CASCADE
ON UPDATE CASCADE
);
CREATE INDEX idx_imdb_score ON Fact_imdb(imdb_score);
CREATE INDEX idx_release_year ON Dim_titles(release_year);
CREATE INDEX idx_runtime ON Dim_titles(runtime);
CREATE INDEX idx_country ON Dim_Country(country);
CREATE INDEX idx_age_certification ON Dim_titles(age_certification);
CREATE INDEX idx_type ON Dim_titles(type);
CREATE INDEX idx_seasons ON Dim_titles(seasons);

CREATE VIEW Avg_IMDb_Score_By_Country AS
SELECT c.country, AVG(f.imdb_score) AS avg_imdb_score
FROM Fact_imdb f
JOIN Dim_Country c ON f.id_country = c.id_country
GROUP BY c.country;
SELECT * FROM Avg_IMDb_Score_By_Country;

CREATE VIEW Total_Votes_By_Title AS
SELECT t.title, SUM(f.imdb_votes) AS total_votes
FROM Fact_imdb f
JOIN Dim_titles t ON f.id = t.id
GROUP BY t.title;
SELECT * FROM Total_Votes_By_Title;

CREATE VIEW Titles_With_Highest_IMDb_Score AS
SELECT t.title, f.imdb_score
FROM Fact_imdb f
JOIN Dim_titles t ON f.id = t.id
ORDER BY f.imdb_score DESC
LIMIT 10;
SELECT * FROM Titles_With_Highest_IMDb_Score;

CREATE VIEW IMDb_Scores_By_Release_Year AS
SELECT t.release_year, AVG(f.imdb_score) AS avg_imdb_score, MIN(f.imdb_score) AS min_imdb_score, MAX(f.imdb_score) AS max_imdb_score
FROM Fact_imdb f
JOIN Dim_titles t ON f.id = t.id
GROUP BY t.release_year;
SELECT * FROM IMDb_Scores_By_Release_Year;



CREATE VIEW IMDb_Scores_By_Age_Certification AS
SELECT t.age_certification, AVG(f.imdb_score) AS avg_imdb_score
FROM Fact_imdb f
JOIN Dim_titles t ON f.id = t.id
GROUP BY t.age_certification;
SELECT * FROM IMDb_Scores_By_Age_Certification;


select * from Fact_imdb;
select * from Dim_person;
select * from Dim_titles;
select * from Dim_Country;
select * from Dim_title_country;
select * from Dim_genre;
DESCRIBE netflix.dim_country;
