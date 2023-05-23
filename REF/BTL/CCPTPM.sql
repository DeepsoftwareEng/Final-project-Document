use master
drop database CCPTPM
create database CCPTPM

use CCPTPM
create table Faculty(
	id_faculty nvarchar(50) not null primary key,
	name_faculty nvarchar(50)
)
create table Account(
	username nvarchar(30) not null primary key,
	passwords nvarchar(30),
	roles int not null,
	gmail nvarchar(30),
	images nvarchar(30),
	fid nvarchar(50),
	Foreign key (fid) References Faculty(id_faculty)
)
create table WorkerList(
	id int not null primary key,
	fullname nvarchar(50),
	birth date,
	images nvarchar(30) not null,
	fid nvarchar(50),
	Foreign key (fid) References Faculty(id_faculty)
)
create table Attendance(
	id int not null primary key,
	id_worker int not null,
	d_m datetime not null,
	id_faculty nvarchar(50),
	shift_worked int,
	foreign key (id_worker) References WorkerList(id),
	foreign key (id_faculty) References Faculty(id_faculty)
)
create table ListEmail(
	email nvarchar(50) primary key,
	describe nvarchar(50)
)
create table Request(
	id int primary key Identity(1,1),
	id_attendance int not null,
	detail nvarchar(50),
	states nvarchar(50),
	foreign key(id_attendance) References Attendance(id)
)
create table LateList(
	id int primary key Identity(1,1),
	id_worker int not null,
	id_faculty nvarchar(50),
	d_m date not null,
	shift_worked int,
	detail nvarchar(50),
	foreign key (id_worker) References WorkerList(id),
)
/*
Drop table WorkerList
Drop table Faculty
Drop table Account
Drop table Attendance
Drop table ListEmail
Drop table Request
Drop table LateList
*/
Select* from Faculty
Select* from Account
Select* from WorkerList
Select* from Attendance
Select* from ListEmail
Select* from Request
Select* from LateList

SELECT id_worker,fullname,d_m FROM Attendance INNER JOIN WorkerList ON Attendance.id_worker = WorkerList.id WHERE id_faculty = 'CNTT01' AND shift_worked = 2 AND CONVERT(date,d_m) = '2023-04-03'

SELECT id, fullname FROM WorkerList WHERE id NOT IN (
	SELECT id_worker FROM Attendance WHERE id_faculty = 'CNTT01' AND shift_worked = 2 AND CONVERT(date,d_m) = '2023-04-03'
)

SELECT * FROM Attendance
SELECT fullname, COUNT(id_worker) As attend
FROM WorkerList FULL JOIN Attendance 
ON Attendance.id_worker = WorkerList.id 
AND id_faculty = 'CNTT01' AND MONTH(d_m) = 4 AND YEAR(d_m) = 2023
GROUP BY fullname


Insert into Faculty values ('CNTT01','Cong nghe thong tin 1'),
						   ('CSKH01','Cham soc khanh hang 1')
insert into Account values ('admin1', 'admin1', 1, 'deepit2507@gmail.com', 'admin1', 'CNTT01'),
						   ('staff1', 'staff1', 0, 'minhvt223@gmail.com', 'staff1', 'CSKH01'),
						   ('staff2', 'staff2', 0, 'khanhtho10122002@gmail.com', 'staff1', 'CNTT01')
Insert into WorkerList values (5, 'Minh Tien', '2002-07-25', 'B', 'CNTT01'),
							  (6, 'A', '2002-07-25', 'A', 'CNTT01'),
						     (1, 'Nguyen Hung1', '2002-07-25', 'Hung01', 'CNTT01'),
							 (2, 'Nguyen Khanh Tho', '2002-12-10', 'Tho01', 'CNTT01'),
							 (3, 'Dinh Anh Quan', '2002-12-10', 'Quan01', 'CNTT01'),
							 (4, 'Nguyen Phuc', '2002-05-27', 'Phuc02', 'CSKH01')
insert into Attendance values (1,1, '2023-04-03','CNTT01',1),
							  (2,2, '2023-04-03','CNTT01',1),
							  (3,3, '2023-04-03','CNTT01',1),
							  (4,4, '2023-04-03','CNTT01',1),
							  (5,1, '2023-04-03','CNTT01',2),
							  (6,2, '2023-04-03','CNTT01',2),
							  (7,3, '2023-04-03','CNTT01',2),
							  (8,4, '2023-04-03','CNTT01',2)

insert into ListEmail values ('khanhtho10122002@gmail.com',N'Nguyễn Khánh Thọ - trưởng phòng CNTT1')

Select Count(1) from Account where username ='admin1' and passwords='admin1'
Select count(1) from Account inner join Faculty on Account.fid = Faculty.id_faculty where id_faculty = 'CNTT01' and gmail='deepit2507@gmail.com' and username='admin1'

DECLARE @StartDate date = '2022-02-01';
DECLARE @EndDate date = '2022-02-28';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO Attendance
    VALUES (1, @StartDate);

    SET @StartDate = DATEADD(day, 1, @StartDate);
END
SELECT d_m
FROM Attendance
WHERE MONTH(d_m) = 2 AND id=1