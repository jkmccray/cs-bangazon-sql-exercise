 -- 1.  List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.

--SELECT e.Id, e.FirstName, e.LastName, e.IsSupervisor, d.Name FROM Employee e
--LEFT JOIN Department d ON d.Id = e.DepartmentId
--ORDER BY d.Name, e.LastName, e.FirstName

-- 2. List each department ordered by budget amount with the highest first.
--SELECT Id, Name, Budget
--FROM Department
--ORDER BY Budget DESC

-- 3. List each department name along with any employees (full name) in that department who are supervisors.
--SELECT d.Id, d.Name, e.FirstName + e.LastName as EmployeeName
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--WHERE e.IsSupervisor = 1

-- 4. List each department name along with a count of employees in each department.
--SELECT d.Name, COUNT(e.Id) AS NumberOfEmployees
--FROM Department d
--LEFT JOIN Employee e ON e.DepartmentId = d.Id
--GROUP BY d.Name

-- 5. Write a single update statement to increase each department's budget by 20%.
--SELECT * FROM Department
--UPDATE Department
--SET Budget = Budget*1.2
--SELECT * FROM Department

-- 6. List the employee full names for employees who are not signed up for any training programs.
--SELECT e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--LEFT JOIN TrainingProgram t ON t.Id = et.TrainingProgramId
--WHERE t.Id IS NULL

-- 7. List the employee full names for employees who are signed up for at least one training program and include the number of training programs they are signed up for.
--SELECT e.FirstName, e.LastName, COUNT(t.Id) AS NumberOfTrainingPrograms
--FROM Employee e
--INNER JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--LEFT JOIN TrainingProgram t ON t.Id = et.TrainingProgramId
--GROUP BY e.Id, e.FirstName, e.LastName

-- 8. List all training programs along with the count employees who have signed up for each.
--SELECT t.Id, t.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram t
--LEFT JOIN EmployeeTraining et on t.Id = et.TrainingProgramId
--GROUP BY t.Id, t.Name

-- 9. List all training programs who have no more seats available.
--SELECT t.Id, t.Name, t.MaxAttendees, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram t
--LEFT JOIN EmployeeTraining et on et.TrainingProgramId = t.Id
--GROUP BY t.Id, t.Name, t.MaxAttendees
--HAVING COUNT(et.EmployeeId) = t.MaxAttendees

-- 10. List all future training programs ordered by start date with the earliest date first.
--SELECT Id, Name, StartDate, EndDate, MaxAttendees
--FROM TrainingProgram
--WHERE StartDate < GETDATE()
--ORDER BY StartDate

-- 11. Assign a few employees to training programs of your choice.
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
--VALUES (1,1)
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
--VALUES (1,2)
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
--VALUES (2,1)

-- 12. List the top 3 most popular training programs. (For this question, consider each record in the training program table to be a UNIQUE training program).
--SELECT TOP 3 t.Id, t.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram t
--LEFT JOIN EmployeeTraining et on t.Id = et.TrainingProgramId
--GROUP BY t.Id, t.Name
--ORDER BY COUNT(et.EmployeeId) DESC

-- 13. List the top 3 most popular training programs. (For this question consider training programs with the same name to be the SAME training program).
--SELECT TOP 3 t.Name, COUNT(et.EmployeeId) AS EmployeeCount
--FROM TrainingProgram t
--LEFT JOIN EmployeeTraining et on t.Id = et.TrainingProgramId
--GROUP BY t.Name
--ORDER BY COUNT(et.EmployeeId) DESC

---- 14. List all employees who do not have computers.
--SELECT e.Id, e.FirstName, e.LastName
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
--WHERE ce.ComputerId IS NULL

-- CORRECT ANSWER:
--SELECT e.*
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
--where ce.id is null
--	or e.id in (
--		select ce.EmployeeId
--		from ComputerEmployee ce
--		where ce.UnassignDate is not null
--				and ce.EmployeeId not in (
--					select ce.EmployeeId
--					from ComputerEmployee ce
--					where ce.UnassignDate is null
--				)
--		)

-- 15. List all employees along with their current computer information make and manufacturer combined into a field entitled ComputerInfo. If they do not have a computer, this field should say "N/A".
--SELECT e.Id, e.FirstName, e.LastName, ISNULL(c.Make + c.Manufacturer, 'N/A') as ComputerInfo
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON ce.EmployeeId = e.Id
--LEFT JOIN Computer c ON ce.ComputerId = c.Id
--WHERE ce.UnassignDate IS NULL

-- 16. List all computers that were purchased before July 2019 that have not been decommissioned.
--SELECT Id, PurchaseDate, DecomissionDate, Make, Manufacturer
--FROM Computer
--WHERE PurchaseDate < CAST('2019-07-01' AS datetime) AND DecomissionDate IS NULL

-- 17. List all employees along with the total number of computers they have ever had.
--SELECT e.Id, COUNT(ce.ComputerId) AS ComputerCount
--FROM Employee e
--LEFT JOIN ComputerEmployee ce on ce.EmployeeId = e.Id
--GROUP BY e.Id

-- 18. List the number of customers using each payment type
--SELECT p.Name, COUNT(c.Id) AS CustomerCount
--FROM PaymentType p
--LEFT JOIN Customer c on c.Id = p.CustomerId
--GROUP BY p.Name

-- 19. List the 10 most expensive products and the names of the seller
--SELECT TOP 10 p.Id, p.ProductTypeId, p.Title, p.Price, c.FirstName, c.LastName
--FROM Product p
--LEFT JOIN Customer c on c.Id = p.CustomerId
--ORDER BY p.Price DESC

-- 20. List the 10 most purchased products and the names of the seller
--SELECT TOP 10 p.Title, COUNT(op.OrderId) as OrderCount
--FROM OrderProduct op
--LEFT JOIN Product p on op.ProductId = p.Id
--GROUP BY p.id, p.Title
--ORDER BY COUNT(op.OrderId) DESC

-- 21. Find the name of the customer who has made the most purchases
--SELECT TOP 1 WITH TIES c.FirstName, c.LastName, COUNT(o.Id) AS OrderCount
--FROM [Order] o
--INNER JOIN Customer c on c.Id = o.CustomerId
--GROUP BY c.Id, c.FirstName, c.LastName
--ORDER BY COUNT(o.Id) DESC

-- 22. List the amount of total sales by product type
--SELECT pt.Name, SUM(p.Price) AS TotalSales
--FROM Product p
--LEFT JOIN ProductType pt ON p.ProductTypeId = pt.Id
--LEFT JOIN OrderProduct op ON p.Id = op.ProductId
--GROUP BY pt.Id, pt.Name

-- 23. List the total amount made from all sellers
--SELECT p.CustomerId, SUM(p.Price) as Total
--FROM Product p
--LEFT JOIN OrderProduct op ON p.Id = op.ProductId
--GROUP BY p.CustomerId