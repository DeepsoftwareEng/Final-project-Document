use master
create database CCPTPM

use CCPTPM
create table Account(
	username nvarchar(30) not null primary key,
	passwords nvarchar(30),
)
create table WorkerList(
	id int not null primary key,
	fullname nvarchar(50),
	birth date,
	images nvarchar(30) not null
)
create table AttendedAtDayX(
	wid int not null primary key,
	d_m date not null,
	constraint fk_Attended_WorkerList
	Foreign key (wid)
	references WorkerList(id)
)
create table UsedEmail(
	email nvarchar(50) primary key
)
Drop table AttendedAtDayX
Drop table WorkerList
Select* from Account
Select* from WorkerList
Select* from AttendedAtDayX
Select* from UsedEmail