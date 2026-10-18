CREATE DATABASE musica CHARACTER SET utf8mb4;
USE musica;

CREATE TABLE grupo (
    nombre    VARCHAR(100) NOT NULL,
    fecha_cre DATE         NOT NULL,
    PRIMARY KEY (nombre)
    );
    
    CREATE TABLE cancion (
    id_cancion   INT          NOT NULL AUTO_INCREMENT,
    titulo       VARCHAR(150) NOT NULL,
    artista      VARCHAR(100) NOT NULL,
    fecha_public DATE         NOT NULL,
    PRIMARY KEY (id_cancion)
    );
    
    CREATE TABLE usuario (
    id_usuario  INT NOT NULL AUTO_INCREMENT,
    correo      VARCHAR(120) NOT NULL,
    fecha_alta  DATETIME NOT NULL,
    uri         VARCHAR(255),
    PRIMARY KEY (id_usuario),
    UNIQUE KEY uq_usuario_correo (correo)
    );
    
    CREATE TABLE componente (
    nombre_grupo VARCHAR(100) NOT NULL,
    componente   VARCHAR(100) NOT NULL,
    PRIMARY KEY (nombre_grupo, componente),
    FOREIGN KEY (nombre_grupo) REFERENCES grupo (nombre)
);

CREATE TABLE album (
    id_album      INT          NOT NULL AUTO_INCREMENT,
    titulo        VARCHAR(150) NOT NULL,
    fecha_pub     DATETIME     NOT NULL,
    num_canciones INT          NOT NULL DEFAULT 0,
    nombre_grupo  VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_album),
    FOREIGN KEY (nombre_grupo) REFERENCES grupo (nombre)
);


CREATE TABLE registrado (
    id_usuario INT           NOT NULL,
    cuota      DECIMAL(10,2) NOT NULL,
    fecha_fin  DATE,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE contiene (
    id_album   INT NOT NULL,
    id_cancion INT NOT NULL,
    PRIMARY KEY (id_album, id_cancion),
    FOREIGN KEY (id_album) REFERENCES album (id_album),
    FOREIGN KEY (id_cancion) REFERENCES cancion (id_cancion)
);

CREATE TABLE stream (
    id_cancion INT      NOT NULL,
    id_usuario INT      NOT NULL,
    fecha      DATETIME NOT NULL,
    PRIMARY KEY (id_cancion, id_usuario, fecha),
    FOREIGN KEY (id_cancion) REFERENCES cancion (id_cancion),
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
    );
    
    CREATE TABLE descarga (
    id_cancion INT  NOT NULL,
    id_usuario INT  NOT NULL,
    fecha      DATE NOT NULL,
    n_veces    INT  NOT NULL DEFAULT 1,
    PRIMARY KEY (id_cancion, id_usuario),
    FOREIGN KEY (id_cancion) REFERENCES cancion (id_cancion),
    FOREIGN KEY (id_usuario) REFERENCES registrado (id_usuario)
);


INSERT INTO grupo (nombre, fecha_cre) VALUES
('Los Cóndores del Sur','1988-03-12'),
('Sol de Medianoche','1994-07-21'),
('Río Violeta','1999-11-05'),
('Tambores del Alba','2003-02-18'),
('Neón Tropical','2008-09-30'),
('La Brisa Eléctrica','2012-05-14'),
('Orquesta Luna Nueva','2015-10-02'),
('Ecos del Páramo','2019-01-25');

INSERT INTO componente (nombre_grupo, componente) VALUES
('Los Cóndores del Sur','Felipe Castro'),
('Los Cóndores del Sur','Valentina Cano'),
('Los Cóndores del Sur','Tomás Londoño'),
('Sol de Medianoche','Valentina Rojas'),
('Sol de Medianoche','Juliana Moreno'),
('Sol de Medianoche','Laura Ramírez'),
('Sol de Medianoche','Laura Duarte'),
('Río Violeta','Isabela Londoño'),
('Río Violeta','Isabela Gómez'),
('Río Violeta','Julián Pardo'),
('Tambores del Alba','Natalia Silva'),
('Tambores del Alba','Sebastián Moreno'),
('Tambores del Alba','Manuela Gómez'),
('Tambores del Alba','Daniel Ramírez'),
('Neón Tropical','Diego Ortiz'),
('Neón Tropical','Nicolás Ramírez'),
('Neón Tropical','Andrés Silva'),
('Neón Tropical','Natalia Duarte'),
('La Brisa Eléctrica','Daniel Pardo'),
('La Brisa Eléctrica','Laura Cano'),
('La Brisa Eléctrica','Esteban Londoño'),
('La Brisa Eléctrica','Sebastián Rincón'),
('Orquesta Luna Nueva','Esteban Rojas'),
('Orquesta Luna Nueva','Tomás Torres'),
('Orquesta Luna Nueva','Mateo Vargas'),
('Orquesta Luna Nueva','Samuel Castro'),
('Ecos del Páramo','Carolina Ortiz'),
('Ecos del Páramo','Carolina Torres'),
('Ecos del Páramo','Samuel Rincón'),
('Ecos del Páramo','Mariana Pardo');
INSERT INTO contiene (id_album, id_cancion) VALUES
(1,1), (1,2), (1,3),
(2,4), (2,5), (2,6),
(3,7), (3,8), (3,9),
(4,10), (4,11), (4,12),
(5,13), (5,14), (5,15),
(6,16), (6,17), (6,18),
(7,19), (7,20), (7,21),
(8,22), (8,23), (8,24);
 
INSERT INTO usuario (id_usuario, correo, fecha_alta, uri) VALUES
(1,'ana.rojas21@correo.com','2023-02-10 09:15:00','https://musica.com/u/ana.rojas21'), (2,'luis.vargas8@correo.com','2023-03-22 18:40:00','https://musica.com/u/luis.vargas8'), (3,'maria.moreno45@correo.com','2023-05-04 11:05:00','https://musica.com/u/maria.moreno45'),
(4,'juan.castro12@correo.com','2023-06-17 20:30:00',NULL), (5,'sofia.ortiz33@correo.com','2023-08-01 08:00:00','https://musica.com/u/sofia.ortiz33'), (6,'diego.herrera7@correo.com','2023-09-12 15:45:00','https://musica.com/u/diego.herrera7'),
(7,'laura.mejia60@correo.com','2023-11-25 13:20:00',NULL), (8,'mateo.torres18@correo.com','2024-01-08 10:10:00','https://musica.com/u/mateo.torres18'), (9,'camila.pardo5@correo.com','2024-02-19 19:50:00','https://musica.com/u/camila.pardo5'),
(10,'andres.gomez90@correo.com','2024-04-03 07:35:00',NULL);
 
INSERT INTO registrado (id_usuario, cuota, fecha_fin) VALUES
(1,15000.00,'2025-02-10'), (2,15000.00,'2025-03-22'), (3,25000.00,'2025-05-04'),
(4,15000.00,NULL), (5,35000.00,'2025-08-01');
 
INSERT INTO stream (id_cancion, id_usuario, fecha) VALUES
(9,5,'2024-05-01 12:26:00'), (2,4,'2024-05-02 23:53:00'), (22,6,'2024-05-03 22:22:00'),
(2,4,'2024-05-06 12:18:00'), (1,8,'2024-05-08 14:49:00'), (6,6,'2024-05-20 23:26:00'),
(12,7,'2024-05-30 12:05:00'), (11,8,'2024-06-06 10:07:00'), (15,6,'2024-06-08 15:50:00'),
(20,10,'2024-06-10 12:44:00'), (6,4,'2024-06-20 20:58:00'), (6,9,'2024-06-24 18:29:00'),
(3,3,'2024-06-27 20:35:00'), (8,2,'2024-07-10 21:03:00'), (6,2,'2024-07-12 09:39:00'),
(2,2,'2024-07-13 17:33:00'), (18,2,'2024-07-13 17:35:00'), (6,2,'2024-07-14 14:23:00'),
(20,8,'2024-07-14 22:04:00'), (4,4,'2024-07-20 09:36:00'), (10,10,'2024-07-27 22:18:00'),
(9,8,'2024-07-29 10:03:00'), (6,2,'2024-08-06 18:21:00'), (2,7,'2024-08-19 16:45:00');
 
INSERT INTO descarga (id_cancion, id_usuario, fecha, n_veces) VALUES
(3,2,'2024-07-27',1), (4,1,'2024-08-12',1), (4,3,'2024-08-16',1),
(13,4,'2024-06-14',3), (15,5,'2024-07-21',3), (17,5,'2024-08-23',1),
(18,1,'2024-07-17',1), (21,4,'2024-06-08',1);

Use musica;

SELECT nombre FROM grupo;
SELECT titulo, artista FROM cancion;
SELECT correo FROM usuario;
SELECT DISTINCT artista FROM cancion;


SELECT * FROM grupo ORDER BY fecha_cre ASC;
SELECT * FROM grupo ORDER BY fecha_cre DESC;
SELECT * FROM cancion ORDER BY titulo ASC;
SELECT * FROM usuario ORDER BY fecha_alta DESC LIMIT 3;
SELECT * FROM cancion LIMIT 5;

SELECT c.titulo, AVG(d.n_veces) AS promedio_descargas
FROM descarga d
JOIN cancion c ON c.id_cancion = d.id_cancion
GROUP BY c.id_cancion, c.titulo;

SELECT u.correo, r.cuota
FROM registrado r
JOIN usuario u ON u.id_usuario = r.id_usuario
WHERE r.cuota > (SELECT AVG(cuota) FROM registrado);


    
    
    
    