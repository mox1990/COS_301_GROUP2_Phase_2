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
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	module_name VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Person
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	first_names VARCHAR(100),
	surname VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Auditlog
(
	date_time_stamp datetime NOT NULL,
	userId INT REFERENCES Person(id),
	"action" VARCHAR(100) NOT NULL,
	comment VARCHAR(100),
	old_value VARCHAR(100) NOT NULL,
	new_value VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Assessment
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	name VARCHAR(100) NOT NULL,
	module_Id INT REFERENCES Module_information(id),
	"owner" INT REFERENCES Person(id),
	full_mark INT NOT NULL,
	"weight" INT NOT NULL,
	"description" VARCHAR(255),
	published bit 
)
GO

CREATE TABLE Leaf_assessment
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	asessmentId INT REFERENCES Assessment(id),
	name VARCHAR(100) NOT NULL,
	full_mark INT NOT NULL,
	"description" VARCHAR(255),
	published bit
)
GO

CREATE TABLE Assessment_session
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	leafAssessmentId INT REFERENCES Leaf_assessment(id),
	name VARCHAR(255),
	"open" datetime NOT NULL,
	"close" datetime NOT NULL,
)
GO

CREATE TABLE AssessmentSessionMarker
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	userId INT REFERENCES Person(id),
	assessmentSessionId INT REFERENCES Assessment_session(id),
)
GO

CREATE TABLE Mark_allocation
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	userId INT REFERENCES Person(id),
	markerId INT REFERENCES Person(id),
	assessmentSessionId INT REFERENCES Assessment_session(id),
	mark INT NOT NULL,
	comment VARCHAR(255),
	time_Stamp datetime NOT NULL
)
GO