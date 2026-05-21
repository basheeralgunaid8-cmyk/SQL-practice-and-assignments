--1. Basic Retrieval Queries

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
