SELECT * FROM feedback

-- Creación de tabla
CREATE TABLE UserFeedback (
    number INT,
    userName VARCHAR(100),
    content TEXT,
    score INT,
    thumbsUpCount INT,
    at DATETIME
);

-- Agrupación de puntajes con datos de me gustas y
WITH total_registros AS (
    SELECT 
        COUNT(*) AS total
    FROM 
        feedback
)
SELECT 
    puntaje as 'Puntaje', 
    COUNT(*) AS 'Total',
    SUM(me_gusta) AS 'Cantidad de me gustas',
    FORMAT((COUNT(*) * 100.0) / (SELECT total FROM total_registros), 'N2') AS 'Porcentaje (%)'
FROM 
    feedback
GROUP BY 
    puntaje
ORDER BY 
    puntaje;


CREATE PROCEDURE ObtenerTendenciaValoraciones
AS
BEGIN
    -- Media (Promedio) del Puntaje
    SELECT 
        AVG(puntaje) AS promedio_puntaje
    FROM 
        feedback;

    -- Mediana del Puntaje
    SELECT 
        AVG(puntaje) AS mediana_puntaje
    FROM (
        SELECT 
            puntaje
        FROM 
            feedback
        ORDER BY 
            puntaje
        OFFSET ((SELECT COUNT(*) FROM feedback) - 1) / 2 ROWS
        FETCH NEXT 2 ROWS ONLY
    ) AS subquery;

    -- Moda del Puntaje
    SELECT TOP 1
        puntaje,
        COUNT(*) AS frecuencia
    FROM 
        feedback
    GROUP BY 
        puntaje
    ORDER BY 
        frecuencia DESC;

    -- Evolución del Puntaje a lo Largo del Tiempo
    SELECT 
        CAST(fecha AS DATE) AS fecha,  -- Agrupa por día; ajusta según el período deseado
        AVG(puntaje) AS promedio_puntaje
    FROM 
        feedback
    GROUP BY 
        CAST(fecha AS DATE)
    ORDER BY 
        fecha;
END;


EXEC ObtenerTendenciaValoraciones