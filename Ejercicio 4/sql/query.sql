CREATE TABLE centro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255),
	sexo BIT,
    ingresos DECIMAL(18, 2),
    promedio_visitas DECIMAL(18, 2),
    edad INT,
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT
);

CREATE TABLE escalon (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255),
	sexo BIT,
    ingresos DECIMAL(18, 2),
    promedio_visitas DECIMAL(18, 2),
    edad INT,
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT
);

CREATE TABLE santa_tecla (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255),
	sexo BIT,
    ingresos DECIMAL(18, 2),
    promedio_visitas DECIMAL(18, 2),
    edad INT,
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT
);

/* Consultas */

-- Conteo por preferencias
CREATE FUNCTION ConteoPorGrupo (@Separado BIT)
RETURNS @Resultado TABLE
(
    Tabla NVARCHAR(50),
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT,
    cantidad_personas INT
)
AS
BEGIN
    IF @Separado = 1
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            'centro' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            COUNT(*) AS cantidad_personas
        FROM 
            centro
        GROUP BY 
            sauna, masaje, hidro, yoga;

        INSERT INTO @Resultado
        SELECT 
            'santa_tecla' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            COUNT(*) AS cantidad_personas
        FROM 
            santa_tecla
        GROUP BY 
            sauna, masaje, hidro, yoga;

        INSERT INTO @Resultado
        SELECT 
            'escalon' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            COUNT(*) AS cantidad_personas
        FROM 
            escalon
        GROUP BY 
            sauna, masaje, hidro, yoga;
    END
    ELSE
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            'Unida' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            COUNT(*) AS cantidad_personas
        FROM 
            (
                SELECT * FROM centro
                UNION ALL
                SELECT * FROM santa_tecla
                UNION ALL
                SELECT * FROM escalon
            ) AS Unida
        GROUP BY 
            sauna, masaje, hidro, yoga;
    END

    RETURN;
END;

-- Uso
SELECT * FROM ConteoPorGrupo(0); 
SELECT * FROM ConteoPorGrupo(1);

--- Promedio por grupo
CREATE FUNCTION PromedioPorGrupo (@Separado BIT)
RETURNS @Resultado TABLE
(
    Tabla NVARCHAR(50),
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT,
    promedio_ingresos DECIMAL(18, 2),
    promedio_edad DECIMAL(18, 2)
)
AS
BEGIN
    IF @Separado = 1
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            'centro' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            AVG(ingresos) AS promedio_ingresos,
            AVG(edad) AS promedio_edad
        FROM 
            centro
        GROUP BY 
            sauna, masaje, hidro, yoga;

        INSERT INTO @Resultado
        SELECT 
            'santa_tecla' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            AVG(ingresos) AS promedio_ingresos,
            AVG(edad) AS promedio_edad
        FROM 
            santa_tecla
        GROUP BY 
            sauna, masaje, hidro, yoga;

        INSERT INTO @Resultado
        SELECT 
            'escalon' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            AVG(ingresos) AS promedio_ingresos,
            AVG(edad) AS promedio_edad
        FROM 
            escalon
        GROUP BY 
            sauna, masaje, hidro, yoga;
    END
    ELSE
    BEGIN
        INSERT INTO @Resultado
        SELECT 
            'Unida' AS Tabla,
            sauna,
            masaje,
            hidro,
            yoga,
            AVG(ingresos) AS promedio_ingresos,
            AVG(edad) AS promedio_edad
        FROM 
            (
                SELECT * FROM centro
                UNION ALL
                SELECT * FROM santa_tecla
                UNION ALL
                SELECT * FROM escalon
            ) AS Unida
        GROUP BY 
            sauna, masaje, hidro, yoga;
    END

    RETURN;
END;


-- Consultas
SELECT * FROM PromedioPorGrupo(0);
SELECT * FROM PromedioPorGrupo(1);


-- Conteo por actividad

CREATE FUNCTION ConteoPorActividad (@Separado BIT)
RETURNS @Resultado TABLE
(
    Tabla NVARCHAR(50),
    Actividad NVARCHAR(50),
    personas_actividad INT
)
AS
BEGIN
    IF @Separado = 1
    BEGIN
        -- Sauna
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Sauna' AS Actividad, COUNT(*) AS personas_actividad 
        FROM centro WHERE sauna = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Sauna' AS Actividad, COUNT(*) 
        FROM santa_tecla WHERE sauna = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Sauna' AS Actividad, COUNT(*) 
        FROM escalon WHERE sauna = 1;

        -- Masaje
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Masaje' AS Actividad, COUNT(*) 
        FROM centro WHERE masaje = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Masaje' AS Actividad, COUNT(*) 
        FROM santa_tecla WHERE masaje = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Masaje' AS Actividad, COUNT(*) 
        FROM escalon WHERE masaje = 1;

        -- Hidro
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Hidro' AS Actividad, COUNT(*) 
        FROM centro WHERE hidro = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Hidro' AS Actividad, COUNT(*) 
        FROM santa_tecla WHERE hidro = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Hidro' AS Actividad, COUNT(*) 
        FROM escalon WHERE hidro = 1;

        -- Yoga
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Yoga' AS Actividad, COUNT(*) 
        FROM centro WHERE yoga = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Yoga' AS Actividad, COUNT(*) 
        FROM santa_tecla WHERE yoga = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Yoga' AS Actividad, COUNT(*) 
        FROM escalon WHERE yoga = 1;
    END
    ELSE
    BEGIN
        -- Sauna
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Sauna' AS Actividad, COUNT(*) AS personas_actividad 
        FROM 
            (
                SELECT * FROM centro WHERE sauna = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE sauna = 1
                UNION ALL
                SELECT * FROM escalon WHERE sauna = 1
            ) AS Unida;

        -- Masaje
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Masaje' AS Actividad, COUNT(*) 
        FROM 
            (
                SELECT * FROM centro WHERE masaje = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE masaje = 1
                UNION ALL
                SELECT * FROM escalon WHERE masaje = 1
            ) AS Unida;

        -- Hidro
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Hidro' AS Actividad, COUNT(*) 
        FROM 
            (
                SELECT * FROM centro WHERE hidro = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE hidro = 1
                UNION ALL
                SELECT * FROM escalon WHERE hidro = 1
            ) AS Unida;

        -- Yoga
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Yoga' AS Actividad, COUNT(*) 
        FROM 
            (
                SELECT * FROM centro WHERE yoga = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE yoga = 1
                UNION ALL
                SELECT * FROM escalon WHERE yoga = 1
            ) AS Unida;
    END

    RETURN;
END;

-- Consultas
SELECT * FROM ConteoPorActividad(0);
SELECT * FROM ConteoPorActividad(1);

-- Distribución por la edad
CREATE FUNCTION DistribucionEdadPorActividad (@Separado BIT)
RETURNS @Resultado TABLE
(
    Tabla NVARCHAR(50),
    Actividad NVARCHAR(50),
    promedio_edad DECIMAL(18, 2)
)
AS
BEGIN
    IF @Separado = 1
    BEGIN
        -- Sauna
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Sauna' AS Actividad, AVG(edad) AS promedio_edad 
        FROM centro WHERE sauna = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Sauna' AS Actividad, AVG(edad) 
        FROM santa_tecla WHERE sauna = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Sauna' AS Actividad, AVG(edad) 
        FROM escalon WHERE sauna = 1;

        -- Masaje
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Masaje' AS Actividad, AVG(edad) 
        FROM centro WHERE masaje = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Masaje' AS Actividad, AVG(edad) 
        FROM santa_tecla WHERE masaje = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Masaje' AS Actividad, AVG(edad) 
        FROM escalon WHERE masaje = 1;

        -- Hidro
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Hidro' AS Actividad, AVG(edad) 
        FROM centro WHERE hidro = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Hidro' AS Actividad, AVG(edad) 
        FROM santa_tecla WHERE hidro = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Hidro' AS Actividad, AVG(edad) 
        FROM escalon WHERE hidro = 1;

        -- Yoga
        INSERT INTO @Resultado
        SELECT 'centro' AS Tabla, 'Yoga' AS Actividad, AVG(edad) 
        FROM centro WHERE yoga = 1;

        INSERT INTO @Resultado
        SELECT 'santa_tecla' AS Tabla, 'Yoga' AS Actividad, AVG(edad) 
        FROM santa_tecla WHERE yoga = 1;

        INSERT INTO @Resultado
        SELECT 'escalon' AS Tabla, 'Yoga' AS Actividad, AVG(edad) 
        FROM escalon WHERE yoga = 1;
    END
    ELSE
    BEGIN
        -- Sauna
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Sauna' AS Actividad, AVG(edad) AS promedio_edad 
        FROM 
            (
                SELECT * FROM centro WHERE sauna = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE sauna = 1
                UNION ALL
                SELECT * FROM escalon WHERE sauna = 1
            ) AS Unida;

        -- Masaje
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Masaje' AS Actividad, AVG(edad) 
        FROM 
            (
                SELECT * FROM centro WHERE masaje = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE masaje = 1
                UNION ALL
                SELECT * FROM escalon WHERE masaje = 1
            ) AS Unida;

        -- Hidro
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Hidro' AS Actividad, AVG(edad) 
        FROM 
            (
                SELECT * FROM centro WHERE hidro = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE hidro = 1
                UNION ALL
                SELECT * FROM escalon WHERE hidro = 1
            ) AS Unida;

        -- Yoga
        INSERT INTO @Resultado
        SELECT 'Unida' AS Tabla, 'Yoga' AS Actividad, AVG(edad) 
        FROM 
            (
                SELECT * FROM centro WHERE yoga = 1
                UNION ALL
                SELECT * FROM santa_tecla WHERE yoga = 1
                UNION ALL
                SELECT * FROM escalon WHERE yoga = 1
            ) AS Unida;
    END

    RETURN;
END;

-- Consultas
SELECT * FROM DistribucionEdadPorActividad(0);
SELECT * FROM DistribucionEdadPorActividad(1);

-- Combinaciones
CREATE FUNCTION CombinacionMasComun (@Separado BIT)
RETURNS @Resultado TABLE
(
    Tabla NVARCHAR(50),
    sauna BIT,
    masaje BIT,
    hidro BIT,
    yoga BIT,
    cantidad_personas INT
)
AS
BEGIN
    IF @Separado = 1
    BEGIN
        INSERT INTO @Resultado
        SELECT TOP 1 
            'centro' AS Tabla, 
            sauna, 
            masaje, 
            hidro, 
            yoga, 
            COUNT(*) AS cantidad_personas
        FROM centro
        GROUP BY sauna, masaje, hidro, yoga
        ORDER BY COUNT(*) DESC;

        INSERT INTO @Resultado
        SELECT TOP 1 
            'santa_tecla' AS Tabla, 
            sauna, 
            masaje, 
            hidro, 
            yoga, 
            COUNT(*) 
        FROM santa_tecla
        GROUP BY sauna, masaje, hidro, yoga
        ORDER BY COUNT(*) DESC;

        INSERT INTO @Resultado
        SELECT TOP 1 
            'escalon' AS Tabla, 
            sauna, 
            masaje, 
            hidro, 
            yoga, 
            COUNT(*)
        FROM escalon
        GROUP BY sauna, masaje, hidro, yoga
        ORDER BY COUNT(*) DESC;
    END
    ELSE
    BEGIN
        INSERT INTO @Resultado
        SELECT TOP 1 
            'Unida' AS Tabla, 
            sauna, 
            masaje, 
            hidro, 
            yoga, 
            COUNT(*) AS cantidad_personas
        FROM 
            (
                SELECT * FROM centro
                UNION ALL
                SELECT * FROM santa_tecla
                UNION ALL
                SELECT * FROM escalon
            ) AS Unida
        GROUP BY sauna, masaje, hidro, yoga
        ORDER BY COUNT(*) DESC;
    END

    RETURN;
END;

-- Consultas
SELECT * FROM CombinacionMasComun(0);
SELECT * FROM CombinacionMasComun(1);