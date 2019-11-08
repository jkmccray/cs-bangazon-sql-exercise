 -- 1.  List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.

--SELECT e.Id, e.FirstName, e.LastName, e.IsSupervisor, d.Name FROM Employee e
--LEFT JOIN Department d ON d.Id = e.DepartmentId
--ORDER BY d.Name, e.LastName, e.FirstName

-- 2. List each department ordered by budget amount with the highest first.
--SELECT Id, Name, Budget
--FROM Department
--ORDER BY Budget DESC

-- 3. List each department name along with any employees (full name) in that department who are supervisors.
--SELECT d.Id, d.Name, e.FirstName, e.LastName
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
SELECT e.FirstName, e.LastName, COUNT(t.Id) AS NumberOfTrainingPrograms
FROM Employee e
INNER JOIN EmployeeTraining et ON e.Id = et.EmployeeId
LEFT JOIN TrainingProgram t ON t.Id = et.TrainingProgramId
GROUP BY e.Id, e.FirstName, e.LastName
