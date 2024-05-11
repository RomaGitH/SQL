/*


	Hill Database


 */

CREATE SCHEMA workout;	

CREATE TABLE workout.tipo_entrenamiento(
	id SERIAL PRIMARY KEY,
	tipo varchar(60)
);

CREATE TABLE workout.tipo_ejercicio(
	id SERIAL PRIMARY KEY,
	tipo varchar(60)
);

CREATE TABLE workout.Entrenamiento(
	id SERIAL PRIMARY KEY,
	id_tipo int2,
	fecha date,
	observaciones varchar(255),
	CONSTRAINT fk_tipo_entrenamiento FOREIGN KEY (id_tipo) REFERENCES workout.tipo_entrenamiento(id)
);

CREATE TABLE workout.Ejercicio(
	id SERIAL PRIMARY KEY,
	id_tipo int2,
	id_entrenamiento int2,
	set_1 int2,
	set_2 int2,
	set_3 int2,
	set_4 int2,
	set_5 int2,
	CONSTRAINT fk_tipo_ejercio FOREIGN KEY (id_tipo) REFERENCES workout.tipo_ejercicio(id),
	CONSTRAINT fk_entrenamiento FOREIGN KEY (id_entrenamiento) REFERENCES workout.entrenamiento(id)
);

INSERT INTO workout.tipo_entrenamiento (tipo) VALUES ('Parque'), ('Casa_piernas'), ('Casa_no_piernas');

INSERT INTO workout.tipo_ejercicio (tipo) VALUES ('Pull Ups'), ('Chin Ups'), ('Dips'), ('Pistol Squat'), ('Single Leg Bridge'), ('Calf Raises'),
												 ('Push Ups'), ('Decline Push Ups'), ('Pike Push ups'), ('Shoulder Raises'), ('Running'), ('Muscle Ups'),
												 ('One Arm Push Ups');
												
SELECT * FROM workout.tipo_ejercicio t  
INSERT INTO workout.entrenamiento(id_tipo, fecha, observaciones) VALUES (2,'30/12/2023', '')
INSERT INTO workout.ejercicio(id_tipo, id_entrenamiento, set_1, set_2, set_3, set_4) VALUES (9, 2, 9, 6, 9, 8), (10, 2, 9, 8, 9, 10), (8, 2, 8, 11, 7, 6);

SELECT * FROM workout.ejercicio w INNER JOIN workout.entrenamiento e ON w.id_entrenamiento = e.id WHERE e.id = 1
