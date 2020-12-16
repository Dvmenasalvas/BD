CREATE TABLE Empleados(
    Nombre Char(50) NOT NULL, 
    DNI Char(9) NOT NULL, 
    Sueldo Number(6,2) CHECK (Sueldo >= 735.90 AND Sueldo <= 5000.00), 
    PRIMARY KEY (DNI)
);
CREATE TABLE "C�digos postales"(
    "C�digo postal" Char(5) NOT NULL, 
    Poblaci�n Char(50) NOT NULL, 
    Provincia Char(50) NOT NULL, 
    PRIMARY KEY ("C�digo postal")
);
CREATE TABLE Domicilios(
    DNI Char(9) NOT NULL REFERENCES Empleados ON DELETE CASCADE, 
    Calle Char(50) NOT NULL, 
    "C�digo postal" Char(5) NOT NULL REFERENCES "C�digos postales", 
    PRIMARY KEY(DNI, Calle, "C�digo postal")
);
CREATE TABLE Tel�fonos(
    DNI Char(9) NOT NULL REFERENCES Empleados ON DELETE CASCADE, 
    Tel�fono Char(9) NOT NULL,
    PRIMARY KEY (DNI, Tel�fono)
);