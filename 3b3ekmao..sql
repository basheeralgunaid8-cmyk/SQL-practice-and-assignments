
  --Problem 5 : Get All Makes that have manufactured more than 12000 Vehicles in years 1950 to 2000
select m.Make AS MakeName,
    COUNT(*) AS TotalVehicles
from VehicleDetails v inner join 
Makes m on v.MakeID=m.MakeID
where Year between 1950 and 2000
group by m.Make 
HAVING count(*)>12000;

--1
SELECT* 
FROM(
select m.Make AS MakeName,
    COUNT(*) AS TotalVehicles
from VehicleDetails v inner join 
Makes m on v.MakeID=m.MakeID
where Year between 1950 and 2000
group by m.Make 
) t
where t.TotalVehicles>12000;

--2
with Makecounts as
(
select m.Make AS MakeName,
    COUNT(*) AS TotalVehicles
from VehicleDetails v inner join 
Makes m on v.MakeID=m.MakeID
where Year between 1950 and 2000
group by m.Make 
)
SELECT *FROM Makecounts 
WHERE TotalVehicles>12000;


--Problem 6: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside

select m.Make AS MakeName,
    COUNT(*) AS TotalVehicles,
    Total=(select count(*) from VehicleDetails)
from VehicleDetails v inner join 
Makes m on v.MakeID=m.MakeID
where Year between 1950 and 2000
group by m.Make 


--Problem 7: Get number of vehicles made between 1950 and 2000 per make and add total vehicles column beside it, then calculate it's percentage

--solutoin 1
 Select*,CAST(NumberOfVehicles AS FLOAT )/CAST(TotalAllVehicles AS FLOAT ) AS Perc from
 (
 select m.Make as MakeName,
 count(*)  NumberOfVehicles,
            (select count(*) from VehicleDetails) as TotalAllVehicles

from VehicleDetails v inner join
Makes m on v.MakeID=m.MakeID
              where Year between 1950 and 2000
                        group by m.Make 
)R1
Order by NumberOfVehicles desc;

--solutoin 2
SELECT 
    m.Make AS MakeName,
    COUNT(*) AS NumberOfVehicles,
    t.TotalAllVehicles,
    Cast (COUNT(*)  as float) / Cast(t.TotalAllVehicles as float) AS Percentage
FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID
CROSS JOIN (
    SELECT COUNT(*) AS TotalAllVehicles
    FROM VehicleDetails
   
) t
WHERE v.Year BETWEEN 1950 AND 2000
GROUP BY m.Make, t.TotalAllVehicles
ORDER BY NumberOfVehicles DESC;

--solution 3
SELECT 
    m.Make AS MakeName,
    COUNT(*) AS NumberOfVehicles,
     SUM(COUNT(*))OVER() AS  TotalAllVehicles ,
   CAST(COUNT(*) AS FLOAT)/CAST (SUM(COUNT(*))OVER() AS FLOAT)
     FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID
WHERE Year BETWEEN 1950 AND 2000
GROUP BY m.Make
ORDER BY NumberOfVehicles DESC;

--Problem 8: Get Make, FuelTypeName and Number of Vehicles per FuelType per Make
 SELECT
 m.Make as MakeName,
 f.FuelTypeName as FuelName,
  COUNT(*) AS NumberOfVehicles
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID inner join
FuelTypes f ON v.FuelTypeID=f.FuelTypeID
WHERE Year BETWEEN 1950 AND 2000
GROUP BY m.Make,f.FuelTypeName
ORDER BY m.Make ASC;

--  Problem 9: Get all vehicles that runs with GAS
SELECT 
  m.Make as MakeName,
 f.FuelTypeName as FuelName
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID inner join
FuelTypes f ON v.FuelTypeID=f.FuelTypeID
WHERE (f.FuelTypeName=N'GAS')


--Problem 10: Get all Makes that runs with GAS

SELECT 
 distinct m.Make as MakeName,
 f.FuelTypeName as FuelName
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID inner join
FuelTypes f ON v.FuelTypeID=f.FuelTypeID
WHERE (f.FuelTypeName=N'GAS')

--  Problem 11: Get Total Makes that runs with GAS
     
SELECT DISTINCT COUNT(*)  AS NumberOfVehicles  FROM
(

SELECT DISTINCT
 m.Make as MakeName,
 f.FuelTypeName as FuelName
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID inner join
FuelTypes f ON v.FuelTypeID=f.FuelTypeID
WHERE (f.FuelTypeName=N'GAS')
GROUP BY m.Make,f.FuelTypeName
)R1

--Problem 12: Count Vehicles by make and order them by NumberOfVehicles from high to low.

SELECT  
 m.Make as MakeName,
 Count(*) as NumberOfVehicle 
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID 
GROUP BY m.Make
order by NumberOfVehicle desc;


--Problem 13: Get all Makes/Count Of Vehicles that manufactures more than 20K Vehicles
--SOLUTION 1
Select *FROM 
(
SELECT  
 m.Make as MakeName,
 Count(*) as NumberOfVehicle 
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID 
GROUP BY m.Make

)R1
WHERE R1.NumberOfVehicle>20000;

--SOLUTION 2

SELECT  
 m.Make as MakeName,
 Count(*) as NumberOfVehicle 
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID 
GROUP BY m.Make
HAVING COUNT(*)>20000;

--SOLUTION 3
WITH MakesCountVehicle as
(
SELECT  
 m.Make as MakeName,
 Count(*) as NumberOfVehicle 
 FROM VehicleDetails v
JOIN Makes m ON v.MakeID = m.MakeID 
GROUP BY m.Make
)
SELECT *FROM MakesCountVehicle
WHERE NumberOfVehicle>20000;


-- Problem 14: Get all Makes with make starts with 'B'
SELECT Makes.Make
FROM Makes
WHERE Makes.Make LIKE'B%';

--  Problem 15: Get all Makes with make ends with 'W'
SELECT Makes.Make
FROM Makes
WHERE Makes.Make LIKE'%W';

--Problem 16: Get all Makes that manufactures DriveTypeName = FWD

SELECT        distinct Makes.Make, DriveTypes.DriveTypeName
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Where DriveTypes.DriveTypeName ='FWD';

--Problem 17: Get total Makes that Mantufactures DriveTypeName=FWD

SELECT COUNT(*) AS TotalFWDVehicle from
(
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
Where DriveTypes.DriveTypeName ='FWD'
) R1;

-- Problem 18: Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc


SELECT        distinct Makes.Make, DriveTypes.DriveTypeName,Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Makes.Make, DriveTypes.DriveTypeName
ORDER BY Makes.Make ASC ,Total DESC;


--Problem 19: Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000

--solution 1
SELECT *FROM
(
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName,Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
GROUP BY Makes.Make, DriveTypes.DriveTypeName
Order By Make ASC, Total Desc

)R1
WHERE Total>10000;

--solution 2
SELECT        distinct Makes.Make, DriveTypes.DriveTypeName, Count(*) AS Total
FROM            DriveTypes INNER JOIN
                         VehicleDetails ON DriveTypes.DriveTypeID = VehicleDetails.DriveTypeID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID

Group By Makes.Make, DriveTypes.DriveTypeName
Having Count(*) > 10000

Order By Make ASC, Total Desc

--Problem 20: Get all Vehicles that number of doors is not specified
select *from VehicleDetails
where NumDoors is null;

--Get Total Vehicles that number of doors is not specified
select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
where NumDoors is Null;

--Problem 22: Get percentage of vehicles that has no doors specified

select (

CAST(  (select count(*) as TotalWithNoSpecifiedDoors from VehicleDetails
where NumDoors is Null) as FLOAT )

/

CAST( (SELECT COUNT(*) FROM VehicleDetails AS TOTAL) as float)

) as PercOfNoSpecifiedDoors


--Problem 23: Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'

SELECT    distinct    VehicleDetails.MakeID, Makes.Make, SubModelName
FROM            VehicleDetails INNER JOIN
                         SubModels ON VehicleDetails.SubModelID = SubModels.SubModelID INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
	
	where SubModelName='Elite'

-- Problem 24: Get all vehicles that have Engines > 3 Liters and have only 2 doors

SELECT *FROM VehicleDetails
WHERE Engine_Liter_Display>3 AND NumDoors=2;

--Problem 25: Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
SELECT         Makes.Make, VehicleDetails.*
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        (VehicleDetails.Engine LIKE '%OHV%') AND (VehicleDetails.Engine_Cylinders = 4);


--Problem 26: Get all vehicles that their body is 'Sport Utility' and Year > 2020

SELECT BodyName,VehicleDetails.* 
FROM     VehicleDetails INNER JOIN
                  Bodies ON VehicleDetails.BodyID = Bodies.BodyID

WHERE Bodies.BodyName= 'Sport Utility' AND Year>2020;

--Problem 27: Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'

SELECT BodyName,VehicleDetails.* 
FROM     VehicleDetails INNER JOIN
                  Bodies ON VehicleDetails.BodyID = Bodies.BodyID

WHERE Bodies.BodyName IN ('Coupe' , 'Hatchback' , 'Sedan');

--Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021

SELECT BodyName,VehicleDetails.* 
FROM     VehicleDetails INNER JOIN
                  Bodies ON VehicleDetails.BodyID = Bodies.BodyID

WHERE Bodies.BodyName IN ('Coupe' , 'Hatchback' , 'Sedan') AND Year in(2008, 2020,2021);

-- Problem 29: Return found=1 if there is any vehicle made in year 1950

select found=1 
where 
exists (
        select top 1 * from VehicleDetails where Year =1950
      )
      
--Problem 30: Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words, 
--and if door is null display 'Not Set'


Select VehicleDetails.Vehicle_Display_Name,VehicleDetails.NumDoors,
CASE 
WHEN NumDoors = 1 THEN 'One Doors'
WHEN NumDoors = 2 THEN 'Two Doors'
WHEN NumDoors = 3 THEN 'Three Doors'
WHEN NumDoors = 4 THEN 'Four Doors'
WHEN NumDoors = 5 THEN 'Five Doors'
WHEN NumDoors = 6 THEN 'Six Doors'
WHEN NumDoors = 7 THEN 'Seven Doors'
WHEN NumDoors = 8 THEN 'Eight Doors'
WHEN NumDoors = 9 THEN 'Nine Doors'
        ELSE 'No Set'
END  AS DoorDescription
from VehicleDetails
  

  --Problem 31: Get all Vehicle_Display_Name,
  --year and add extra column to calculate the age of the car then sort the results by age desc.

Select VehicleDetails.Vehicle_Display_Name, Year,
Age= YEAR(GetDate()) - VehicleDetails.year
from VehicleDetails
Order by Age Desc

--Problem 32: Get all Vehicle_Display_Name, year, 
--Age for vehicles that their age between 15 and 25 years old

SELECT *FROM
(
Select VehicleDetails.Vehicle_Display_Name, Year,
Age= YEAR(GetDate()) - VehicleDetails.year
from VehicleDetails

)R1
where Age between 15 and 25;


--Problem 33: Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles

select  Min(Engine_CC) as MinimimEngineCC,Max(Engine_CC) as MaximumEngineCC, AVG(Engine_CC)  as AverageEngineCC
from VehicleDetails;

--Problem 34: Get all vehicles that have the minimum Engine_CC

SELECT *FROM VehicleDetails
WHERE Engine_CC=( SELECT MIN(Engine_CC) as MinimimEngineCC from VehicleDetails);

--Problem 35: Get all vehicles that have the Maximum Engine_CC
SELECT *FROM VehicleDetails
WHERE Engine_CC=( SELECT MAX(Engine_CC) as MaxEngineCC from VehicleDetails);

--Problem 36: Get all vehicles that have Engin_CC below average
SELECT *FROM VehicleDetails
WHERE Engine_CC<( SELECT AVG(Engine_CC) as MaxEngineCC from VehicleDetails);

--Problem 37: Get total vehicles that have Engin_CC above average
SELECT *FROM VehicleDetails
WHERE Engine_CC>( SELECT AVG(Engine_CC) as MaxEngineCC from VehicleDetails);

--Problem 38: Get all unique Engin_CC and sort them Desc
SELECT DISTINCT  Engine_CC FROM  VehicleDetails
ORDER BY Engine_CC DESC ;


--  Problem 39: Get the maximum 3 Engine CC
Select  distinct top 3 Engine_CC from VehicleDetails
	Order By Engine_CC Desc;

 -- Problem 40: Get all vehicles that has one of the Max 3 Engine CC

 Select Vehicle_Display_Name from VehicleDetails
where Engine_CC in 
(
	
	Select  distinct top 3 Engine_CC from VehicleDetails
	Order By Engine_CC Desc
);


-- Get all Makes  that manufactures one of the Max 3 Engine CC

SELECT        distinct Makes.Make
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID
WHERE        (VehicleDetails.Engine_CC IN
                             (SELECT DISTINCT TOP (3) Engine_CC
                               FROM            VehicleDetails 
                               ORDER BY Engine_CC DESC)
							 )

Order By Make

---- Get a table of unique Engine_CC and calculate tax per Engine CC as follows:
	-- 0 to 1000    Tax = 100
	-- 1001 to 2000 Tax = 200
	-- 2001 to 4000 Tax = 300
	-- 4001 to 6000 Tax = 400
	-- 6001 to 8000 Tax = 500
	-- Above 8000   Tax = 600
	-- Otherwise    Tax = 0


    SELECT Engine_CC,

    CASE
		WHEN Engine_CC between 0 and 1000 THEN 100
		 WHEN Engine_CC between 1001 and 2000 THEN 200
		 WHEN Engine_CC between 2001 and 4000 THEN 300
		 WHEN Engine_CC between 4001 and 6000 THEN 400
		 WHEN Engine_CC between 6001 and 8000 THEN 500
		 WHEN Engine_CC > 8000 THEN 600	
		ELSE 0

	END as Tax

    FROM
    (
    SELECT DISTINCT Engine_CC FROM VehicleDetails
    )R1
    ORDER BY Engine_CC;


    --SOLUTION 2
    SELECT DISTINCT Engine_CC,

    CASE
		WHEN Engine_CC between 0 and 1000 THEN 100
		 WHEN Engine_CC between 1001 and 2000 THEN 200
		 WHEN Engine_CC between 2001 and 4000 THEN 300
		 WHEN Engine_CC between 4001 and 6000 THEN 400
		 WHEN Engine_CC between 6001 and 8000 THEN 500
		 WHEN Engine_CC > 8000 THEN 600	
		ELSE 0

	END as Tax
    FROM VehicleDetails
    ORDER BY Engine_CC;

    -- Problem 43: Get Make and Total Number Of Doors Manufactured Per Make


    SELECT Makes.Make,Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
    FROM VehicleDetails INNER JOIN Makes ON VehicleDetails.MakeID =Makes.MakeID
    GROUP BY Makes.Make
    ORDER BY TotalNumberOfDoors DESC;

 --Problem 44: Get Total Number Of Doors Manufactured by 'Ford'

 SELECT Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
 FROM VehicleDetails INNER JOIN Makes ON VehicleDetails.MakeID =Makes.MakeID
 WHERE Makes.Make='Ford';

 --sulotion 2
 SELECT        Makes.Make, Sum(VehicleDetails.NumDoors) AS TotalNumberOfDoors
FROM            VehicleDetails INNER JOIN
                         Makes ON VehicleDetails.MakeID = Makes.MakeID

Group By Make
Having Make='Ford';

--  Problem 45: Get Number of Models Per Make
SELECT        Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
Order By NumberOfModels Desc;

--Problem 46: Get the highest 3 manufacturers that make the highest number of models

SELECT         TOP 3 Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
Order By NumberOfModels Desc;


--Problem 47: Get the highest number of models manufactured

select Max(NumberOfModels) as MaxNumberOfModels
FROM
(
SELECT         Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
Order By NumberOfModels Desc
)R1


-- Problem 48: Get the highest Manufacturers manufactured the highest number of models

SELECT         Makes.Make, COUNT(*) AS NumberOfModels
FROM            Makes INNER JOIN
                         MakeModels ON Makes.MakeID = MakeModels.MakeID
GROUP BY Makes.Make
having COUNT(*) = (

										select Max(NumberOfModels) as MaxNumberOfModels
										from
										(

												SELECT      MakeID, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY MakeID
												
										) R1

							);

 --Problem 49: Get the Lowest Manufacturers manufactured the lowest number of models

 SELECT        Makes.Make, COUNT(*) AS NumberOfModels
		FROM            Makes INNER JOIN
								 MakeModels ON Makes.MakeID = MakeModels.MakeID
		GROUP BY Makes.Make

		having COUNT(*) = (

										select min(NumberOfModels) as MaxNumberOfModels
										from
										(

												SELECT      MakeID, COUNT(*) AS NumberOfModels
												FROM       
																		 MakeModels
												GROUP BY MakeID
												
										) R1

							);


   --  Problem 50: Get all Fuel Types , each time the result should be showed in random order
   select * from FuelTypes
order by NewID();

