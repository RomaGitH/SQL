/*

select count(p.apellido) from licon.registro_charla_licencia_conductor r inner join licon.asistente_registro_charla_licon a 
	on r.id = a.id_registro inner join persona.actor p on a.id_persona = p.id
	where r.id = 2200305
	
select distinct tipo from licon.estado_solicitud_licencia_conductor 
	
select count(*) from licon.solicitud_licencia_conductor s inner join licon.estado_solicitud_licencia_conductor e
	on s.id_estado_actual = e.id
	where extract(year from s.fecha) = '2022' and e.tipo = 'PRESENTADA'

select e.fecha presentada, s.fecha solicitud from licon.estado_solicitud_licencia_conductor e
	inner join licon.solicitud_licencia_conductor s
	on e.id_solicitud = s.id
	where e.tipo = 'PRESENTADA' and extract(year from e.fecha) = '2023'
	and date(e.fecha) != s.fecha 
	

select * from licon.registro_charla_licencia_conductor rclc 
select count(*) from persona.ocupacion o 
	where o.nombre_ocupacion = 'medico'
	
select count(*) from licon.detalle_liquidacion_solicitud_licencia_conductor
	where id_subtributo is null	

select count(*) from licon.detalle_liquidacion_solicitud_licencia_conductor
	where id_subtributo is null and id_concepto is null
	
select sum(d.importe), sum(v.importe) from licon.liquidacion_solicitud_licencia_conductor l inner join
	licon.detalle_liquidacion_solicitud_licencia_conductor d on l.id  = d.id_liquidacion 
	inner join licon.concepto_medico c on d.id_concepto = c.id inner join 
	licon.valor_concepto_medico v on v.id_concepto = c.id
	where extract( year from l.fecha) = '2023'
	
	select sum(d.importe), sum(taa.importe) from licon.liquidacion_solicitud_licencia_conductor l inner join
	licon.detalle_liquidacion_solicitud_licencia_conductor d on l.id  = d.id_liquidacion 
	inner join licon.subtributo s on d.id_subtributo = s.id inner join 
	licon.tasa_actuacion_administrativa taa on taa.id_subtributo = s.id
	where extract( year from l.fecha) = '2023'

select count(distinct u.reparticion) from persona.usuario u 
	
select u.chapa_inspector  , count(id) from persona.usuario u
group by u.chapa_inspector 
select count(id) from persona.actor 
where id_actor_unificado is not null
select documento_identidad_tipo , count(documento_identidad_tipo)from persona.actor
group by documento_identidad_tipo 


select f.nombre_funcion, count(id) from persona.funcion f 
group by f.nombre_funcion 
select * from persona.actor a 
where a.id = 509882
select * from persona.integra_persona_juridica


select distinct tipo_gestion from licon.solicitud_licencia_conductor_clase 


select count(*) from licon.registro_charla_licencia_conductor rclc 


select r.id, count(c.id) from licon.registro_charla_licencia_conductor r inner join
licon.capacitador_registro_charla_licon c on
r.id = c.id_registro 
group by r.id


select s.resultado_practico, t.resultado from licon.solicitud_licencia_conductor_clase s inner join
	licon.solicitud_licencia_conductor_examen_practico t on s.id_solicitud  = t.id_solicitud 
	where s.resultado_practico != t.resultado 


select s.id_localidad, l.id from licon.solicitud_licencia_conductor s inner join persona.actor a 
on s.id_persona = a.id inner join persona.pais p on a.id_pais = p.id
inner join persona.provincia_estado e on e.id_pais = p.id inner join 
persona.localidad l on e.id = l.id_provincia
where s.id_localidad = l.id
limit 100

select tipo, count(id) from licon.valor_concepto_medico
group by tipo

select count(*) from licon.solicitud_licencia_conductor_clase slcc 

select count(s.id), taa.id taa from licon.subtributo s inner join licon.tasa_actuacion_administrativa taa
	on s.id = taa.id_subtributo
	group by taa.id 
	order by taa.id
	
*/

-- Transformación inicial de datos en STG y creación del dimensional en DW

drop schema if exists stg cascade;
create schema stg;
drop schema if exists dw cascade;
create schema dw;

SELECT * INTO stg.actor FROM persona.actor;
SELECT * INTO stg.departamento FROM persona.departamento;
SELECT * INTO stg.direccion_actor FROM persona.direccion_actor;
SELECT * INTO stg.funcion FROM persona.funcion;
SELECT * INTO stg.integra_organismo FROM persona.integra_organismo;
SELECT * INTO stg.integra_persona_juridica FROM persona.integra_persona_juridica;
SELECT * INTO stg.localidad FROM persona.localidad;
SELECT * INTO stg.ocupacion FROM persona.ocupacion;
SELECT * INTO stg.pais FROM persona.pais;
SELECT * INTO stg.provincia_estado FROM persona.provincia_estado;
SELECT * INTO stg.rol FROM persona.rol;
SELECT * INTO stg.tipo_persona_juridica FROM persona.tipo_persona_juridica;
SELECT * INTO stg.usuario FROM persona.usuario;

SELECT * INTO stg.asistente_registro_charla_licon FROM licon.asistente_registro_charla_licon;
SELECT * INTO stg.capacitador_registro_charla_licon FROM licon.capacitador_registro_charla_licon;
SELECT * INTO stg.clase_licencia_conducir FROM licon.clase_licencia_conducir;
SELECT * INTO stg.clase_licencia_conducir_requerida FROM licon.clase_licencia_conducir_requerida;
SELECT * INTO stg.concepto_medico FROM licon.concepto_medico;
SELECT * INTO stg.detalle_liquidacion_solicitud_licencia_conductor FROM licon.detalle_liquidacion_solicitud_licencia_conductor;
SELECT * INTO stg.estado_solicitud_licencia_conductor FROM licon.estado_solicitud_licencia_conductor;
SELECT * INTO stg.liquidacion_solicitud_licencia_conductor FROM licon.liquidacion_solicitud_licencia_conductor;
SELECT * INTO stg.motivo_rechazo FROM licon.motivo_rechazo;
SELECT * INTO stg.registro_charla_licencia_conductor FROM licon.registro_charla_licencia_conductor;
SELECT * INTO stg.solicitud_licencia_conductor FROM licon.solicitud_licencia_conductor;
SELECT * INTO stg.solicitud_licencia_conductor_clase FROM licon.solicitud_licencia_conductor_clase;
SELECT * INTO stg.solicitud_licencia_conductor_examen_medico FROM licon.solicitud_licencia_conductor_examen_medico;
SELECT * INTO stg.solicitud_licencia_conductor_examen_practico FROM licon.solicitud_licencia_conductor_examen_practico;
SELECT * INTO stg.solicitud_licencia_conductor_examen_psiquiatrico FROM licon.solicitud_licencia_conductor_examen_psiquiatrico;
SELECT * INTO stg.solicitud_licencia_conductor_examen_teorico FROM licon.solicitud_licencia_conductor_examen_teorico;
SELECT * INTO stg.subtributo FROM licon.subtributo;
SELECT * INTO stg.tasa_actuacion_administrativa FROM licon.tasa_actuacion_administrativa;
SELECT * INTO stg.valor_concepto_medico FROM licon.valor_concepto_medico;

-- ##################################################################################
--1-Tipo de domcilio

ALTER TABLE stg.direccion_actor ADD COLUMN id_tipo_domicilio int4;

BEGIN TRANSACTION;
	UPDATE stg.direccion_actor SET id_tipo_domicilio =
		CASE WHEN tipo_domicilio = 'CASA_CENTRAL' THEN 1
			 WHEN tipo_domicilio = 'FISCAL' THEN 2
			 WHEN tipo_domicilio = 'LABORAL' THEN 3
			 WHEN tipo_domicilio = 'LEGAL' THEN 4
			 WHEN tipo_domicilio = 'OTRO' THEN 5
			 WHEN tipo_domicilio = 'PARTICULAR' THEN 6
			 WHEN tipo_domicilio = 'SUCURSAL' THEN 7
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_domicilio cascade;

CREATE TABLE dw.d_tipo_domicilio(
	id int4 PRIMARY KEY,
	nombre_tipo_domicilio varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_domicilio VALUES
	(1, 'CASA_CENTRAL'), (2, 'FISCAL'), (3, 'LABORAL'),
	(4, 'LEGAL'), (5, 'OTRO'), (6, 'PARTICULAR'), (7, 'SUCURSAL');
COMMIT TRANSACTION;

-- ##################################################################################
--2-Localidad

DROP TABLE IF EXISTS dw.d_localidad CASCADE;

CREATE TABLE dw.d_localidad(
	id int4 PRIMARY KEY,
	localidad varchar(50),
	departamento varchar(50),
	provincia varchar(50),
	pais varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_localidad
		SELECT l.id, l.nombre_localidad, d.nombre_departamento,
				pe.nombre_provincia, p.nombre_pais 
		FROM stg.localidad l, stg.departamento d,
					stg.provincia_estado pe, stg.pais p
		WHERE l.id_departamento = d.id AND l.id_provincia = pe.id 
		AND pe.id_pais = p.id;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
	INSERT INTO dw.d_localidad
		SELECT l.id, l.nombre_localidad, 'NO_INFORMADO',
				pe.nombre_provincia, p.nombre_pais 
		FROM stg.localidad l,stg.provincia_estado pe, stg.pais p
		WHERE l.id_provincia = pe.id AND pe.id_pais = p.id
			AND l.id_departamento IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
	INSERT INTO dw.d_localidad
		SELECT l.id, l.nombre_localidad, 'NO_INFORMADO',
				'NO_INFORMADO', 'NO_INFORMADO'
		FROM stg.localidad l
		WHERE l.id_provincia IS NULL 
			AND l.id_departamento IS NULL;
COMMIT TRANSACTION;

-- ##################################################################################
--3-Tipo persona juridica

DROP TABLE IF EXISTS dw.d_tipo_persona_juridica CASCADE;

CREATE TABLE dw.d_tipo_persona_juridica(
	id int4 PRIMARY KEY,
	nombre varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_persona_juridica
		SELECT id, nombre_tipo_persona_juridica FROM stg.tipo_persona_juridica; 
COMMIT TRANSACTION;

-- ##################################################################################
--4-OCUPACION

DROP TABLE IF EXISTS dw.d_ocupacion CASCADE;

CREATE TABLE dw.d_ocupacion(
	id int4 PRIMARY KEY,
	nombre varchar(80)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_ocupacion
		SELECT id, nombre_ocupacion  FROM stg.ocupacion;
COMMIT TRANSACTION;

-- ##################################################################################
--5-Rol

DROP TABLE IF EXISTS dw.d_rol CASCADE;

CREATE TABLE dw.d_rol(
	id int4 PRIMARY KEY,
	nombre varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_rol
		SELECT id, tipo_rol FROM stg.rol;
COMMIT TRANSACTION;

-- ##################################################################################
--6-Usuario

DROP TABLE IF EXISTS dw.d_usuario CASCADE;

CREATE TABLE dw.d_usuario(
	id int4 PRIMARY KEY,
	nombre varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_usuario
		SELECT id, apellido_nombre FROM stg.usuario;
COMMIT TRANSACTION;

-- ##################################################################################
--7-Tipo actor

ALTER TABLE stg.actor ADD COLUMN id_tipo_actor int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_tipo_actor =
		CASE WHEN tipo = 'F' THEN 1
			 WHEN tipo = 'J' THEN 2
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_actor CASCADE;

CREATE TABLE dw.d_tipo_actor(
	id int2 PRIMARY KEY,
	nombre varchar(50)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_actor VALUES (1, 'Fisica'), (2,'Juridica');
COMMIT TRANSACTION;

-- ##################################################################################
--8-Tipo documento
ALTER TABLE stg.actor ADD COLUMN id_tipo_documento int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_tipo_documento =
		CASE WHEN documento_identidad_tipo = ' ' THEN 1
			 WHEN documento_identidad_tipo is null THEN 1
			 WHEN documento_identidad_tipo = 'B' THEN 2
			 WHEN documento_identidad_tipo = 'C' THEN 3
			 WHEN documento_identidad_tipo = 'D' THEN 4
			 WHEN documento_identidad_tipo = 'E' THEN 5
			 WHEN documento_identidad_tipo = 'F' THEN 6
			 WHEN documento_identidad_tipo = 'N' THEN 7
			 WHEN documento_identidad_tipo = 'O' THEN 8
			 WHEN documento_identidad_tipo = 'P' THEN 9
			 WHEN documento_identidad_tipo = 'U' THEN 10
			 WHEN documento_identidad_tipo = 'X' THEN 11
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_documento CASCADE;

CREATE TABLE dw.d_tipo_documento(
	id int2 PRIMARY KEY,
	nombre varchar(2)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_documento VALUES (1, 'NI'), (2,'B'), (3,'C'), (4,'D'), (5,'E'),
								(6,'F'), (7,'N'), (8,'O'), (9,'P'), (10,'U'), (11,'X');
COMMIT TRANSACTION;

-- ##################################################################################
--9-Estado civil

ALTER TABLE stg.actor ADD COLUMN id_estado_civil int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_estado_civil =
		CASE WHEN estado_civil is null THEN 1
			 WHEN estado_civil = 'N' THEN 1
			 WHEN estado_civil = 'C' THEN 2
			 WHEN estado_civil = 'D' THEN 3
			 WHEN estado_civil = 'E' THEN 4
			 WHEN estado_civil = 'S' THEN 5
			 WHEN estado_civil = 'V' THEN 6
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_estado_civil CASCADE;

CREATE TABLE dw.d_estado_civil(
	id int2 PRIMARY KEY,
	nombre varchar(2)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_estado_civil VALUES (1, 'N'), (2,'C'), (3,'D'), (4,'E'), (5,'S'), (6,'V');
COMMIT TRANSACTION;

-- ##################################################################################
--10-Sexo

ALTER TABLE stg.actor ADD COLUMN id_sexo int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_sexo =
		CASE WHEN sexo = 'F' THEN 1
			 WHEN sexo = 'M' THEN 2
			 WHEN sexo = 'N' THEN 3
			 WHEN sexo is null THEN 3
			 WHEN sexo = ' ' THEN 3
			 WHEN sexo = 'O' THEN 4
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_sexo CASCADE;

CREATE TABLE dw.d_sexo(
	id int2 PRIMARY KEY,
	nombre varchar(2)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_sexo VALUES (1, 'F'), (2,'M'), (3,'N'), (4,'O');
COMMIT TRANSACTION;

-- ##################################################################################
--11-Factor sanguineo

ALTER TABLE stg.actor ADD COLUMN id_factor_sanguineo int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_factor_sanguineo =
		CASE WHEN factor_sanguineo = 'AB' THEN 1
			 WHEN factor_sanguineo = 'NEGATIVO' THEN 2
			 WHEN factor_sanguineo = 'POSITIVO' THEN 3
			 WHEN factor_sanguineo = 'NO INFORMADO' THEN 4
			 WHEN factor_sanguineo = 'NO_INFORMADO' THEN 4
			 WHEN factor_sanguineo is NULL THEN 4
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_factor_sanguineo CASCADE;

CREATE TABLE dw.d_factor_sanguineo(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_factor_sanguineo VALUES (1, 'AB'), (2,'NEGATIVO'), (3,'POSITIVO'), (4,'NO_INFOMADO');
COMMIT TRANSACTION;

-- ##################################################################################
--12-Factor sanguineo

ALTER TABLE stg.actor ADD COLUMN id_grupo_sanguineo int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_grupo_sanguineo =
		CASE WHEN grupo_sanguineo = 'A' THEN 1
			 WHEN grupo_sanguineo = 'AB' THEN 2
			 WHEN grupo_sanguineo = 'B' THEN 3
			 WHEN grupo_sanguineo = 'NEGATIVO' THEN 4
			 WHEN grupo_sanguineo = 'O' THEN 5
			 WHEN grupo_sanguineo = 'NO INFORMADO' THEN 6
			 WHEN grupo_sanguineo = 'NO_INFORMADO' THEN 6
			 WHEN grupo_sanguineo is NULL THEN 6
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_grupo_sanguineo CASCADE;

CREATE TABLE dw.d_grupo_sanguineo(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_grupo_sanguineo VALUES (1, 'A'), (2,'AB'), (3,'B'), (4,'NEGATIVO'),
		(5,'O'), (6,'NO_INFORMADO');
COMMIT TRANSACTION;

-- ##################################################################################
--13-Donante organos

ALTER TABLE stg.actor ADD COLUMN id_donante_organos int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_donante_organos =
		CASE WHEN donante_organos = 'NO' THEN 1
			 WHEN donante_organos = 'SI' THEN 2
			 WHEN donante_organos = 'NO INFORMADO' THEN 3
			 WHEN donante_organos = 'NO_INFORMADO' THEN 3
			 WHEN donante_organos is null THEN 3
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_donante_organos CASCADE;

CREATE TABLE dw.d_donante_organos(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_donante_organos VALUES (1, 'NO'), (2,'SI'), (3,'NO_INFORMADO');
COMMIT TRANSACTION;

-- ##################################################################################
--14-Identidad Genero
ALTER TABLE stg.actor ADD COLUMN id_identidad_genero int2;

BEGIN TRANSACTION;
	UPDATE stg.actor SET id_identidad_genero =
		CASE WHEN identidad_genero = 'MUJER_CIS' THEN 1
			 WHEN identidad_genero = 'MUJER_TRANS' THEN 2
			 WHEN identidad_genero = 'OTROS' THEN 3
			 WHEN identidad_genero = 'VARON_CIS' THEN 4
			 WHEN identidad_genero = 'VARON_TRANS' THEN 5
			 WHEN identidad_genero = 'NO_INFORMADO' THEN 6
			 WHEN identidad_genero = ' ' THEN 6
			 WHEN identidad_genero is null THEN 6
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_identidad_genero CASCADE;

CREATE TABLE dw.d_identidad_genero(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_identidad_genero VALUES (1, 'MUJER_CIS'), (2,'MUJER_TRANS'), (3,'OTROS'),
										(4, 'VARON_CIS'), (5,'VARON_TRANS'), (6,'NO_INFORMADO');
COMMIT TRANSACTION;


-- ##################################################################################
--15-Actor

DROP TABLE IF EXISTS dw.d_actor CASCADE;

CREATE TABLE dw.d_actor(
	id int4 PRIMARY KEY,
	nombre varchar(255),
	apellido varchar(255),
	nombre_fantasia varchar(255),
	nombre_organismo varchar(255),
	razon_social varchar(255),
	sigla varchar(40)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_actor 
		SELECT id, nombre, apellido, nombre_fantasia
			nombre_organismo, razon_social, sigla
			FROM stg.actor;
COMMIT TRANSACTION;	

-- ##################################################################################
--16-Funcion

DROP TABLE IF EXISTS dw.d_funcion CASCADE;

CREATE TABLE dw.d_funcion(
	id int4 PRIMARY KEY,
	nombre varchar(40)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_funcion 
		SELECT id, nombre_funcion FROM stg.funcion;
COMMIT TRANSACTION;

-- ##################################################################################
--17-Fecha

drop table if exists dw.d_fecha;

create table dw.d_fecha
(
  id						int8,
  fecha						date,
  epoch						bigint,
  dia_del_mes   			smallint,
  dia_nombre    			varchar(9),
  dia_nombre_corto			varchar(3),
  dia_semana				smallint,
  dia_trimestre				smallint,
  dia_anio					smallint,
  semana_mes				smallint,
  semana_anio				smallint,
  mes_numero				smallint,
  mes_nombre				varchar(10),
  mes_nombre_corto			varchar(3),
  trimestre_numero			smallint,
  trimestre_nombre			varchar(20),
  trimestre_nombre_corto	varchar(9),
  bimestre_nombre			varchar(20),
  bimestre_nombre_corto		varchar(9),
  semestre_nombre 			varchar(20),
  anio_actual				smallint,
  fecha_primerdia_semana	date,
  fecha_ultimodia_semana	date,
  fecha_comienzo_trimestre	date,
  fecha_fin_trimestre		date,
  mes2_anio4				char(6),
  mes2_dia2_anio4			char(10),
  es_finde					boolean,
  es_feriado				boolean,
  nombre_feriado			varchar(20),
  fechar					varchar(10),
  constraint pk_fecha primary key (id)
);

insert into dw.d_fecha 
   select  
       to_char(datum,'yyyymmdd')::int as id_fecha,
       datum as fecha_actual,
       extract(epoch from datum) as epoch,
       extract(day from datum) as dia_mes,
       trim(case when to_char(datum,'d') = '1' then 'Domingo'
       			 when to_char(datum,'d') = '2' then 'Lunes'
       			 when to_char(datum,'d') = '3' then 'Martes'
       			 when to_char(datum,'d') = '4' then 'Miércoles'
       			 when to_char(datum,'d') = '5' then 'Jueves'
       			 when to_char(datum,'d') = '6' then 'Viernes'
       			 when to_char(datum,'d') = '7' then 'Sábado'
       		end) dia_nombre,
       trim(case when to_char(datum,'d') = '1' then 'Dom'
       			 when to_char(datum,'d') = '2' then 'Lun'
       			 when to_char(datum,'d') = '3' then 'Mar'
       			 when to_char(datum,'d') = '4' then 'Mie'
       			 when to_char(datum,'d') = '5' then 'Jue'
       			 when to_char(datum,'d') = '6' then 'Vie'
       			 when to_char(datum,'d') = '7' then 'Sab'
       		end) dia_nombre_corto,
       extract(isodow from datum) AS dia_semana,
       datum - date_trunc('quarter',datum)::date +1 as dia_trimestre,
       extract(doy from datum) as dia_anio,
       to_char(datum,'W')::int as semana_mes,
       extract(week from datum) as semana_anio,
       extract(month from datum) as mes_numero,
       trim(case when to_char(datum,'mm') = '01' then 'Enero'
        		 when to_char(datum,'mm') = '02' then 'Febrero'
         		 when to_char(datum,'mm') = '03' then 'Marzo'
         		 when to_char(datum,'mm') = '04' then 'Abril'
         		 when to_char(datum,'mm') = '05' then 'Mayo'
         		 when to_char(datum,'mm') = '06' then 'Junio'
         		 when to_char(datum,'mm') = '07' then 'Julio'
         		 when to_char(datum,'mm') = '08' then 'Agosto'
         		 when to_char(datum,'mm') = '09' then 'Septiembre'
         		 when to_char(datum,'mm') = '10' then 'Octubre'
         		 when to_char(datum,'mm') = '11' then 'Noviembre'
         		 when to_char(datum,'mm') = '12' then 'Diciembre'
         	end) as mes_nombre,
       trim(case when to_char(datum,'mm') = '01' then 'Ene'
       			 when to_char(datum,'mm') = '02' then 'Feb'
       			 when to_char(datum,'mm') = '03' then 'Mar'
       			 when to_char(datum,'mm') = '04' then 'Abr'
       			 when to_char(datum,'mm') = '05' then 'May'
       			 when to_char(datum,'mm') = '06' then 'Jun'
       			 when to_char(datum,'mm') = '07' then 'Jul'
       			 when to_char(datum,'mm') = '08' then 'Ago'
       			 when to_char(datum,'mm') = '09' then 'Sep'
       			 when to_char(datum,'mm') = '10' then 'Oct'
       			 when to_char(datum,'mm') = '11' then 'Nov'
       			 when to_char(datum,'mm') = '12' then 'Dic'
       		end) as mes_nombre_corto,
       extract(quarter from datum) as trimestre_numero,
       case
         		 when extract(quarter from datum) = 1 then 'Primer trimestre'
		         when extract(quarter from datum) = 2 then 'Segundo trimestre'
         		 when extract(quarter from datum) = 3 then 'Tercer trimestre'
		         when extract(quarter from datum) = 4 then 'Cuarto trimestre'
	        end as trimestre_nombre,
       case
		         when extract(quarter from datum) = 1 then 'Trim.1'
		         when extract(quarter from datum) = 2 then 'Trim.2'
		         when extract(quarter from datum) = 3 then 'Trim.3'
		         when extract(quarter from datum) = 4 then 'Trim.4'
	        end as trimestre_nombre_corto,
       trim(case when to_char(datum,'mm') = '01' then 'Primer bimestre'
	         	 when to_char(datum,'mm') = '02' then 'Primer bimestre'
	         	 when to_char(datum,'mm') = '03' then 'Segundo bimestre'
	         	 when to_char(datum,'mm') = '04' then 'Segundo bimestre'
	         	 when to_char(datum,'mm') = '05' then 'Tercer bimestre'
	         	 when to_char(datum,'mm') = '06' then 'Tercer bimestre'
	         	 when to_char(datum,'mm') = '07' then 'Cuarto bimestre'
	         	 when to_char(datum,'mm') = '08' then 'Cuarto bimestre'
	         	 when to_char(datum,'mm') = '09' then 'Quinto bimestre'
	         	 when to_char(datum,'mm') = '10' then 'Quinto bimestre'
	         	 when to_char(datum,'mm') = '11' then 'Sexto bimestre'
	         	 when to_char(datum,'mm') = '12' then 'Sexto bimestre'
	       end) as bimestre_nombre,
       trim(case when to_char(datum,'mm') = '01' then 'Bim.1'
		         when to_char(datum,'mm') = '02' then 'Bim.1'
		         when to_char(datum,'mm') = '03' then 'Bim.2'
		         when to_char(datum,'mm') = '04' then 'Bim.2'
		         when to_char(datum,'mm') = '05' then 'Bim.3'
		         when to_char(datum,'mm') = '06' then 'Bim.3'
		         when to_char(datum,'mm') = '07' then 'Bim.4'
		         when to_char(datum,'mm') = '08' then 'Bim.4'
		         when to_char(datum,'mm') = '09' then 'Bim.5'
		         when to_char(datum,'mm') = '10' then 'Bim.5'
		         when to_char(datum,'mm') = '11' then 'Bim.6'
		         when to_char(datum,'mm') = '12' then 'Bim.6'
		    end) as bimestre_nombre_corto,
       trim(case when to_char(datum,'mm') = '01' then 'Primer semestre'
		         when to_char(datum,'mm') = '02' then 'Primer semestre'
		         when to_char(datum,'mm') = '03' then 'Primer semestre'
        		 when to_char(datum,'mm') = '04' then 'Primer semestre'
		         when to_char(datum,'mm') = '05' then 'Primer semestre'
		         when to_char(datum,'mm') = '06' then 'Primer semestre'
		         when to_char(datum,'mm') = '07' then 'Segundo semestre'
		         when to_char(datum,'mm') = '08' then 'Segundo semestre'
		         when to_char(datum,'mm') = '09' then 'Segundo semestre'
		         when to_char(datum,'mm') = '10' then 'Segundo semestre'
		         when to_char(datum,'mm') = '11' then 'Segundo semestre'
		         when to_char(datum,'mm') = '12' then 'Segundo semestre'
		    end) as semestre_nombre,
       extract(year from datum) as anio_actual,
       datum +(1 -extract(isodow from datum))::int as primer_dia_semana,
       datum +(7 -extract(isodow from datum))::int as ultimo_dia_semana,
       date_trunc('quarter',datum)::date as primer_dia_trimestre,
       (date_trunc('quarter',datum) +interval '3 MONTH - 1 day')::date as ultimo_dia_trimestre,
       to_char(datum,'mmyyyy') as mes2_anio4,
       to_char(datum,'mmddyyyy') as mes2_dia2_anio4,
       case
         	when extract(isodow from datum) in (6,7) then true
         	else false
       		end as es_finde,
       false as es_feriado,
       'Laborable' as nombre_feriado,
       substring(to_char(datum,'mmddyyyy')from 5 for 4)||'/'||substring(to_char(datum,'mmddyyyy') from 1 for 2)||'/'||substring(to_char(datum,'mmddyyyy') from 3 for 2)
      from (select '1890-01-01'::date+ sequence.day as datum from generate_series (0,60000) as sequence (day)
      group by sequence.day) DQ order by 1;

-- ##################################################################################
--18-Alta Usuario

DROP TABLE IF EXISTS dw.h_alta_usuario CASCADE;
CREATE TABLE dw.h_alta_usuario(
	id_fecha_alta int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_usuario int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_alta_usuario
		SELECT 		
			to_char(u.fecha_alta,'yyyymmdd')::int, u.id_actor, da.id_tipo_domicilio, da.id_localidad,
			a.id_tipo_persona_juridica, a.id_ocupacion, u.id, a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil,
			a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero, r.id 
			FROM stg.usuario u INNER join stg.actor a ON u.id_actor = a.id INNER JOIN stg.direccion_actor da 
			ON a.id = da.id_actor LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;

-- INTEGRIDAD
alter table dw.h_alta_usuario 
  add constraint fk_fecha_alta foreign key (id_fecha_alta) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_usuario foreign key (id_usuario) references dw.d_usuario(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

-- ##################################################################################
--19-Alta Actor
 
DROP TABLE IF EXISTS dw.h_alta_actor CASCADE;

CREATE TABLE dw.h_alta_actor(
	id_fecha_alta int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_alta_actor
		SELECT 
			to_char(a.fecha_alta,'yyyymmdd')::int, a.id , da.id_tipo_domicilio, da.id_localidad,
			a.id_tipo_persona_juridica, a.id_ocupacion, a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil,
			a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.actor a LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;     

-- INTEGRIDAD
alter table dw.h_alta_actor 
  add constraint fk_fecha_alta foreign key (id_fecha_alta) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

	   
-- ##################################################################################
--20-Baja Actor

DROP TABLE IF EXISTS dw.h_baja_actor CASCADE;

CREATE TABLE dw.h_baja_actor(
	id_fecha_baja int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);
     
BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_baja_actor
		SELECT 		
			to_char(a.fecha_baja,'yyyymmdd')::int, a.id , da.id_tipo_domicilio, da.id_localidad,
			a.id_tipo_persona_juridica, a.id_ocupacion, a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil,
			a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.actor a LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON da.id_actor = r.id_actor
			WHERE a.fecha_baja IS NOT NULL;
COMMIT TRANSACTION;     
    
-- INTEGRIDAD
alter table dw.h_baja_actor 
  add constraint fk_fecha_baja foreign key (id_fecha_baja) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);


-- ##################################################################################
--21-Unificacion Actor

DROP TABLE IF EXISTS dw.h_unificacion_actor CASCADE;
CREATE TABLE dw.h_unificacion_actor(
	id_fecha_unificacion int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_actor_unificado int4,
	id_rol int4
);
     
BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_unificacion_actor
		SELECT 		
			to_char(a.fecha_unificacion,'yyyymmdd')::int, a.id , da.id_tipo_domicilio, da.id_localidad,
			a.id_tipo_persona_juridica, a.id_ocupacion, a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil,
			a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero,
			a.id_actor_unificado, r.id
			FROM stg.actor a LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON da.id_actor = r.id_actor
			WHERE a.fecha_unificacion IS NOT NULL;
COMMIT TRANSACTION;     
    
-- INTEGRIDAD
alter table dw.h_unificacion_actor 
  add constraint fk_fecha_unificacion foreign key (id_fecha_unificacion) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_actor_unificado foreign key (id_actor_unificado) references dw.d_actor(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

-- ##################################################################################
--22-Integra Persona Juridica

 DROP TABLE IF EXISTS dw.h_integra_persona_juridica CASCADE;
 
 CREATE TABLE dw.h_integra_persona_juridica(
	id_fecha_alta int8,
	id_fecha_baja int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_persona_juridica int4,
	id_rol int4,
	id_funcion int4
);
     
BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_integra_persona_juridica
		SELECT DISTINCT 	
			to_char(i.fecha_alta,'yyyymmdd')::int, to_char(i.fecha_baja,'yyyymmdd')::int,
			a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos,
			a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero, i.id_actor, r.id, i.id_funcion
			FROM stg.integra_persona_juridica i INNER JOIN stg.actor a  ON i.id_persona_fisica = a.id
			INNER JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON da.id_actor = r.id_actor;

	DELETE FROM dw.h_integra_persona_juridica
		WHERE id_fecha_alta = 90101 OR id_fecha_alta = 2080214 OR id_fecha_alta = 2200620; 

COMMIT TRANSACTION;     

-- INTEGRIDAD
alter table dw.h_integra_persona_juridica
  add constraint fk_fecha_alta foreign key (id_fecha_alta) references dw.d_fecha(id),
  add constraint fk_fecha_baja foreign key (id_fecha_baja) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_persona_juridica foreign key (id_persona_juridica) references dw.d_actor(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id),
  add constraint fk_funcion foreign key (id_funcion) references dw.d_funcion(id);

-- ##################################################################################
--23-Integra Organismo

 DROP TABLE IF EXISTS dw.h_integra_organismo CASCADE;
 
 CREATE TABLE dw.h_integra_organismo(
	id_fecha_alta int8,
	id_fecha_baja int8,
	id_actor int4,
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_organismo int4,
	id_rol int4,
	id_funcion int4
);
     
BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_integra_organismo
		SELECT DISTINCT 	
			to_char(i.fecha_alta,'yyyymmdd')::int, to_char(i.fecha_baja,'yyyymmdd')::int,
			a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos,
			a.id_factor_sanguineo, a.id_grupo_sanguineo, a.id_identidad_genero, i.id_actor, r.id, i.id_funcion
			FROM stg.integra_organismo i INNER JOIN stg.actor a  ON i.id_persona_fisica = a.id
			INNER JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON da.id_actor = r.id_actor;
COMMIT TRANSACTION;     

-- INTEGRIDAD
alter table dw.h_integra_organismo
  add constraint fk_fecha_alta foreign key (id_fecha_alta) references dw.d_fecha(id),
  add constraint fk_fecha_baja foreign key (id_fecha_baja) references dw.d_fecha(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_organismo foreign key (id_organismo) references dw.d_actor(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id),
  add constraint fk_funcion foreign key (id_funcion) references dw.d_funcion(id);

  -- ##################################################################################
--24-Charla
 
	CREATE OR REPLACE FUNCTION cantAsistentes()
		RETURNS void
		AS 
		$$
		DECLARE 
	DECLARE 
		cur RECORD;
	BEGIN
		FOR cur IN (SELECT id FROM dw.h_charla) LOOP
			UPDATE dw.h_charla SET asistentes =
				(SELECT count(a.id)
				FROM stg.asistente_registro_charla_licon a WHERE a.id_registro=cur.id)
			WHERE id = cur.id;
		END LOOP;
	END;
	$$
	LANGUAGE plpgsql;
	
 DROP TABLE IF EXISTS dw.h_charla CASCADE;
 
 CREATE TABLE dw.h_charla(
 	id int4,
 	id_categoria int2,
	id_fecha int8,
	id_capacitador int4,
	duracion int4,
	asistentes int4
 );
BEGIN TRANSACTION;
	INSERT INTO dw.h_charla
		SELECT r.id, 5, to_char(r.fecha,'yyyymmdd')::int, c.id,
			((r.hora_fin*60 + r.minutos_fin) - (r.hora_inicio*60 + r.minutos_inicio))
		FROM stg.registro_charla_licencia_conductor r LEFT JOIN
		stg.capacitador_registro_charla_licon c ON r.id = c.id_registro;
	SELECT cantAsistentes();
COMMIT TRANSACTION;
   
  alter table dw.h_charla 
	  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
	  add constraint fk_categoria foreign key (id_categoria) references dw.d_categoria(id);
	 
  -- ##################################################################################
--25-Motivo Rechazo

DROP TABLE IF EXISTS dw.d_motivo_rechazo CASCADE;
 
 CREATE TABLE dw.d_motivo_rechazo(
 	id int4 PRIMARY KEY,
 	nombre varchar(120)
 );

BEGIN TRANSACTION;
	INSERT INTO dw.d_motivo_rechazo
		SELECT id, descripcion_motivo_rechazo FROM stg.motivo_rechazo;
COMMIT TRANSACTION;

  -- ##################################################################################
--26-Tipo solicitud

ALTER TABLE stg.solicitud_licencia_conductor ADD COLUMN id_tipo int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor SET id_tipo =
		CASE WHEN tipo = 'COMUN' THEN 1
			 WHEN tipo = 'PROFESIONAL' THEN 2
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_solicitud CASCADE;

CREATE TABLE dw.d_tipo_solicitud(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_solicitud VALUES (1, 'COMUN'), (2,'PROFESIONAL');
COMMIT TRANSACTION;

  -- ##################################################################################
--27-Tipo gestion

ALTER TABLE stg.solicitud_licencia_conductor_clase ADD COLUMN id_tipo_gestion int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor_clase SET id_tipo_gestion =
		CASE WHEN tipo_gestion = 'AMPLIACION' THEN 1
			 WHEN tipo_gestion = 'CAMBIO_DATOS' THEN 2
			 WHEN tipo_gestion = 'EXTRAVIO' THEN 3
			 WHEN tipo_gestion = 'NUEVO' THEN 4
			 WHEN tipo_gestion = 'PROVINCIAL_A_NACIONAL' THEN 5
			 WHEN tipo_gestion = 'RENOVACION' THEN 6
			 WHEN tipo_gestion = 'REVALIDA_ANUAL' THEN 7
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_gestion CASCADE;

CREATE TABLE dw.d_tipo_gestion(
	id int2 PRIMARY KEY,
	nombre varchar(30)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_gestion VALUES (1, 'AMPLIACION'), (2,'CAMBIO_DATOS'), (3,'EXTRAVIO'),
		(4,'NUEVO'), (5,'PROVINCIAL_A_NACIONAL'), (6,'RENOVACION'), (7,'REVALIDA_ANUAL');
COMMIT TRANSACTION;

  -- ##################################################################################
--28-Licencia
	
DROP TABLE IF EXISTS dw.d_licencia CASCADE;
 
 CREATE TABLE dw.d_licencia(
 	id int4 PRIMARY KEY,
 	nombre varchar(20)
 );

BEGIN TRANSACTION;
	INSERT INTO dw.d_licencia
		SELECT id, clase FROM stg.clase_licencia_conducir;
COMMIT TRANSACTION;

  -- ##################################################################################
--29-Tipo liquidacion

ALTER TABLE stg.liquidacion_solicitud_licencia_conductor ADD COLUMN id_tipo_liquidacion int2;

BEGIN TRANSACTION;
	UPDATE stg.liquidacion_solicitud_licencia_conductor SET id_tipo_liquidacion =
		CASE WHEN tipo = 'MEDICO_COMUN' THEN 1
			 WHEN tipo = 'MEDICO_JUNTA' THEN 2
			 WHEN tipo = 'MEDICO_VENCIMIENTO' THEN 3
			 WHEN tipo = 'TASA_ACTUACION_ADMINISTRATIVA' THEN 4
			 WHEN tipo = 'TASA_ACTUACION_ADMINISTRATIVA_DIFERENCIAL' THEN 5
			 WHEN tipo = 'TASA_ACTUACION_ADMINISTRATIVA_DUPLICADO' THEN 6
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_liquidacion CASCADE;

CREATE TABLE dw.d_tipo_liquidacion(
	id int2 PRIMARY KEY,
	nombre varchar(60)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_liquidacion VALUES (1, 'MEDICO_COMUN'), (2,'MEDICO_JUNTA'), (3,'MEDICO_VENCIMIENTO'),
		(4,'TASA_ACTUACION_ADMINISTRATIVA'), (5,'TASA_ACTUACION_ADMINISTRATIVA_DIFERENCIAL'), (6,'TASA_ACTUACION_ADMINISTRATIVA_DUPLICADO');
COMMIT TRANSACTION;

-- ##################################################################################
--30-Tipo pago

ALTER TABLE stg.liquidacion_solicitud_licencia_conductor ADD COLUMN id_tipo_pago int2;

BEGIN TRANSACTION;
	UPDATE stg.liquidacion_solicitud_licencia_conductor SET id_tipo_pago =
		CASE WHEN tipo_pago = 'COMUN' THEN 1
			 WHEN tipo_pago = 'NO_INFORMADO' THEN 2
			 WHEN tipo_pago = 'USUARIO' THEN 3
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_pago CASCADE;

CREATE TABLE dw.d_tipo_pago(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_pago VALUES (1, 'COMUN'), (2,'NO_INFORMADO'), (3,'USUARIO');
COMMIT TRANSACTION;

  -- ##################################################################################
--31-Resultado Medico



-- ##################################################################################
--32-Resultado Examen
ALTER TABLE stg.solicitud_licencia_conductor_examen_medico  ADD COLUMN id_resultado int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor_examen_medico SET id_resultado =
		CASE WHEN resultado = 'APTO' THEN 1
			 WHEN resultado = 'NO_APTO' THEN 2
			 WHEN resultado = 'NO_INFORMADO' THEN 3
			 WHEN resultado = 'APTO_HIPOACUSICO' THEN 1
			 WHEN resultado = 'APTO_HIPOMONO' THEN 1
			 WHEN resultado = 'APTO_MONOCULAR' THEN 1
			 WHEN resultado = 'APTO_RESTRICCIONES' THEN 1
			 WHEN resultado = 'APTO_TEMPORARIO' THEN 1
			 WHEN resultado = 'EVALUACION_TECNICA_VIAL' THEN 3
			 WHEN resultado = 'INTERCONSULTA' THEN 3
			 WHEN resultado = 'NO_APTO_TEMPORARIO' THEN 2
		END;
COMMIT TRANSACTION;

ALTER TABLE stg.solicitud_licencia_conductor_examen_psiquiatrico ADD COLUMN id_resultado int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor_examen_psiquiatrico  SET id_resultado =
		CASE WHEN resultado = 'APTO' THEN 1
			 WHEN resultado = 'NO_APTO' THEN 2
			 WHEN resultado = 'NO_INFORMADO' THEN 3
		END;
COMMIT TRANSACTION;


ALTER TABLE stg.solicitud_licencia_conductor_examen_practico ADD COLUMN id_resultado int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor_examen_practico SET id_resultado =
		CASE WHEN resultado = 'APROBADO' THEN 1
			 WHEN resultado = 'NO_APROBADO' THEN 2
			 WHEN resultado = 'NO_INFORMADO' THEN 3
		END;
COMMIT TRANSACTION;

ALTER TABLE stg.solicitud_licencia_conductor_examen_teorico  ADD COLUMN id_resultado int2;

BEGIN TRANSACTION;
	UPDATE stg.solicitud_licencia_conductor_examen_teorico SET id_resultado =
		CASE WHEN resultado = 'APROBADO' THEN 1
			 WHEN resultado = 'NO_APROBADO' THEN 2
			 WHEN resultado = 'NO_INFORMADO' THEN 3
		END;
COMMIT TRANSACTION;


DROP TABLE IF EXISTS dw.d_resultado_examen CASCADE;

CREATE TABLE dw.d_resultado_examen(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_resultado_examen VALUES (1, 'APROBADO'), (2,'NO_APROBADO'), (3,'NO_INFORMADO');
COMMIT TRANSACTION;

-- ##################################################################################
--33-Estados

ALTER TABLE stg.estado_solicitud_licencia_conductor ADD COLUMN id_estado int2;

BEGIN TRANSACTION;
	UPDATE stg.estado_solicitud_licencia_conductor SET id_estado =
		CASE WHEN tipo = 'APROBADA' THEN 1
			 WHEN tipo = 'APROBADA_SIMUCO' THEN 2
			 WHEN tipo = 'EXAMEN_PRACTICO_APROBADO' THEN 3
			 WHEN tipo = 'EXAMEN_PRACTICO_PARCIALMENTE_APROBADO' THEN 4
			 WHEN tipo = 'EXAMEN_PRACTICO_REPROBADO' THEN 5
			 WHEN tipo = 'EXAMEN_PRACTICO_REPROBADO_N_VECES' THEN 6
			 WHEN tipo = 'EXAMEN_PSICO_FISICO_APTO' THEN 7
			 WHEN tipo = 'EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES' THEN 8
			 WHEN tipo = 'EXAMEN_PSICO_FISICO_INTERCONSULTA' THEN 9
			 WHEN tipo = 'EXAMEN_PSICO_FISICO_NO_APTO' THEN 10
			 WHEN tipo = 'EXAMEN_PSICO_FISICO_NO_APTO_TEMPORARIO' THEN 11
			 WHEN tipo = 'EXAMEN_PSIQUIATRICO_APTO' THEN 12
			 WHEN tipo = 'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES' THEN 13
			 WHEN tipo = 'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES' THEN 14
			 WHEN tipo = 'EXAMEN_PSIQUIATRICO_NO_APTO' THEN 15
			 WHEN tipo = 'EXAMEN_TEORICO_APROBADO' THEN 16
			 WHEN tipo = 'EXAMEN_TEORICO_REPROBADO' THEN 17
			 WHEN tipo = 'EXAMEN_TEORICO_REPROBADO_N_VECES' THEN 18
			 WHEN tipo = 'PARCIALMENTE_APROBADA' THEN 19
			 WHEN tipo = 'PRESENTADA' THEN 20
			 WHEN tipo = 'RECHAZADA' THEN 21
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_estado CASCADE;

CREATE TABLE dw.d_estado(
	id int2 PRIMARY KEY,
	nombre varchar(60)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_estado VALUES (1, 'APROBADA'), (2,'APROBADA_SIMUCO'), (3,'EXAMEN_PRACTICO_APROBADO'),
	(4,'EXAMEN_PRACTICO_PARCIALMENTE_APROBADO'), (5,'EXAMEN_PRACTICO_REPROBADO'), (6,'EXAMEN_PRACTICO_REPROBADO_N_VECES'),
	(7,'EXAMEN_PSICO_FISICO_APTO'), (8,'EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES'), (9,'EXAMEN_PSICO_FISICO_INTERCONSULTA'),
	(10,'EXAMEN_PSICO_FISICO_NO_APTO'), (11,'EXAMEN_PSICO_FISICO_NO_APTO_TEMPORARIO'), (12,'EXAMEN_PSIQUIATRICO_APTO'), 
	(13,'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES'), (14,'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES'), (15,'EXAMEN_PSIQUIATRICO_NO_APTO'),
	(16,'EXAMEN_TEORICO_APROBADO'), (17,'EXAMEN_TEORICO_REPROBADO'), (18,'EXAMEN_TEORICO_REPROBADO_N_VECES'), (19,'PARCIALMENTE_APROBADA'),
	(20,'PRESENTADA'), (21,'RECHAZADA');
COMMIT TRANSACTION;

-- ##################################################################################
--34-Solicitud
DROP TABLE IF EXISTS dw.d_solicitud;

CREATE TABLE dw.d_solicitud(
	id int4 PRIMARY KEY
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_solicitud
		SELECT id FROM stg.solicitud_licencia_conductor;
COMMIT TRANSACTION;
-- ##################################################################################
--35-Cambio Estado

DROP TABLE IF EXISTS dw.h_cambio_estado;

CREATE TABLE dw.h_cambio_estado(
	id_solicitud int4,
	id_estado int4,
	id_fecha int8
);

BEGIN TRANSACTION;
	INSERT INTO dw.h_cambio_estado
		SELECT s.id, e.id_estado, to_char(e.fecha,'yyyymmdd')::int
		FROM stg.solicitud_licencia_conductor s INNER JOIN stg.estado_solicitud_licencia_conductor e
			ON s.id = e.id_solicitud;
COMMIT TRANSACTION;

--integridad

  alter table dw.h_cambio_estado
      add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
      add constraint fk_estado foreign key (id_estado) references dw.d_estado(id),
	  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id);
	 
-- ##################################################################################
--36-Presentacion Solicitud
	 
DROP TABLE IF EXISTS dw.h_presentacion;

CREATE TABLE dw.h_presentacion(
	id_solicitud int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_presentacion
		SELECT 
			s.id, to_char(s.fecha,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;   

-- INTEGRIDAD
alter table dw.h_presentacion 
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);


-- ##################################################################################
--37-Rechazo Solicitud
DROP TABLE IF EXISTS dw.h_rechazo;

CREATE TABLE dw.h_rechazo(
	id_solicitud int4,
	id_motivo_rechazo int4,
	id_fecha_rechazo int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_rechazo
		SELECT 
			s.id, c.id_motivo_rechazo, to_char(c.fecha_rechazo,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor
			WHERE c.fecha_rechazo IS NOT NULL;
COMMIT TRANSACTION;   

-- INTEGRIDAD
alter table dw.h_rechazo
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_motivo_rechazo foreign key (id_motivo_rechazo) references dw.d_motivo_rechazo(id),
  add constraint fk_fecha_rechazo foreign key (id_fecha_rechazo) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);


-- ##################################################################################
--38-Impresion Solicitud
 
DROP TABLE IF EXISTS dw.h_impresion;

CREATE TABLE dw.h_impresion(
	id_solicitud int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_impresion
		SELECT 
			s.id, to_char(c.fecha_impresion ,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor
			WHERE c.fecha_impresion IS NOT NULL;
COMMIT TRANSACTION;   

-- INTEGRIDAD
alter table dw.h_impresion
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);


-- ##################################################################################
--39-Validacion Solicitud

DROP TABLE IF EXISTS dw.h_validacion;

CREATE TABLE dw.h_validacion(
	id_solicitud int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_validacion
		SELECT 
			s.id, to_char(c.fecha_validacion_final,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor
			WHERE c.fecha_validacion_final IS NOT NULL;
COMMIT TRANSACTION;   

-- INTEGRIDAD
alter table dw.h_validacion
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

-- ##################################################################################
--40-Entrega Solicitud

DROP TABLE IF EXISTS dw.h_entrega;

CREATE TABLE dw.h_entrega(
	id_solicitud int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_entrega
		SELECT 
			s.id, to_char(c.fecha_entrega,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor
			WHERE c.fecha_entrega IS NOT NULL;
COMMIT TRANSACTION;   

-- INTEGRIDAD
alter table dw.h_entrega
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

-- ##################################################################################
--41-Categoria Examen

 DROP TABLE IF EXISTS dw.d_categoria CASCADE;

CREATE TABLE dw.d_categoria(
	id int2 PRIMARY KEY,
	nombre varchar(20)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_categoria VALUES (1, 'MEDICO'), (2, 'PSIQUIATRICO'), (3, 'TEORICO'), (4, 'PRACTICO'), (5, 'CHARLA');
COMMIT TRANSACTION;
-- ##################################################################################
--42-Examen

DROP TABLE IF EXISTS dw.h_examen CASCADE;

CREATE TABLE dw.h_examen(
	id_categoria int2,
	id_solicitud int4,
	id_clase int4,
	id_resultado int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4,
	puntaje int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_examen
		SELECT 
			1 , s.id, NULL, e.id_resultado, to_char(e.fecha,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, null,
			null , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id, null
			FROM stg.solicitud_licencia_conductor s  INNER JOIN stg.solicitud_licencia_conductor_examen_medico e ON
			s.id = e.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON
			a.id = da.id_actor LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;   

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_examen
		SELECT 
			2 , s.id, NULL, e.id_resultado, to_char(e.fecha,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, null,
			null , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id, e.puntaje
			FROM stg.solicitud_licencia_conductor s  INNER JOIN stg.solicitud_licencia_conductor_examen_teorico e ON
			s.id = e.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON
			a.id = da.id_actor LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;  

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_examen
		SELECT 
			3 , s.id, c.id, e.id_resultado, to_char(e.fecha,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id, e.puntaje
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.solicitud_licencia_conductor_examen_practico e ON
			c.id = e.id_clase INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON
			a.id = da.id_actor LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_examen
		SELECT 
			4 , s.id, c.id, e.id_resultado, to_char(e.fecha,'yyyymmdd')::int, s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion,
			c.id_clase , a.id , da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion,
			a.id_tipo_actor, a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id, null
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.solicitud_licencia_conductor_examen_psiquiatrico e ON
			c.id = e.id_clase INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON
			a.id = da.id_actor LEFT JOIN stg.rol r ON a.id = r.id_actor;
COMMIT TRANSACTION;   

--Integridad

alter table dw.h_examen
  add constraint fk_categoria foreign key (id_categoria) references dw.d_categoria(id),
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_resultado foreign key (id_resultado) references dw.d_resultado_examen(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);

 
-- ##################################################################################
--43-Tipo tasa
 
ALTER TABLE stg.tasa_actuacion_administrativa ADD COLUMN id_tasa int2;

BEGIN TRANSACTION;
	UPDATE stg.tasa_actuacion_administrativa SET id_tasa =
		CASE WHEN tipo = 'POR_EDAD_OTRAS_CLASES' THEN 1
			 WHEN tipo = 'INICIAL' THEN 2
			 WHEN tipo = 'AMPLIACION' THEN 3
			 WHEN tipo = 'PROVINCIAL_A_NACIONAL' THEN 4
			 WHEN tipo = 'DUPLICADO' THEN 5
			 WHEN tipo = 'RENOVACION_NUMEROSA' THEN 6
			 WHEN tipo = 'POR_EDAD_CLASE_B' THEN 7
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_tasa CASCADE;

CREATE TABLE dw.d_tipo_tasa(
	id int2 PRIMARY KEY,
	nombre varchar(60)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_tasa VALUES (1, 'POR_EDAD_OTRAS_CLASES'), (2,'INICIAL'), (3,'AMPLIACION'),
	(4,'PROVINCIAL_A_NACIONAL'), (5,'DUPLICADO'), (6,'RENOVACION_NUMEROSA'), (7,'POR_EDAD_CLASE_B');
COMMIT TRANSACTION;

-- ##################################################################################
--44-Tasa
 
DROP TABLE IF EXISTS dw.d_tasa CASCADE;

CREATE TABLE dw.d_tasa(
	id int4 PRIMARY KEY,
	nombre varchar(60)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tasa
		SELECT id, descripcion FROM stg.tasa_actuacion_administrativa;
COMMIT TRANSACTION;

-- ##################################################################################
--45-Subtributo
 
DROP TABLE IF EXISTS dw.d_subtributo CASCADE;

CREATE TABLE dw.d_subtributo(
	id int4 PRIMARY KEY,
	nombre varchar(120)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_subtributo
		SELECT id, nombre_subtributo FROM stg.subtributo;
COMMIT TRANSACTION;
 -- ##################################################################################
--46-Actualizacion subtributo
 
DROP TABLE IF EXISTS dw.h_actualizacion_subtributo CASCADE;

CREATE TABLE dw.h_actualizacion_subtributo(
	id_fecha_alta int8,
	id_fecha_baja int8,
	id_subtributo int4,
	id_tasa int4,
	id_tipo_tasa int4,
	edad_desde int2,
	edad_hasta int2,
	importe int4
);

BEGIN TRANSACTION;
	INSERT INTO dw.h_actualizacion_subtributo
		SELECT to_char(t.fecha_alta ,'yyyymmdd')::int, to_char(t.fecha_baja ,'yyyymmdd')::int,
		s.id, t.id, t.id_tasa, t.edad_desde, t.edad_hasta, t.importe FROM stg.subtributo s INNER JOIN stg.tasa_actuacion_administrativa t
		ON s.id = t.id_subtributo;
COMMIT TRANSACTION;

ALTER TABLE dw.h_actualizacion_subtributo 
	add constraint fk_fecha_alta foreign key (id_fecha_alta) references dw.d_fecha(id),
	add constraint fk_fecha_baja foreign key (id_fecha_baja) references dw.d_fecha(id),
	add constraint fk_subtributo foreign key (id_subtributo) references dw.d_subtributo(id),
	add constraint fk_tasa foreign key (id_tasa) references dw.d_tasa(id),
	add constraint fk_tipo_tasa foreign key (id_tipo_tasa) references dw.d_tipo_tasa(id)

 -- ##################################################################################
--47-Tipo valor
ALTER TABLE stg.valor_concepto_medico ADD COLUMN id_valor int2;

BEGIN TRANSACTION;
	UPDATE stg.valor_concepto_medico SET id_valor =
		CASE WHEN tipo = 'POR_EDAD' THEN 1
			 WHEN tipo = 'COMUN' THEN 2
		END;
COMMIT TRANSACTION;

DROP TABLE IF EXISTS dw.d_tipo_valor CASCADE;

CREATE TABLE dw.d_tipo_valor(
	id int2 PRIMARY KEY,
	nombre varchar(60)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_tipo_valor VALUES (1, 'POR_EDAD'), (2,'COMUN');
COMMIT TRANSACTION;	
-- ##################################################################################
--48-valor 

DROP TABLE IF EXISTS dw.d_valor CASCADE;

CREATE TABLE dw.d_valor(
	id int4 PRIMARY KEY
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_valor
		SELECT id FROM stg.valor_concepto_medico;
COMMIT TRANSACTION;  
--##################################################################################
--49-Concepto medico
 
DROP TABLE IF EXISTS dw.d_concepto_medico CASCADE;

CREATE TABLE dw.d_concepto_medico(
	id int4 PRIMARY KEY,
	nombre varchar(120)
);

BEGIN TRANSACTION;
	INSERT INTO dw.d_concepto_medico
		SELECT id, nombre_concepto_medico FROM stg.concepto_medico;
COMMIT TRANSACTION;
 
--##################################################################################
--50-Actualizacion concepto medico
 
DROP TABLE IF EXISTS dw.h_actualizacion_concepto_medico CASCADE;

CREATE TABLE dw.h_actualizacion_concepto_medico(
	id_concepto_medico int4,
	id_valor int4,
	id_tipo_valor int4,
	edad_desde int2,
	edad_hasta int2,
	importe int4
);

BEGIN TRANSACTION;
	INSERT INTO dw.h_actualizacion_concepto_medico
		SELECT 	c.id, v.id, v.id_valor, v.edad_desde, v.edad_hasta, v.importe 
		FROM stg.concepto_medico c INNER JOIN stg.valor_concepto_medico v
		ON c.id = v.id_concepto;
COMMIT TRANSACTION;

ALTER TABLE dw.h_actualizacion_concepto_medico
	add constraint fk_concepto_medico foreign key (id_concepto_medico) references dw.d_concepto_medico(id),
	add constraint fk_valor foreign key (id_valor) references dw.d_valor(id),
	add constraint fk_tipo_valor foreign key (id_tipo_valor) references dw.d_tipo_valor(id)

--##################################################################################
--51-Liquidacion


DROP TABLE IF EXISTS dw.h_liquidacion;

CREATE TABLE dw.h_liquidacion(
	id_liquidacion int4,
	id_tipo_pago int4,
	id_tipo_liquidacion int4,
	id_concepto_medico int4,
	id_subtributo int4,
	id_solicitud int4,
	id_fecha int8,
	id_localidad_solicitud int4,
	id_usuario_receptor int4,
	id_tipo_solicitud int4,
	id_tipo_gestion int4,
	id_licencia int4,
	id_actor int4, ---
	id_tipo_domicilio int4,
	id_localidad int4,
	id_tipo_persona_juridica int4,
	id_ocupacion int4,
	id_tipo_actor int4,
	id_tipo_documento int4,
	id_estado_civil int4,
	id_sexo int4,
	id_donante_organos int4,
	id_factor_sanguineo int4,
	id_grupo_sanguineo int4,
	id_identidad_genero int4,
	id_rol int4,
	pagada bool,
	cantidad int4,
	importe int4
);

BEGIN TRANSACTION;    
	INSERT
		INTO dw.h_liquidacion
		SELECT 
			l.id, l.id_tipo_pago, l.id_tipo_liquidacion, d.id_concepto, d.id_subtributo, s.id, to_char(l.fecha,'yyyymmdd')::int,
			s.id_localidad, s.id_usuario_receptor, s.id_tipo, c.id_tipo_gestion, c.id_clase , a.id ,
			da.id_tipo_domicilio, da.id_localidad, a.id_tipo_persona_juridica, a.id_ocupacion, a.id_tipo_actor,
			a.id_tipo_documento, a.id_Estado_civil, a.id_sexo, a.id_donante_organos, a.id_factor_sanguineo,
			a.id_grupo_sanguineo, a.id_identidad_genero, r.id, l.pagada, d.cantidad, d.importe
			FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c ON
			s.id = c.id_solicitud INNER JOIN stg.actor a ON s.id_persona = a.id LEFT JOIN stg.direccion_actor da ON a.id = da.id_actor
			LEFT JOIN stg.rol r ON a.id = r.id_actor INNER JOIN stg.liquidacion_solicitud_licencia_conductor l ON
			s.id = l.id_solicitud INNER JOIN stg.detalle_liquidacion_solicitud_licencia_conductor d ON l.id = d.id_liquidacion;
COMMIT TRANSACTION;   

-- INTEGRIDAD
id_liquidacion int4,
	id_tipo_pago int4,
	id_tipo_liquidacion int4,
	id_concepto_medico int4,
	id_subtributo int4,
	
alter table dw.h_liquidacion
  add constraint fk_tipo_pago foreign key (id_tipo_pago) references dw.d_tipo_pago(id),
  add constraint fk_tipo_liquidacion foreign key (id_tipo_liquidacion) references dw.d_tipo_liquidacion(id),
  add constraint fk_concepto_medico foreign key (id_concepto_medico) references dw.d_concepto_medico(id),
  add constraint fk_subtributo foreign key (id_subtributo) references dw.d_subtributo(id),
  add constraint fk_solicitud foreign key (id_solicitud) references dw.d_solicitud(id),
  add constraint fk_fecha foreign key (id_fecha) references dw.d_fecha(id),
  add constraint fk_localidad_solicitud foreign key (id_localidad_solicitud) references dw.d_localidad(id),
  add constraint fk_usuario_receptor foreign key (id_usuario_receptor) references dw.d_usuario(id),
  add constraint fk_tipo_solicitud foreign key (id_tipo_solicitud) references dw.d_tipo_solicitud(id),
  add constraint fk_tipo_gestion foreign key (id_tipo_gestion) references dw.d_tipo_gestion(id),
  add constraint fk_licencia foreign key (id_licencia) references dw.d_licencia(id),
  add constraint fk_actor foreign key (id_actor) references dw.d_actor(id),
  add constraint fk_tipo_domicilio foreign key (id_tipo_domicilio) references dw.d_tipo_domicilio(id),
  add constraint fk_localidad foreign key (id_localidad) references dw.d_localidad(id),
  add constraint fk_tipo_persona_juridica foreign key (id_tipo_persona_juridica) references dw.d_tipo_persona_juridica(id),
  add constraint fk_ocupacion foreign key (id_ocupacion) references dw.d_ocupacion(id),
  add constraint fk_tipo_actor foreign key (id_tipo_actor) references dw.d_tipo_actor(id),
  add constraint fk_tipo_documento foreign key (id_tipo_documento) references dw.d_tipo_documento(id),
  add constraint fk_estado_civil foreign key (id_estado_civil) references dw.d_estado_civil(id),
  add constraint fk_sexo foreign key (id_sexo) references dw.d_sexo(id),
  add constraint fk_donante_organos foreign key (id_donante_organos) references dw.d_donante_organos(id),
  add constraint fk_factor_sanguineo foreign key (id_factor_sanguineo) references dw.d_factor_sanguineo(id),
  add constraint fk_grupo_sanguineo foreign key (id_grupo_sanguineo) references dw.d_grupo_sanguineo(id),
  add constraint fk_identidad_genero foreign key (id_identidad_genero) references dw.d_identidad_genero(id),
  add constraint fk_rol foreign key (id_rol) references dw.d_rol(id);


 
 
 
 
 
 SELECT DISTINCT importe, count(*) FROM stg.tasa_actuacion_administrativa taa
 GROUP BY importe
 
 
 

-- ##################################################################################
--24-Charla


SELECT count(*) FROM stg.solicitud_licencia_conductor_clase
WHERE fecha_practico IS NOT NULL
-- ##################################################################################
--24-Charla
	 SELECT * FROM stg.estado_solicitud_licencia_conductor
WHERE item = 1 AND tipo != 'PRESENTADA'
	 SELECT * FROM stg.estado_solicitud_licencia_conductor
WHERE id_solicitud = 55159601

	 
SELECT * FROM stg.solicitud_licencia_conductor slc 
	 
SELECT * FROM solicitud 
	 
SELECT s.id, count(c.id) n FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c
	ON s.id = c.id_solicitud 
    GROUP BY s.id
    ORDER BY n DESC
    
SELECT count(*) FROM stg.solicitud_licencia_conductor s INNER JOIN stg.solicitud_licencia_conductor_clase c
	ON s.id = c.id_solicitud 
     
