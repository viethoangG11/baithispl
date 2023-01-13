CREATE DATABASE EmployeeDB
GO
USE EmployeeDB
GO
create table Department(
DepartId int Primary Key not null,
DepartName varchar(50) not null,
Description varchar(100) not null
)
create table Employee(
EmpCode char(6) Primary Key,
FirstName varchar(30) not null,
LastName varchar(30) not null,
Birthday smalldatetime not null,
Gender Bit Default '1',
[Address] varchar(100),
DepartID Int Foreign key references Department(DepartId),
Salary Money,
)


--cau 1:
INSERT INTO Department
values
(1,'hanh chinh','quan ly,giam sat'),
(2,'quan ly','quan ly ca nhan'),
(3,'nhan su','tuyen nhan vien')

INSERT INTO Employee
values 
('10','Le','Hoang','2004/07/16','1','Tuyen Quang','1','1000'),
('11','Tran','Hieu','1999/02/08','0','Ha Noi','1','9806'),
('12','Hoang','Phuong','1985/07/06','1','Hoa Binh','1','6509')

select * from Department 
select * from  Employee
--cau 2:
select EmpCode,LastName,Birthday,[Address] from Employee
update Employee
set Salary = Salary * 1.1
--cau 3:
alter table Employee
add constraint LuonLonHonKhong check(Salary>0)
--cau 4:
create trigger tg_chkBirthday
on Employee
after insert , update
as
begin 
     if exists (select 1 from inserted where birthday <=23)
     begin raiserror('value of birthday column must be greater than 23',16,1);
     rollback transaction ;
    end
end

--cau 5:
create index IX_hanhchinh
on Department(DepartName);

--cau 6:
create view view_emp
as
select Employee.EmpCode,Employee.FirstName,Employee.LastName,Department.DepartName
from Department join
	Employee on Department.DepartId = Employee.DepartID
--7
CREATE proc sp_getAllEmp @DepartId int
as
BEGIN
SELECT *FROM Employee e
WHERE e.DepartID = @DepartId
END

--8
create proc sp_delDept @EmpCode char(6)
as
BEGIN
DELETE FROM Employee 
WHERE EmpCode=@EmpCode
end

exec sp_getAllEmp 03
