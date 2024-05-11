-----------------------------------------------------------------------------
--------------------------------CORRECIONES----------------------------------
-----------------------------------------------------------------------------

CREATE TABLE actor.PERSONA_FISICA(
	ID INT2 NOT NULL,
	ID_ACTOR INT2 NOT NULL,
	ID_OCUPACION INT2 NULL,
	DOCUMENTO_IDENTIDAD_TIPO VARCHAR(1) NOT NULL,
	DOCUMENTO_IDENTIDAD_NUMERO INT4 NOT NULL,
	APELLIDO VARCHAR(255) NOT NULL,
	FECHA_NACIMIENTO DATE NOT NULL,
	NOMBRE VARCHAR(255) NOT NULL,
	MOVIL_PRINCIPAL VARCHAR(255) NULL,
	SEXO CHAR(1) NOT NULL,
	APELLIDO_MATERNO VARCHAR(255) NULL,
	FACTOR_SANGUINEO VARCHAR(255) NULL,
	GRUPO_SANGUINEO VARCHAR(255) NULL,
	DONANTE_ORGANOS VARCHAR(255) NULL,
	EMAIL_PERSONAL VARCHAR(255) NULL,
	ESTADO_CIVIL CHAR(1) NOT NULL,
	CONSTRAINT pk_persona_fisica PRIMARY KEY(ID),	
	CONSTRAINT uk_persona_fisica_1 UNIQUE(ID_ACTOR),
	CONSTRAINT uk_persona_fisica_2 UNIQUE(DOCUMENTO_IDENTIDAD_TIPO, DOCUMENTO_IDENTIDAD_NUMERO),
	CONSTRAINT fk_persona_fisica_actor FOREIGN KEY(ID_ACTOR)
		REFERENCES actor.ACTOR(ID),
	CONSTRAINT fk_persona_fisica_ocupacion FOREIGN KEY(ID_OCUPACION)
		REFERENCES actor.OCUPACION(ID),
	CONSTRAINT check_persona_fisica
	CHECK (ESTADO_CIVIL IN ('S', 'C', 'E', 'D', 'V', 'N'))
);

-----------------------------------------------------------------------------
----------------------------Creacion de Indices------------------------------
-----------------------------------------------------------------------------

-----Tabla actor-----

CREATE INDEX actor_pais_idx ON actor.actor(id_pais);

-----Tabla persona_fisica-----

CREATE INDEX persona_fisica_ocupacion_idx ON actor.persona_fisica (id_ocupacion);

-----Tabla persona_juridica-----

CREATE INDEX persona_juridica_tipo_idx ON actor.persona_juridica (id_tipo);

-----Tabla integra_persona_juridica-----

DROP INDEX IF EXISTS integra_persona_juridica_id
CREATE INDEX integra_persona_juridica_id ON actor.integra_persona_juridica(id_persona_fisica);

CREATE INDEX integra_persona_juridica_funcion ON actor.integra_persona_juridica(id_funcion);

-----Tabla integra_organismo-----

CREATE INDEX integra_organismo_id ON actor.integra_organismo (id_persona_fisica);

CREATE INDEX integra_organismo_funcion ON actor.integra_organismo (id_funcion);

-----Tabla localidad-----

CREATE INDEX localidad_departamento_idx ON actor.localidad(id_departamento);

CREATE INDEX localidad_provincia_idx ON actor.localidad(id_provincia_estado);

-----Tabla direccion_actor-----

CREATE INDEX direccion_actor_localidad_idx ON actor.direccion_actor(id_localidad);

-----Tabla solicitud_licencia_conductor-----

CREATE INDEX solicitud_LC_persona_fisica_idx ON solicitud.solicitud_licencia_conductor(id_persona_fisica);

CREATE INDEX solicitud_LC_localidad_idx ON solicitud.solicitud_licencia_conductor(id_localidad);

CREATE INDEX solicitud_LC_usuario_idx ON solicitud.solicitud_licencia_conductor(id_usuario);

CREATE INDEX solicitud_LC_estado_idx ON solicitud.solicitud_licencia_conductor(id_estado);

CREATE INDEX solicitud_LC_motivo_rechazo_idx ON solicitud.solicitud_licencia_conductor(id_motivo_rechazo);

-----Tabla liquidacion_solicitud_licencia_conductor-----

CREATE INDEX liquidacion_solicitud_LC_idx ON solicitud.liquidacion_solicitud_licencia_conductor(id_solicitud_licencia_conductor);

CREATE INDEX liquidacion_usuario_idx ON solicitud.liquidacion_solicitud_licencia_conductor(id_usuario);

-----Tabla detalle_liquidacion_solicitud_licencia_conductor-----

CREATE INDEX detalle_subtributo_idx ON solicitud.detalle_liquidacion_solicitud_licencia_conductor(id_subtributo);

CREATE INDEX detalle_concepto_medico_idx ON solicitud.detalle_liquidacion_solicitud_licencia_conductor(id_concepto_medico);

-----Tabla clase_licencia_conducir_requerida-----

CREATE INDEX clase_LC_requerida_idx ON solicitud.clase_licencia_conducir_requerida(id_clase_licencia_dependiente);

-----Tabla solicitud_licencia_conducir_clase-----

CREATE INDEX solicitud_LC_clase_motivo_idx ON solicitud.solicitud_licencia_conducir_clase(id_motivo_rechazo);

CREATE INDEX solicitud_LC_clase_idx ON solicitud.solicitud_licencia_conducir_clase(id_clase_licencia);




