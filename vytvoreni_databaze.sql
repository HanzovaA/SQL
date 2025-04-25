
CREATE DATABASE skola;
USE skola;
CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jmeno VARCHAR(50),
    prijmeni VARCHAR(50),
    rocnik INT
);
INSERT INTO student (jmeno, prijmeni, rocnik) VALUES
('Jana', 'Nováková', 3),
('Petr', 'Dvořák', 2);
