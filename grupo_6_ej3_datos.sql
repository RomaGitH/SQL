-----INSERCION DE DATOS-----

-----------------------------------------------------------------------------
--------------------------------Esquema actor--------------------------------
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 1-------------------------------
-----------------------------------------------------------------------------

-----Tabla FUNCION-----

INSERT INTO actor.FUNCION (ID, CODIGO_FUNCION, NOMBRE_FUNCION)
VALUES(1, 231, 'Ñoqui');

-----Tabla OCUPACION-----

INSERT INTO actor.OCUPACION (ID, CODIGO_OCUPACION, NOMBRE_OCUPACION, NOMBRE_OCUPACION_RESUMIDO)
VALUES(1, 312, 'Orador','Sarasear');

-----Tabla PAIS-----

INSERT INTO actor.PAIS (ID, CODIGO_PAIS, NOMBRE_PAIS, NOMBRE_PAIS_RESUMIDO, GENTILICIO)
VALUES(1, 'ARG', 'Republica Argentina', 'Argentina', 'Argentino');

-----Tabla TIPO_PERSONA_JURIDICA-----

INSERT INTO actor.TIPO_PERSONA_JURIDICA (ID, CODIGO_TIPO_PERSONA_JURIDICA, NOMBRE_TIPO_PERSONA_JURIDICA,
NOMBRE_TIPO_PERSONA_JURIDICA_RESUMIDO)
VALUES(1, 444, 'SOCIEDAD ANONIMA','SA');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 2-------------------------------
-----------------------------------------------------------------------------

-----Tabla PROVINCIA_ESTADO-----

INSERT INTO actor.PROVINCIA_ESTADO (ID, ID_PAIS, CODIGO_PROVINCIA, NOMBRE_PROVINCIA, NOMBRE_PROVINCIA_RESUMIDO)
VALUES(13, 1, 23, 'SALTA', 'SALTA');

-----Tabla ACTOR-----

INSERT INTO actor.ACTOR(ID, CODIGO_ACTOR, FECHA_ALTA)
VALUES(1, 1253, '2003-02-11');


INSERT INTO actor.ACTOR(ID, CODIGO_ACTOR, FECHA_ALTA)
VALUES(2, 453, '2011-02-11');

INSERT INTO actor.ACTOR(ID, CODIGO_ACTOR, FECHA_ALTA)
VALUES(3, 253, '2001-02-11');



-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 3-------------------------------
-----------------------------------------------------------------------------


-----Tabla DEPARTAMENTO-----

INSERT INTO actor.DEPARTAMENTO (ID, ID_PROVINCIA_ESTADO, SECUENCIA, CODIGO_DEPARTAMENTO, NOMBRE_DEPARTAMENTO, NOMBRE_DEPARTAMENTO_RESUMIDO)
VALUES(3, 13, 1300, 22, 'JUDEA', 'JUDEA');

-----Tabla ORGANISMO-----

INSERT INTO actor.ORGANISMO(ID, ID_ACTOR, NOMBRE_ORGANISMO, SIGLA)
VALUES(1, 1, 'FONDO MONETARIO INTERNACIONAL', 'FMI');

-----Tabla PERSONA_FISICA-----

INSERT INTO actor.PERSONA_FISICA(ID, ID_ACTOR, DOCUMENTO_IDENTIDAD_TIPO, DOCUMENTO_IDENTIDAD_NUMERO, APELLIDO, FECHA_NACIMIENTO,
	NOMBRE, SEXO, ESTADO_CIVIL)
VALUES(1, 2, 'A', 28429421, 'Peron', '2002-01-04', 'Juan Domingo', 'M', 'S');

-----Tabla PERSONA_JURIDICA-----

INSERT INTO actor.PERSONA_JURIDICA(ID, ID_ACTOR, ID_TIPO_PERSONA_JURIDICA, NOMBRE_FANTASIA, RAZON_SOCIAL)
VALUES(1, 3, 1, 'FLUVIALES', 'FLUVIALES S.R.L');

-----Tabla ROL-----

INSERT INTO actor.ROL(ID, ID_ACTOR, TIPO_ROL, CODIGO_ROL)
VALUES(1, 2, 'MEDICO', 12);

-----Tabla USUARIO-----

INSERT INTO actor.USUARIO(ID, ID_USUARIO, APELLIDO_NOMBRE, FECHA_ALTA)
VALUES(1, '4ads24', 'Yrigoyen Hipolito',  '2005-12-25');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 4-------------------------------
-----------------------------------------------------------------------------

-----Tabla INTEGRA_ORGANISMO-----

INSERT INTO actor.INTEGRA_ORGANISMO(ID, ID_PERSONA_FISICA, ID_ORGANISMO, ID_FUNCION, SECUENCIA, FECHA_ALTA,
	FECHA_BAJA)
VALUES(1, 1, 1, 1, 123, '2016-08-25', '2017-09-30');

-----Tabla INTEGRA_PERSONA_JURIDICA-----

INSERT INTO actor.INTEGRA_PERSONA_JURIDICA(ID, ID_PERSONA_JURIDICA, ID_PERSONA_FISICA, ID_FUNCION, SECUENCIA, FECHA_ALTA,
	FECHA_BAJA)
VALUES(1, 1, 1, 1, 2414, '2011-08-24', '2016-09-14');

INSERT INTO actor.INTEGRA_PERSONA_JURIDICA(ID, ID_PERSONA_JURIDICA, ID_PERSONA_FISICA, ID_FUNCION, SECUENCIA, FECHA_ALTA)
VALUES(2, 1, 1, 1, 2415, '2017-11-22');

-----Tabla LOCALIDAD-----

INSERT INTO actor.LOCALIDAD (ID, ID_DEPARTAMENTO ,ID_PROVINCIA_ESTADO, CODIGO_LOCALIDAD, NOMBRE_LOCALIDAD, NOMBRE_LOCALIDAD_RESUMIDO)
VALUES(1, 3, 13, 12345, 'JERUSALEM', 'JERUSALEM');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 5-------------------------------
-----------------------------------------------------------------------------


-----Tabla DIRECCION_ACTOR-----
INSERT INTO actor.DIRECCION_ACTOR(ID, ID_ACTOR, SECUENCIA, DOMICILIO, TIPO_DOMICILIO)
VALUES(1, 1 ,2411, 'AUSTRIA 1999', 'PARTICULAR');


-----------------------------------------------------------------------------
----------------------------Esquema solicitud--------------------------------
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 1-------------------------------
-----------------------------------------------------------------------------

-----Tabla CLASE_LICENCIA_CONDUCIR-----

INSERT INTO solicitud.CLASE_LICENCIA_CONDUCIR (ID, CLASE, EDAD_MINIMA, REQUIERE_EXAMEN_PSIQUIATRICO, ES_PROFESIONAL)
VALUES(1, 'B2', 16, TRUE, FALSE);

INSERT INTO solicitud.CLASE_LICENCIA_CONDUCIR (ID, CLASE, EDAD_MINIMA, REQUIERE_EXAMEN_PSIQUIATRICO, ES_PROFESIONAL)
VALUES(2, 'B1', 16, TRUE, FALSE);

-----Tabla CONCEPTO_MEDICO-----

INSERT INTO solicitud.CONCEPTO_MEDICO (ID, CODIGO_CONCEPTO_MEDICO, NOMBRE_CONCEPTO)
VALUES(1, 1, 'Winner');

-----Tabla MOTIVO_RECHAZO-----

INSERT INTO solicitud.MOTIVO_RECHAZO (ID, CODIGO_MOTIVO_RECHAZO, DESCRIPCION_MOTIVO_RECHAZO)
VALUES(1, 1, 'Extranjero');


-----Tabla SUBTRIBUTO-----

INSERT INTO solicitud.SUBTRIBUTO (ID, CODIGO_SUBTRIBUTO, NOMBRE_SUBTRIBUTO)
VALUES(1, 2, 'Aporte Solidario');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 2-------------------------------
-----------------------------------------------------------------------------

-----Tabla CLASE_LICENCIA_CONDUCIR_REQUERIDA-----

INSERT INTO solicitud.CLASE_LICENCIA_CONDUCIR_REQUERIDA (ID, ID_CLASE_LICENCIA, ID_CLASE_LICENCIA_DEPENDIENTE,
	SECUENCIA, TENENCIA_MINIMA)
VALUES(1, 1, 2, 2412, 1);

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 5-------------------------------
-----------------------------------------------------------------------------

-----Tabla SOLICITUD_LICENCIA_CONDUCTOR-----

INSERT INTO solicitud.SOLICITUD_LICENCIA_CONDUCTOR (ID, ID_PERSONA_FISICA, ID_USUARIO, NUMERO, DOMICILIO, FECHA,
	LIBRE_MULTA, CORRESPONDE_CHARLA, CORRESPONDE_PSIQUIATRICO, CORRESPONDE_TEORICO, CORRESPONDE_FISICO,
	TIPO, CALLE, DEPARTAMENTO, NUMERO_PORTAL, PISO, FECHA_VENCIMIENTO)
VALUES(1, 1, 1, 656, 'AVENIDA FABULADOR 2422', '2023-09-20', TRUE, 'NO', 'SI', 'SI', 'SI', 'COMUN',
	'AVENIDA FABULADOR', 'B', '2422', '4', '2023-12-31');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 6-------------------------------
-----------------------------------------------------------------------------

-----Tabla ESTADO_SOLICITUD_LICENCIA_CONDUCTOR-----

INSERT INTO solicitud.ESTADO_SOLICITUD_LICENCIA_CONDUCTOR (ID, ID_SOLICITUD_LICENCIA_CONDUCTOR, ITEM, TIPO, FECHA)
VALUES(1, 1, 21, 'APROBADA', '2023-11-21'); 

-----Tabla LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR-----

INSERT INTO solicitud.LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR(ID, ID_SOLICITUD_LICENCIA_CONDUCTOR, NUMERO, FECHA,
	FECHA_PAGO, FECHA_VENCIMIENTO, IMPORTE_TOTAL, PAGADA, TIPO, TIPO_PAGO)
VALUES(1, 1, 214, '2023-09-20', '2023-11-21', '2024-09-20', 5.50, TRUE, 'TASA_ACTUACION_ADMINISTRATIVA_DIFERENCIAL', 'COMUN');

-----Tabla SOLICITUD_LICENCIA_CONDUCIR_CLASE-----

INSERT INTO solicitud.SOLICITUD_LICENCIA_CONDUCIR_CLASE(ID, ID_SOLICITUD_LICENCIA_CONDUCTOR, ID_CLASE_LICENCIA,
	SECUENCIA, TIPO_GESTION, FECHA_IMPRESION, FECHA_VALIDACION_FINAL, FECHA_ENTREGA, CORRESPONDE_CHARLA, CORRESPONDE_FISICO,
	CORRESPONDE_PSIQUIATRICO, FECHA_PRACTICO, RESULTADO_PRACTICO)
VALUES(1, 1, 1, 4212, 'NUEVO','2023-11-25', '2023-11-22', '2023-12-10','SI', 'NO', 'NO','2023-11-20', 'APROBADO');

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 7-------------------------------
-----------------------------------------------------------------------------

-----Tabla DETALLE_LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR-----

INSERT INTO solicitud.DETALLE_LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR(ID, ID_LIQUIDACION, ID_SUBTRIBUTO, SECUENCIA,
	CANTIDAD, IMPORTE)
VALUES(1, 1, 1, 214, 1, 5.50);
