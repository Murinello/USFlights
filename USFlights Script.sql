USE USAirlineFlights2;

/* 1. Quantitat de registres de la taula de vols */
SELECT COUNT(*) 
AS 'TOTAL flight registries:' 
FROM Flights;

/* 2. Retard promig de sortida i arribada segons l’aeroport origen */
SELECT Origin, AVG(DepDelay) AS 'Departure AVG delay:', AVG(ArrDelay) AS 'Arrival AVG delay:' 
FROM Flights 
GROUP BY 1 ORDER BY 1;

/* 3. Retard promig d’arribada dels vols, per mesos i segons l’aeroport
      origen amb l’ordre de les files */
SELECT Origin, Year AS 'Year', Month AS 'Month', AVG(ArrDelay) AS 'Arrival AVG delay:' 
FROM Flights 
GROUP BY 1, 2, 3 ORDER BY 1, 2, 3;

/* 4. Retard promig d’arribada dels vols, per mesos i segons el nom de la
      ciutat amb l’ordre de les files. */
SELECT City, Year AS 'Year', Month AS 'Month', AVG(ArrDelay) AS 'Arrival AVG delay' 
FROM Flights 
LEFT JOIN USAirports ON Flights.Origin = USAirports.IATA
GROUP BY 1, 2, 3 ORDER BY 1, 2, 3;

/* 5. Les companyies amb més vols cancelats per orden descendent */
SELECT UniqueCarrier AS 'Plane ID', SUM(Cancelled) AS 'Total cancelled flights' 
FROM Flights 
WHERE CancellationCode<>'' 
GROUP BY 1 ORDER BY 2 DESC;

/* 6. L’identificador dels 10 avions que més distància han recorregut
      fent vols */
SELECT TailNum AS 'Plane ID:', SUM(Distance) AS 'Total KM:' 
FROM Flights 
GROUP BY 1 ORDER BY 2 DESC LIMIT 10;

/* 7. Companyies amb un retràs promig major de 10 minuts. */
SELECT Description AS 'Company:', AVG(ArrDelay) AS 'Arrival AVG delay:' 
FROM Carriers 
JOIN Flights ON Carriers.CarrierCode=Flights.UniqueCarrier 
GROUP BY 1 HAVING AVG(ArrDelay)>10 ORDER BY 2 DESC;