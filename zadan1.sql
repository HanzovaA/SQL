CREATE DATABASE IF NOT EXISTS knihovna;
USE knihovna;

CREATE TABLE autor ( 
autor_id INT AUTO_INCREMENT PRIMARY KEY,
jmeno VARCHAR(50) NOT NULL,
prijmeni VARCHAR(50) NOT NULL,
narozeni DATE
);

CREATE TABLE kniha (
    kniha_id INT AUTO_INCREMENT PRIMARY KEY, -- Unikátní ID každé knihy
    nazev VARCHAR(100) NOT NULL,             -- Název knihy
    rok_vydani YEAR,                         -- Rok vydání knihy
    zanr VARCHAR(50),                        -- Žánr knihy
    autor_id INT,                            -- Cizí klíč na autora
    FOREIGN KEY (autor_id) REFERENCES autor(autor_id)
);

CREATE TABLE clen (
    clen_id INT AUTO_INCREMENT PRIMARY KEY, -- Unikátní ID člena knihovny
    jmeno VARCHAR(50) NOT NULL,             -- Jméno člena
    prijmeni VARCHAR(50) NOT NULL,          -- Příjmení člena
    email VARCHAR(100) UNIQUE NOT NULL,     -- Email (unikátní)
    datum_registrace DATE DEFAULT (CURRENT_DATE) -- Datum registrace, výchozí dnešní datum
);

CREATE TABLE vypujcka (
    vypujcka_id INT AUTO_INCREMENT PRIMARY KEY,  -- Unikátní ID výpůjčky
    clen_id INT NOT NULL,                        -- Cizí klíč na člena
    kniha_id INT NOT NULL,                       -- Cizí klíč na knihu
    datum_vypujcky DATE DEFAULT (CURRENT_DATE),    -- Datum výpůjčky, výchozí dnešní datum
    datum_vraceni DATE,                          -- Datum vrácení (zadává se ručně)
    vraceno BOOLEAN DEFAULT FALSE,               -- Stav výpůjčky – jestli byla vrácena
    FOREIGN KEY (clen_id) REFERENCES clen(clen_id),
    FOREIGN KEY (kniha_id) REFERENCES kniha(kniha_id)
);

-- Ukázkové vložení dat do tabulky autor
INSERT INTO autor (jmeno, prijmeni, narozeni)
VALUES ('Karel', 'Čapek', '1890-01-09'),
       ('Božena', 'Němcová', '1820-02-04');

-- Ukázkové vložení knih
INSERT INTO kniha (nazev, rok_vydani, zanr, autor_id)
VALUES ('R.U.R.', 1920, 'Drama', 1),
       ('Babička', 1855, 'Román', 2);

-- Ukázkové vložení členů
INSERT INTO clen (jmeno, prijmeni, email)
VALUES ('Anna', 'Nováková', 'anna.novakova@email.cz'),
       ('Petr', 'Svoboda', 'petr.svoboda@email.cz');

-- Ukázková výpůjčka
INSERT INTO vypujcka (clen_id, kniha_id, datum_vypujcky, vraceno)
VALUES (1, 1, '2025-04-20', FALSE);