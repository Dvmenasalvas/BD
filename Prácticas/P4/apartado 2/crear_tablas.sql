CREATE TABLE Empleados(
    Nombre Char(50) NOT NULL, 
    DNI Char(9) NOT NULL, 
    Sueldo Number(6,2) CHECK (Sueldo >= 735.90 AND Sueldo <= 5000.00), 
    PRIMARY KEY (DNI)
);
CREATE TABLE "Códigos postales"(
    "Código postal" Char(5) NOT NULL, 
    Población Char(50) NOT NULL, 
    Provincia Char(50) NOT NULL, 
    PRIMARY KEY ("Código postal")
);
CREATE TABLE Domicilios(
    DNI Char(9) NOT NULL REFERENCES Empleados ON DELETE CASCADE, 
    Calle Char(50) NOT NULL, 
    "Código postal" Char(5) NOT NULL REFERENCES "Códigos postales", 
    PRIMARY KEY(DNI, Calle, "Código postal")
);
CREATE TABLE Teléfonos(
    DNI Char(9) NOT NULL REFERENCES Empleados ON DELETE CASCADE, 
    Teléfono Char(9) NOT NULL,
    PRIMARY KEY (DNI, Teléfono)
);