USE [Ejercicio1]
GO
/****** Object:  StoredProcedure [dbo].[CalcularEstadisticasJugadores]    Script Date: 9/14/2024 2:26:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CalcularEstadisticasJugadores]
AS
BEGIN
    WITH CleanedData AS (
        SELECT 
            Age AS Edad,
            -- Limpiar y convertir Height y Weight a FLOAT
            TRY_CAST(REPLACE(REPLACE(Height, ' cm', ''), ',', '') AS FLOAT) AS HeightCleaned,
            TRY_CAST(REPLACE(REPLACE(Weight, ' kg', ''), ',', '') AS FLOAT) AS WeightCleaned,
            TRY_CAST(Rating AS FLOAT) AS RatingCleaned
        FROM 
            dbo.PlayerName
        WHERE 
            -- Asegurarse de que después de eliminar las unidades, los valores pueden convertirse a números
            TRY_CAST(REPLACE(REPLACE(Height, ' cm', ''), ',', '') AS FLOAT) IS NOT NULL
            AND TRY_CAST(REPLACE(REPLACE(Weight, ' kg', ''), ',', '') AS FLOAT) IS NOT NULL
            AND TRY_CAST(Rating AS FLOAT) IS NOT NULL  -- Asegurarse de que Rating también sea numérico
    )
    -- Calcular las estadísticas
    SELECT 
        Edad,
        ROUND(AVG(HeightCleaned), 2) AS Altura_Promedio_cm,
        ROUND(STDEV(HeightCleaned), 2) AS Desviacion_Estandar_Altura_cm,
        ROUND(AVG(WeightCleaned), 2) AS Peso_Promedio_kg,
        ROUND(STDEV(WeightCleaned), 2) AS Desviacion_Estandar_Peso_kg,
        ROUND(AVG(RatingCleaned), 2) AS Calificacion_Promedio,
        ROUND(STDEV(RatingCleaned), 2) AS Desviacion_Estandar_Calificacion
    FROM 
        CleanedData
    GROUP BY 
        Edad
    ORDER BY 
        Edad;
END;
