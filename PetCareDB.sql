
CREATE DATABASE PetCareDB;
GO

USE PetCareDB;
GO


CREATE TABLE Owners (
    owner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(200)
) AS NODE;

CREATE TABLE VetClinics (
    clinic_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    specialization VARCHAR(100)
) AS NODE;

CREATE TABLE Veterinarians (
    vet_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    specialization VARCHAR(100)
) AS NODE;

CREATE TABLE Pets (
    pet_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(50),
    birth_date DATE
) AS NODE;


CREATE TABLE OwnedBy AS EDGE;
CREATE TABLE WorksAt AS EDGE;
CREATE TABLE VisitsClinic AS EDGE;
CREATE TABLE TreatedBy AS EDGE;
CREATE TABLE FriendsWith AS EDGE;

INSERT INTO Owners (owner_id, full_name, phone, address) VALUES
(1, 'Иван Петров', '+79161234567', 'Москва, ул. Ленина, 10'),
(2, 'Елена Смирнова', '+79261234568', 'Санкт-Петербург, Невский пр., 15'),
(3, 'Алексей Козлов', '+79361234569', 'Казань, ул. Баумана, 20'),
(4, 'Ольга Васнецова', '+79461234570', 'Екатеринбург, ул. Малышева, 30'),
(5, 'Дмитрий Соколов', '+79561234571', 'Новосибирск, Красный пр., 40'),
(6, 'Анна Лебедева', '+79661234572', 'Сочи, ул. Навагинская, 5'),
(7, 'Сергей Волков', '+79761234573', 'Калининград, Ленинский пр., 25'),
(8, 'Мария Павлова', '+79861234574', 'Владивосток, ул. Светланская, 10'),
(9, 'Андрей Морозов', '+79961234575', 'Ростов-на-Дону, ул. Большая Садовая, 50'),
(10, 'Наталья Орлова', '+79061234576', 'Краснодар, ул. Красная, 100'),
(11, 'Артем Зайцев', '+79171234577', 'Уфа, ул. Ленина, 70');

INSERT INTO VetClinics (clinic_id, name, address, phone, specialization) VALUES
(1, 'ЗооДоктор', 'Москва, ул. Ветеринаров, 5', '+74951234567', 'Кошки и собаки'),
(2, 'Айболит', 'Санкт-Петербург, ул. Врачей, 10', '+78121234568', 'Экзотические животные'),
(3, 'Лапки', 'Казань, ул. Пушистая, 15', '+78431234569', 'Грызуны и птицы'),
(4, 'Доктор Вет', 'Екатеринбург, ул. Лесная, 20', '+73431234570', 'Хирургия'),
(5, 'ЗооЦентр', 'Новосибирск, ул. Зоологическая, 25', '+73831234571', 'Дерматология'),
(6, 'ВетПомощь', 'Сочи, ул. Морская, 30', '+78621234572', 'Офтальмология'),
(7, 'Кот и Пес', 'Калининград, ул. Рыбацкая, 35', '+74011234573', 'Стоматология'),
(8, 'Здоровый Питомец', 'Владивосток, ул. Тигровая, 40', '+74231234574', 'Кардиология'),
(9, 'ВетЭксперт', 'Ростов-на-Дону, ул. Ветеринарная, 45', '+78631234575', 'Онкология'),
(10, 'Анималия', 'Краснодар, ул. Кубанская, 50', '+78611234576', 'Ортопедия'),
(11, 'ЗооФарм', 'Уфа, ул. Лекарственная, 55', '+73471234577', 'Фармакология');

INSERT INTO Veterinarians (vet_id, full_name, phone, specialization) VALUES
(1, 'Мария Сидорова', '+79165554321', 'Терапевт'),
(2, 'Александр Белов', '+79265554322', 'Хирург'),
(3, 'Екатерина Голубева', '+79365554323', 'Орнитолог'),
(4, 'Денис Крылов', '+79465554324', 'Кардиолог'),
(5, 'Ольга Соколова', '+79565554325', 'Дерматолог'),
(6, 'Игорь Медведев', '+79665554326', 'Офтальмолог'),
(7, 'Светлана Зайцева', '+79765554327', 'Стоматолог'),
(8, 'Артем Воробьев', '+79865554328', 'Онколог'),
(9, 'Надежда Лебедева', '+79965554329', 'Ортопед'),
(10, 'Вадим Соловьев', '+79065554330', 'Невролог'),
(11, 'Юлия Воронцова', '+79175554331', 'Эндокринолог');

INSERT INTO Pets (pet_id, name, species, breed, birth_date) VALUES
(1, 'Барсик', 'Кошка', 'Британская', '2020-05-15'),
(2, 'Рекс', 'Собака', 'Овчарка', '2019-03-10'),
(3, 'Мурка', 'Кошка', 'Дворовая', '2021-07-20'),
(4, 'Шарик', 'Собака', 'Лабрадор', '2018-11-05'),
(5, 'Черныш', 'Кошка', 'Бомбей', '2020-02-28'),
(6, 'Лорд', 'Собака', 'Доберман', '2017-09-15'),
(7, 'Снежок', 'Кошка', 'Персидская', '2022-01-10'),
(8, 'Тайсон', 'Собака', 'Питбуль', '2019-06-25'),
(9, 'Зефир', 'Кролик', 'Вислоухий', '2021-03-18'),
(10, 'Кеша', 'Попугай', 'Ара', '2015-08-30'),
(11, 'Гектор', 'Хомяк', 'Джунгарский', '2022-05-12'),
(12, 'Немо', 'Рыбка', 'Скалярия', '2021-10-15');


INSERT INTO OwnedBy ($from_id, $to_id)
SELECT p.$node_id, o.$node_id
FROM Pets p
JOIN (VALUES
    (1, 1), (2, 1), (3, 2), (4, 3), (5, 4), 
    (6, 5), (7, 6), (8, 7), (9, 8), (10, 9), 
    (11, 10), (12, 11)
AS pet_owner(pet_id, owner_id) ON p.pet_id = pet_owner.pet_id
JOIN Owners o ON o.owner_id = pet_owner.owner_id;


INSERT INTO WorksAt ($from_id, $to_id)
SELECT v.$node_id, vc.$node_id
FROM Veterinarians v
JOIN (VALUES
    (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), 
    (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), 
    (11, 11))
AS vet_clinic(vet_id, clinic_id) ON v.vet_id = vet_clinic.vet_id
JOIN VetClinics vc ON vc.clinic_id = vet_clinic.clinic_id;


INSERT INTO VisitsClinic ($from_id, $to_id, registration_date, last_visit)
SELECT p.$node_id, vc.$node_id, v.registration_date, v.last_visit
FROM Pets p
JOIN (VALUES
    (1, 1, '2023-01-10', '2024-02-15'),
    (2, 1, '2023-01-15', '2024-02-20'),
    (3, 2, '2023-02-10', '2024-01-25'),
    (4, 3, '2023-03-05', '2024-02-10'),
    (5, 4, '2023-04-20', '2024-01-15'),
    (6, 5, '2023-05-15', '2024-02-05'),
    (7, 6, '2023-06-10', '2024-01-30'),
    (8, 7, '2023-07-05', '2024-02-25'),
    (9, 8, '2023-08-20', '2024-01-10'),
    (10, 9, '2023-09-15', '2024-02-20'),
    (11, 10, '2023-10-10', '2024-01-05'),
    (12, 11, '2023-11-05', '2024-02-15'))
AS v(pet_id, clinic_id, registration_date, last_visit) ON p.pet_id = v.pet_id
JOIN VetClinics vc ON vc.clinic_id = v.clinic_id;

INSERT INTO TreatedBy ($from_id, $to_id, since_date)
SELECT p.$node_id, v.$node_id, t.since_date
FROM Pets p
JOIN (VALUES
    (1, 1, '2023-01-10'),
    (2, 1, '2023-01-15'),
    (3, 2, '2023-02-10'),
    (4, 3, '2023-03-05'),
    (5, 4, '2023-04-20'),
    (6, 5, '2023-05-15'),
    (7, 6, '2023-06-10'),
    (8, 7, '2023-07-05'),
    (9, 8, '2023-08-20'),
    (10, 9, '2023-09-15'),
    (11, 10, '2023-10-10'),
    (12, 11, '2023-11-05'))
AS t(pet_id, vet_id, since_date) ON p.pet_id = t.pet_id
JOIN Veterinarians v ON v.vet_id = t.vet_id;

INSERT INTO FriendsWith ($from_id, $to_id, friendship_since, notes)
SELECT p1.$node_id, p2.$node_id, f.friendship_since, f.notes
FROM Pets p1
JOIN Pets p2 ON p1.pet_id < p2.pet_id
JOIN (VALUES
    (1, 2, '2023-05-20', 'Играют вместе в парке'),
    (3, 4, '2023-06-15', 'Соседи по дому'),
    (5, 6, '2023-07-10', 'Встречаются на выставках'),
    (7, 8, '2023-08-05', 'Ходят в один собачий парк'),
    (9, 10, '2023-09-20', 'Живут в одном вольере'),
    (1, 3, '2023-10-15', 'Знакомы с детства'),
    (2, 4, '2023-11-10', 'Тренируются вместе'),
    (5, 7, '2023-12-05', 'Участвуют в конкурсах'),
    (6, 8, '2024-01-20', 'Соревнуются в аджилити'),
    (9, 11, '2024-02-15', 'Живут у одного хозяина'))
AS f(pet1_id, pet2_id, friendship_since, notes) ON p1.pet_id = f.pet1_id AND p2.pet_id = f.pet2_id;


SELECT p.name AS pet_name, o.full_name AS owner_name
FROM Pets p, OwnedBy ob, Owners o
WHERE MATCH(p-(ob)->o)
ORDER BY o.full_name, p.name;


SELECT p.name AS pet_name, vc.name AS clinic_name, vet.full_name AS vet_name
FROM Pets p, VisitsClinic vc_edge, VetClinics vc, 
     TreatedBy tb, Veterinarians vet
WHERE MATCH(p-(vc_edge)->vc AND p-(tb)->vet)
ORDER BY p.name;


SELECT p2.name AS friend_name, fw.friendship_since
FROM Pets p1, FriendsWith fw, Pets p2
WHERE p1.name = 'Барсик' AND MATCH(p1-(fw)->p2)
ORDER BY fw.friendship_since;


SELECT p.name AS pet_name, o.full_name AS owner_name, vc.name AS clinic_name
FROM Pets p, VisitsClinic vc_edge, VetClinics vc, OwnedBy ob, Owners o
WHERE vc.name = 'ЗооДоктор' 
AND MATCH(p-(vc_edge)->vc AND p-(ob)->o)
ORDER BY o.full_name;


SELECT vet.full_name AS vet_name, vet.
specialization AS vet_specialization, 
       vc.name AS clinic_name, vc.specialization AS clinic_specialization
FROM Veterinarians vet, WorksAt wa, VetClinics vc
WHERE MATCH(vet-(wa)->vc)
ORDER BY vc.name, vet.full_name;


SELECT o.full_name AS owner_name, p.name AS pet_name
FROM Owners o, OwnedBy ob, Pets p
WHERE MATCH(o<-(ob)-p);


SELECT p1.name AS pet1, p2.name AS pet2
FROM Pets p1, FriendsWith fw, Pets p2
WHERE p1.pet_id < p2.pet_id AND MATCH(p1-(fw)->p2);


SELECT vet.full_name AS vet_name, o.full_name AS owner_name
FROM Veterinarians vet, TreatedBy tb, Pets p, OwnedBy ob, Owners o
WHERE MATCH(vet<-(tb)-p-(ob)->o);