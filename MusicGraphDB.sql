-- Create and use MusicGraphDB database
USE master;
DROP DATABASE IF EXISTS MusicGraphDB;
CREATE DATABASE MusicGraphDB;
GO
USE MusicGraphDB;
GO

-- Node Table 1: Musician
CREATE TABLE Musician
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    surname NVARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL,
    birth_date DATE NOT NULL
) AS NODE;

-- Node Table 2: Genre
CREATE TABLE Genre
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    origin_year INT NOT NULL
) AS NODE;

-- Node Table 3: Album
CREATE TABLE Album
(
    id INT NOT NULL PRIMARY KEY,
    title NVARCHAR(50) NOT NULL,
    release_year INT NOT NULL
) AS NODE;

-- Node Table 4: City
CREATE TABLE City
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(50) NOT NULL
) AS NODE;

-- Edge Tables
CREATE TABLE PerformsInGenre AS EDGE;
CREATE TABLE LivesIn AS EDGE;
CREATE TABLE ReleasedAlbum AS EDGE;
CREATE TABLE PerformedInCity (performance_date DATE) AS EDGE;
CREATE TABLE CollaboratedWith AS EDGE;
CREATE TABLE InspiredByCity AS EDGE;

-- Add Constraints
ALTER TABLE PerformsInGenre
ADD CONSTRAINT EC_PerformsInGenre CONNECTION (Musician TO Genre);

ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (Musician TO City);

ALTER TABLE ReleasedAlbum
ADD CONSTRAINT EC_ReleasedAlbum CONNECTION (Musician TO Album);

ALTER TABLE PerformedInCity
ADD CONSTRAINT EC_PerformedInCity CONNECTION (Musician TO City);

ALTER TABLE CollaboratedWith
ADD CONSTRAINT EC_CollaboratedWith CONNECTION (Musician TO Musician);

ALTER TABLE InspiredByCity
ADD CONSTRAINT EC_InspiredByCity CONNECTION (Album TO City);

-- Insert Data into Musician (10 rows)
INSERT INTO Musician (id, name, surname, gender, birth_date) VALUES
(1, 'Алексей', 'Воробьёв', 'M', '1988-02-17'),
(2, 'Emma', 'Watson', 'F', '1990-04-15'),
(3, 'Лев', 'Толстой', 'M', '1995-09-09'),
(4, 'Sophie', 'Turner', 'F', '1996-02-21'),
(5, 'Giovanni', 'Rossi', 'M', '1985-07-30'),
(6, 'Hye-jin', 'Kim', 'F', '1992-11-12'),
(7, 'Pierre', 'Dubois', 'M', '1980-03-25'),
(8, 'Liam', 'Smith', 'M', '1987-06-10'),
(9, 'Екатерина', 'Смирнова', 'F', '1993-12-05'),
(10, 'Akira', 'Yamamoto', 'M', '1989-08-18');

-- Insert Data into Genre (10 rows)
INSERT INTO Genre (id, name, origin_year) VALUES
(1, 'Rock', 1950),
(2, 'Jazz', 1920),
(3, 'Pop', 1960),
(4, 'Classical', 1600),
(5, 'Hip-Hop', 1970),
(6, 'Electronic', 1980),
(7, 'Blues', 1910),
(8, 'Folk', 1900),
(9, 'Reggae', 1960),
(10, 'Metal', 1970);

-- Insert Data into Album (10 rows)
INSERT INTO Album (id, title, release_year) VALUES
(1, 'Echoes of Time', 2015),
(2, 'Midnight Groove', 2018),
(3, 'Starlight Symphony', 2020),
(4, 'Urban Pulse', 2017),
(5, 'Neon Dreams', 2019),
(6, 'Soulful Chords', 2016),
(7, 'Rasta Road', 2021),
(8, 'Electric Horizon', 2022),
(9, 'Classic Reverie', 2014),
(10, 'Rebel Beats', 2023);

-- Insert Data into City (10 rows)
INSERT INTO City (id, name) VALUES
(1, 'London'),
(2, 'New York'),
(3, 'Paris'),
(4, 'Tokyo'),
(5, 'Moscow'),
(6, 'Berlin'),
(7, 'Rome'),
(8, 'Seoul'),
(9, 'Los Angeles'),
(10, 'Rio de Janeiro');

-- Insert Data into PerformsInGenre Edge
INSERT INTO PerformsInGenre ($from_id, $to_id) VALUES
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM Genre WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM Genre WHERE id = 3)),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM Genre WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM Genre WHERE id = 3)),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM Genre WHERE id = 4)),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM Genre WHERE id = 6)),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM Genre WHERE id = 2)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM Genre WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM Genre WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 10), (SELECT $node_id FROM Genre WHERE id = 9));

-- Insert Data into LivesIn Edge
INSERT INTO LivesIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM City WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM City WHERE id = 9)),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM City WHERE id = 7)),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM City WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM City WHERE id = 3)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM City WHERE id = 2)),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 10), (SELECT $node_id FROM City WHERE id = 4));

-- Insert Data into ReleasedAlbum Edge
INSERT INTO ReleasedAlbum ($from_id, $to_id) VALUES
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM Album WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM Album WHERE id = 3)),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM Album WHERE id = 4)),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM Album WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM Album WHERE id = 9)),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM Album WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM Album WHERE id = 2)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM Album WHERE id = 10)),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM Album WHERE id = 6)),
((SELECT $node_id FROM Musician WHERE id = 10), (SELECT $node_id FROM Album WHERE id = 7));

-- Insert Data into PerformedInCity Edge
INSERT INTO PerformedInCity ($from_id, $to_id, performance_date) VALUES
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM City WHERE id = 1), '2024-03-15'),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM City WHERE id = 9), '2024-05-20'),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM City WHERE id = 6), '2024-07-10'),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM City WHERE id = 2), '2024-06-05'),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM City WHERE id = 7), '2024-08-12'),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM City WHERE id = 8), '2024-09-01'),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM City WHERE id = 3), '2024-04-18'),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM City WHERE id = 9), '2024-10-25'),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM City WHERE id = 5), '2024-11-15'),
((SELECT $node_id FROM Musician WHERE id = 10), (SELECT $node_id FROM City WHERE id = 4), '2024-12-10'),
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM City WHERE id = 6), '2024-02-20'),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM City WHERE id = 3), '2024-01-30'),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM City WHERE id = 2), '2024-03-25'),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM City WHERE id = 1), '2024-04-10'),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM City WHERE id = 3), '2024-05-15'),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM City WHERE id = 4), '2024-06-20'),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM City WHERE id = 6), '2024-07-05'),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM City WHERE id = 1), '2024-08-10'),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM City WHERE id = 7), '2024-09-15');

-- Insert Data into InspiredByCity Edge (Analogous to IncludedInTour)
INSERT INTO InspiredByCity ($from_id, $to_id) VALUES
((SELECT $node_id FROM Album WHERE id = 1), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Album WHERE id = 2), (SELECT $node_id FROM City WHERE id = 3)),
((SELECT $node_id FROM Album WHERE id = 3), (SELECT $node_id FROM City WHERE id = 1)),
((SELECT $node_id FROM Album WHERE id = 4), (SELECT $node_id FROM City WHERE id = 6)),
((SELECT $node_id FROM Album WHERE id = 5), (SELECT $node_id FROM City WHERE id = 9)),
((SELECT $node_id FROM Album WHERE id = 6), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Album WHERE id = 7), (SELECT $node_id FROM City WHERE id = 10)),
((SELECT $node_id FROM Album WHERE id = 8), (SELECT $node_id FROM City WHERE id = 8)),
((SELECT $node_id FROM Album WHERE id = 9), (SELECT $node_id FROM City WHERE id = 7)),
((SELECT $node_id FROM Album WHERE id = 10), (SELECT $node_id FROM City WHERE id = 2)),
((SELECT $node_id FROM Album WHERE id = 3), (SELECT $node_id FROM City WHERE id = 2)),
((SELECT $node_id FROM Album WHERE id = 4), (SELECT $node_id FROM City WHERE id = 5)),
((SELECT $node_id FROM Album WHERE id = 7), (SELECT $node_id FROM City WHERE id = 4)),
((SELECT $node_id FROM Album WHERE id = 10), (SELECT $node_id FROM City WHERE id = 9));

-- Insert Data into CollaboratedWith Edge (bidirectional)
INSERT INTO CollaboratedWith ($from_id, $to_id) VALUES
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM Musician WHERE id = 3)),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM Musician WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 1), (SELECT $node_id FROM Musician WHERE id = 9)),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM Musician WHERE id = 1)),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM Musician WHERE id = 4)),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM Musician WHERE id = 2)),
((SELECT $node_id FROM Musician WHERE id = 2), (SELECT $node_id FROM Musician WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM Musician WHERE id = 2)),
((SELECT $node_id FROM Musician WHERE id = 4), (SELECT $node_id FROM Musician WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM Musician WHERE id = 4)),
((SELECT $node_id FROM Musician WHERE id = 5), (SELECT $node_id FROM Musician WHERE id = 7)),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM Musician WHERE id = 5)),
((SELECT $node_id FROM Musician WHERE id = 6), (SELECT $node_id FROM Musician WHERE id = 10)),
((SELECT $node_id FROM Musician WHERE id = 10), (SELECT $node_id FROM Musician WHERE id = 6)),
((SELECT $node_id FROM Musician WHERE id = 7), (SELECT $node_id FROM Musician WHERE id = 8)),
((SELECT $node_id FROM Musician WHERE id = 8), (SELECT $node_id FROM Musician WHERE id = 7)),
((SELECT $node_id FROM Musician WHERE id = 3), (SELECT $node_id FROM Musician WHERE id = 9)),
((SELECT $node_id FROM Musician WHERE id = 9), (SELECT $node_id FROM Musician WHERE id = 3));

-- MATCH Query 1: Find musicians who perform in the Rock genre
SELECT DISTINCT m.name AS [Имя], m.surname AS [Фамилия]
FROM Musician AS m, PerformsInGenre, Genre AS g
WHERE MATCH(m-(PerformsInGenre)->g)
AND g.name = N'Rock';

-- MATCH Query 2: Find cities that inspired albums by Pop musicians
SELECT DISTINCT c.name AS [Город]
FROM Musician AS m, Genre AS g, Album AS a, City AS c, PerformsInGenre, ReleasedAlbum, InspiredByCity
WHERE MATCH(m-(PerformsInGenre)->g AND m-(ReleasedAlbum)->a AND a-(InspiredByCity)->c)
AND g.name = N'Pop';

-- MATCH Query 3: Find albums released by musicians living in Moscow
SELECT m.name AS [Имя], m.surname AS [Фамилия], a.title AS [Альбом]
FROM Musician AS m, City AS c, Album AS a, LivesIn, ReleasedAlbum
WHERE MATCH(m-(LivesIn)->c)
AND c.name = N'Moscow';

-- MATCH Query 4: Find musicians who collaborated and performed in the same city
SELECT m1.name + ' ' + m1.surname AS [Музыкант 1], 
       m2.name + ' ' + m2.surname AS [Музыкант 2], 
       c.name AS [Город]
FROM Musician AS m1, Musician AS m2, City AS c, 
     CollaboratedWith, PerformedInCity AS pc1, PerformedInCity AS pc2
WHERE MATCH(m1-(CollaboratedWith)->m2 AND 
           m1-(pc1)->c AND 
           m2-(pc2)->c)
AND m1.id < m2.id;

-- MATCH Query 5: Find genres of albums released after 2018
SELECT DISTINCT g.name AS [Жанр]
FROM Musician AS m, Genre AS g, Album AS a, PerformsInGenre, ReleasedAlbum
WHERE MATCH(m-(PerformsInGenre)->g)
AND a.release_year > 2018;

-- SHORTEST_PATH Query 6: Find shortest collaboration path from Алексей to Pierre
SELECT 
    StartMusician = m1.name,
    Path = STRING_AGG(m2.name, ' -> ') WITHIN GROUP (GRAPH PATH),
    Steps = COUNT(m2.name) WITHIN GROUP (GRAPH PATH),
    EndMusician = LAST_VALUE(m2.name) WITHIN GROUP (GRAPH PATH)
FROM
    Musician AS m1,
    Musician FOR PATH AS m2,
    CollaboratedWith FOR PATH AS cw
WHERE MATCH(SHORTEST_PATH(m1(-(cw)->m2)+))
AND m1.name = N'Алексей'
ORDER BY Steps, EndMusician;

-- SHORTEST_PATH Query 7: Find collaborators and collaborators of collaborators of Emma (1 to 2 hops)
SELECT [Имя музыканта], [Сотрудники]
FROM (
    SELECT
        m1.name AS [Имя музыканта],
        STRING_AGG(m2.name, '->') WITHIN GROUP (GRAPH PATH) AS [Сотрудники],
        COUNT(m2.name) WITHIN GROUP (GRAPH PATH) AS levels
    FROM
        Musician AS m1,
        CollaboratedWith FOR PATH AS cw,
        Musician FOR PATH AS m2
    WHERE MATCH(SHORTEST_PATH(m1(-(cw)->m2){1,2}))
    AND m1.name = N'Emma'
) Q;