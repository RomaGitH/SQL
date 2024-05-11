-----------------------------------------------------------------------------
--------------------------------Script Limpieza-------------------------------
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 7-------------------------------
-----------------------------------------------------------------------------

-----Tabla DETALLE_LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR-----

DELETE FROM solicitud.detalle_liquidacion_solicitud_licencia_conductor;

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 6-------------------------------
-----------------------------------------------------------------------------

-----Tabla ESTADO_SOLICITUD_LICENCIA_CONDUCTOR-----

DELETE FROM solicitud.estado_solicitud_licencia_conductor;

-----Tabla LIQUIDACION_SOLICITUD_LICENCIA_CONDUCTOR-----

DELETE FROM solicitud.liquidacion_solicitud_licencia_conductor;

-----Tabla SOLICITUD_LICENCIA_CONDUCIR_CLASE-----

DELETE FROM solicitud.solicitud_licencia_conducir_clase;


----------------------------------------------------------------------------
--------------------------------Tablas Nivel 5-------------------------------
-----------------------------------------------------------------------------

-----Tabla DIRECCION_ACTOR-----

DELETE FROM actor.direccion_actor;

-----Tabla SOLICITUD_LICENCIA_CONDUCTOR-----

DELETE FROM solicitud.solicitud_licencia_conductor;


-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 4-------------------------------
-----------------------------------------------------------------------------

-----Tabla INTEGRA_ORGANISMO-----

DELETE FROM actor.integra_organismo;

-----Tabla INTEGRA_PERSONA_JURIDICA-----

DELETE FROM actor.integra_persona_juridica;

-----Tabla LOCALIDAD-----

DELETE FROM actor.localidad;

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 3-------------------------------
-----------------------------------------------------------------------------


-----Tabla DEPARTAMENTO-----

DELETE FROM actor.departamento; 

-----Tabla ORGANISMO-----

DELETE FROM actor.organismo;

-----Tabla PERSONA_FISICA-----

DELETE FROM actor.persona_fisica;

-----Tabla PERSONA_JURIDICA-----

DELETE FROM actor.persona_juridica; 

-----Tabla ROL-----

DELETE FROM actor.rol;

-----Tabla USUARIO-----

DELETE FROM actor.usuario;

-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 2-------------------------------
-----------------------------------------------------------------------------

-----Tabla PROVINCIA_ESTADO-----

DELETE FROM actor.provincia_estado;

-----Tabla ACTOR-----

DELETE FROM actor.actor;

-----Tabla CLASE_LICENCIA_CONDUCIR_REQUERIDA-----

DELETE FROM solicitud.clase_licencia_conducir_requerida;


-----------------------------------------------------------------------------
--------------------------------Tablas Nivel 1-------------------------------
-----------------------------------------------------------------------------

-----Tabla FUNCION-----

DELETE FROM actor.funcion;

-----Tabla OCUPACION-----

DELETE FROM actor.ocupacion; 

-----Tabla PAIS-----

DELETE FROM actor.pais;

-----Tabla TIPO_PERSONA_JURIDICA-----

DELETE FROM actor.tipo_persona_juridica;


-----Tabla CLASE_LICENCIA_CONDUCIR-----

DELETE FROM solicitud.clase_licencia_conducir;

-----Tabla CONCEPTO_MEDICO-----

DELETE FROM solicitud.concepto_medico;

-----Tabla MOTIVO_RECHAZO-----

DELETE FROM solicitud.motivo_rechazo;

-----Tabla SUBTRIBUTO-----

DELETE FROM solicitud.subtributo;




	