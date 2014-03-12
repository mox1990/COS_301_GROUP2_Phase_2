Use Master
Go
If Exists (Select * from sys.databases where name = 'Mark_System')
DROP DATABASE Mark_System
Go
Create Database Mark_System
Go

Use Mark_System
Go

CREATE TABLE Module_information
(
	module_Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	module_name VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Person
(
	userId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	first_names VARCHAR(255),
	surname VARCHAR(255) NOT NULL
)
GO

CREATE TABLE Auditlog
(
	date_time_stamp datetime NOT NULL,
	userId INT REFERENCES Person(userId),
	"action" VARCHAR(100) NOT NULL,
	"description" VARCHAR(255),
	old_value VARCHAR(100) NOT NULL,
	new_value VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Assessment
(
	assessmentId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	assessment_name VARCHAR(100) NOT NULL,
	module_Id INT REFERENCES Module_information(module_Id),
	"owner" INT REFERENCES Person(userId),
	full_mark INT NOT NULL,
	"description" VARCHAR(255),
	"open" datetime NOT NULL,
	"close" datetime NOT NULL,
	published bit 
)
GO

CREATE TABLE Module_right
(
	moduleId INT REFERENCES Module_information(module_Id),
	userId INT REFERENCES Person(userId),
	"type" VARCHAR(2) NOT NULL
)
GO

CREATE TABLE "Login"
(
	userId INT REFERENCES Person(userId),
	"password" VARCHAR(30) NOT NULL
)
GO

CREATE TABLE Mark
(
	moduleId INT REFERENCES Module_information(module_Id),
	userId INT REFERENCES Person(userId),
	mark INT NOT NULL,
	comment VARCHAR(255) NOT NULL,
	date_time_mark_entered datetime NOT NULL
)
GO