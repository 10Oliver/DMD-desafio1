/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Country]
      ,[AveragScore]
      ,[SafetySecurity]
      ,[PersonelFreedom]
      ,[Governance]
      ,[SocialCapital]
      ,[InvestmentEnvironment]
      ,[EnterpriseConditions]
      ,[MarketAccessInfrastructure]
      ,[EconomicQuality]
      ,[LivingConditions]
      ,[Health]
      ,[Education]
      ,[NaturalEnvironment]
      ,[Continente]
  FROM [DWH].[dbo].[COUNTRYS]

--Analizar cuáles países tienen las mejores condiciones de vida
SELECT Country, AveragScore
FROM [DWH].[dbo].[COUNTRYS]
ORDER BY AveragScore DESC;

--Comparar la seguridad y libertad personal por país
SELECT Country, SafetySecurity, PersonelFreedom
FROM [DWH].[dbo].[COUNTRYS]
ORDER BY SafetySecurity DESC, PersonelFreedom DESC;

--Calcular el promedio de estas puntuaciones por continente
SELECT Continente, 
       AVG(AveragScore) AS AvgAveragScore, 
       AVG(SafetySecurity) AS AvgSafetySecurity, 
       AVG(PersonelFreedom) AS AvgPersonelFreedom
FROM [DWH].[dbo].[COUNTRYS]
GROUP BY Continente;
