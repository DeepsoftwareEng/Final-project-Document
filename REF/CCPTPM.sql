use master
create database CCPTPM
drop database CCPTPM

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
	constraint fk_Account_Faculty
	Foreign key (fid)
	References Faculty(id_faculty)
)
create table WorkerList(
	id int not null primary key,
	fullname nvarchar(50),
	birth date,
	images nvarchar(30) not null,
	fid nvarchar(50),
	constraint fk_WorkerList_Faculty
	Foreign key (fid)
	References Faculty(id_faculty)
)
create table Attend(
	d_m date not null primary key,
)
create table Attendance(
	id int not null,
	d_m date not null,
	checkin date,
	checkout date,
	workingHour float,
	daySalary float,
	primary key(id, d_m),
	constraint fk_Attendance_WorkerList foreign key (id) References WorkerList(id),
	constraint fk_Attendance_Attend foreign key (d_m) references Attend(d_m)
)
create table UsedEmail(
	email nvarchar(50) primary key
)
Drop table WorkerList
Drop table Faculty
Drop table Account
Drop table Attend
Drop table Attendance
Drop table UsedEmail

Select* from Faculty
Select* from Account
Select* from WorkerList
Select* from Attendance
Select* from Attend
Select* from UsedEmail

Insert into Faculty values ('CNTT01','Cong nghe thong tin 1'),
						   ('CSKH01','Cham soc khanh hang 1')
insert into Account values ('admin1', 'admin1', 1, 'deepit2507@gmail.com', 'admin1', 'CNTT01'),
							('staff1', 'staff1', 0, 'minhvt223@gmail.com', 'staff1', 'CSKH01')
Insert into WorkerList values(1, 'Nguyen Hung', '2002-07-25', 'Hung01', 'CNTT01'),
							 (2, 'Nguyen Phuc', '2002-05-27', 'Phuc02', 'CSKH01')

Insert into Attend values ('2023-04-03'),
						 ('2023-04-04')
insert into Attendance values (1, '2023-04-03'),
							  (2, '2023-04-03'),
							  (1, '2023-04-04')
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