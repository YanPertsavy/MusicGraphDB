
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
(1, '���� ������', '+79161234567', '������, ��. ������, 10'),
(2, '����� ��������', '+79261234568', '�����-���������, ������� ��., 15'),
(3, '������� ������', '+79361234569', '������, ��. �������, 20'),
(4, '����� ���������', '+79461234570', '������������, ��. ��������, 30'),
(5, '������� �������', '+79561234571', '�����������, ������� ��., 40'),
(6, '���� ��������', '+79661234572', '����, ��. �����������, 5'),
(7, '������ ������', '+79761234573', '�����������, ��������� ��., 25'),
(8, '����� �������', '+79861234574', '�����������, ��. �����������, 10'),
(9, '������ �������', '+79961234575', '������-��-����, ��. ������� �������, 50'),
(10, '������� ������', '+79061234576', '���������, ��. �������, 100'),
(11, '����� ������', '+79171234577', '���, ��. ������, 70');

INSERT INTO VetClinics (clinic_id, name, address, phone, specialization) VALUES
(1, '���������', '������, ��. �����������, 5', '+74951234567', '����� � ������'),
(2, '�������', '�����-���������, ��. ������, 10', '+78121234568', '������������ ��������'),
(3, '�����', '������, ��. ��������, 15', '+78431234569', '������� � �����'),
(4, '������ ���', '������������, ��. ������, 20', '+73431234570', '��������'),
(5, '��������', '�����������, ��. �������������, 25', '+73831234571', '������������'),
(6, '���������', '����, ��. �������, 30', '+78621234572', '�������������'),
(7, '��� � ���', '�����������, ��. ��������, 35', '+74011234573', '������������'),
(8, '�������� �������', '�����������, ��. ��������, 40', '+74231234574', '�����������'),
(9, '����������', '������-��-����, ��. ������������, 45', '+78631234575', '���������'),
(10, '��������', '���������, ��. ���������, 50', '+78611234576', '���������'),
(11, '�������', '���, ��. �������������, 55', '+73471234577', '������������');

INSERT INTO Veterinarians (vet_id, full_name, phone, specialization) VALUES
(1, '����� ��������', '+79165554321', '��������'),
(2, '��������� �����', '+79265554322', '������'),
(3, '��������� ��������', '+79365554323', '���������'),
(4, '����� ������', '+79465554324', '���������'),
(5, '����� ��������', '+79565554325', '����������'),
(6, '����� ��������', '+79665554326', '�����������'),
(7, '�������� �������', '+79765554327', '����������'),
(8, '����� ��������', '+79865554328', '�������'),
(9, '������� ��������', '+79965554329', '�������'),
(10, '����� ��������', '+79065554330', '��������'),
(11, '���� ���������', '+79175554331', '������������');

INSERT INTO Pets (pet_id, name, species, breed, birth_date) VALUES
(1, '������', '�����', '����������', '2020-05-15'),
(2, '����', '������', '�������', '2019-03-10'),
(3, '�����', '�����', '��������', '2021-07-20'),
(4, '�����', '������', '��������', '2018-11-05'),
(5, '������', '�����', '������', '2020-02-28'),
(6, '����', '������', '��������', '2017-09-15'),
(7, '������', '�����', '����������', '2022-01-10'),
(8, '������', '������', '�������', '2019-06-25'),
(9, '�����', '������', '���������', '2021-03-18'),
(10, '����', '�������', '���', '2015-08-30'),
(11, '������', '�����', '�����������', '2022-05-12'),
(12, '����', '�����', '��������', '2021-10-15');


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
    (1, 2, '2023-05-20', '������ ������ � �����'),
    (3, 4, '2023-06-15', '������ �� ����'),
    (5, 6, '2023-07-10', '����������� �� ���������'),
    (7, 8, '2023-08-05', '����� � ���� ������� ����'),
    (9, 10, '2023-09-20', '����� � ����� �������'),
    (1, 3, '2023-10-15', '������� � �������'),
    (2, 4, '2023-11-10', '����������� ������'),
    (5, 7, '2023-12-05', '��������� � ���������'),
    (6, 8, '2024-01-20', '����������� � ��������'),
    (9, 11, '2024-02-15', '����� � ������ �������'))
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
WHERE p1.name = '������' AND MATCH(p1-(fw)->p2)
ORDER BY fw.friendship_since;


SELECT p.name AS pet_name, o.full_name AS owner_name, vc.name AS clinic_name
FROM Pets p, VisitsClinic vc_edge, VetClinics vc, OwnedBy ob, Owners o
WHERE vc.name = '���������' 
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