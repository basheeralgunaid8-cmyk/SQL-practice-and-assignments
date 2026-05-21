--1. Basic Retrieval Queries

--a. Find the names of all vehicles manufactured by Toyota.
 select  v.Vehicle_Display_Name from VehicleDetails v
 inner join Makes m on v.MakeID= m.MakeID
 where m.Make='Toyota';
 

--b. Find all vehicles manufactured between 2010 and 2020.
  select  v.* from VehicleDetails v
 where v.Year between 2010 and 2020;

--c. Find all vehicles that do not use Gasoline fuel.
  select   *from VehicleDetails v
 INNER JOIN FuelTypes f on v.FuelTypeID=f.FuelTypeID
 where ISNULL(f.FuelTypeName,'')<>'Gasoline';

--d. Find all vehicles whose Engine_CC is greater than 3000.
 select  * from VehicleDetails V
 where v.Engine_CC>3000;

--e. Find all vehicles with exactly 8 cylinders.
select  * from VehicleDetails v
 where v.Engine_Cylinders=8;
-----------------------------------------------------------------------------------------------------------------------
--2. Join Queries

--a. Find the vehicle display names along with their make names.
 select  v.Vehicle_Display_Name,m.Make from VehicleDetails v
 inner join Makes m on v.MakeID= m.MakeID;

--b. Find all vehicles with their corresponding fuel type names.

select    v.Vehicle_Display_Name ,f.FuelTypeName from VehicleDetails v
INNER JOIN FuelTypes f on v.FuelTypeID=f.FuelTypeID;
--c. Find all vehicles with their body type names.
select v.Vehicle_Display_Name ,b.BodyName from VehicleDetails v
INNER JOIN Bodies b  on v.BodyID=b.BodyID;

--d. Find all vehicles along with their drive type names.
select v.Vehicle_Display_Name ,d.DriveTypeName from VehicleDetails v
INNER JOIN DriveTypes d on v.DriveTypeID=d.DriveTypeID;

--e. Find all vehicles with make, model, and submodel names.
 select  v.Vehicle_Display_Name,ms.Make,md.ModelName,sub.SubModelName from VehicleDetails v
 INNER JOIN Makes ms on v.MakeID= ms.MakeID INNER JOIN MakeModels md on v.ModelID=md.ModelID and v.MakeID=md.MakeID --we include the make condition to make sure and get the the right query
 INNER JOIN SubModels sub ON v.SubModelID=sub.SubModelID;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--3. Basic Retrieval & Filtering Queries

--a. Find the names of all vehicles manufactured by Toyota.
 select  m.Make from VehicleDetails v
 inner join Makes m on v.MakeID= m.MakeID
 where m.Make='Toyota';
 
--b. Find all vehicles manufactured between 2010 and 2020.
 select  m.Make from VehicleDetails v
 inner join Makes m on v.MakeID= m.MakeID
 where v.Year between 2010 and 2020;

--c. Find all vehicles that do not use Gasoline fuel.
 select  m.Make from VehicleDetails v
 left join Makes m on v.MakeID= m.MakeID  left join
 FuelTypes f on v.FuelTypeID=f.FuelTypeID
 where f.FuelTypeName!='Gasoline';

--d. Find all vehicles whose Engine_CC is greater than 3000.
 select  m.Make from VehicleDetails v
 left join Makes m on v.MakeID= m.MakeID
 where v.Engine_CC>3000;
--e. Find all vehicles with exactly 8 cylinders.
select  m.Make from VehicleDetails v
 left join Makes m on v.MakeID= m.MakeID
 where v.Engine_Cylinders=8;

--a. Find the names of all vehicles manufactured by Toyota.
 select  m.Make from VehicleDetails v
 inner join Makes m on v.MakeID= m.MakeID
 where m.Make='Toyota';
 
---------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------
-- 3. Aggregate Queries

--a. Find the total number of vehicles in the database.

SELECT COUNT(*) FROM VehicleDetails;
--b. Find the number of vehicles for each make.
SELECT m.Make, COUNT(*) as TotalOfVehicles FROM VehicleDetails v
INNER JOIN Makes m ON v.MakeID=m.MakeID
group by m.Make;
--c. Find the average Engine_CC for each make.
SELECT  m.Make,AVG(v.Engine_CC) as AvergOfEngine_CC FROM VehicleDetails v
INNER JOIN Makes m ON v.MakeID=m.MakeID
group by m.Make;
--d. Find the maximum Engine_CC for each fuel type.
SELECT    f.FuelTypeName,MAX(v.Engine_CC) as MaxOfEngine_CC FROM VehicleDetails v
INNER JOIN FuelTypes f ON v.FuelTypeID=f.FuelTypeID
group by f.FuelTypeName;
--e. Find the minimum Engine_CC for each body type.
SELECT b.BodyName,MIN(v.Engine_CC) as MinOfEngine_CC FROM VehicleDetails v
INNER JOIN Bodies b ON v.BodyID=b.BodyID
group by b.BodyName;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





