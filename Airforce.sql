create schema Airforce;
set search_path to Airforce;

create table Unit(
unitname varchar(100),
unittype varchar(100),
DOE date,
Primary key (unitname,unittype) 
);

create table Course(
courseid varchar(100),
coursename varchar(100),
year char(4),
Primary key (courseid,year)

);

create table Soldier(
sid int ,
sname varchar(100),
rank varchar(100),
DOB date,
DOC date,
DOR date,
courseid varchar(100),
year char(4),
unitname Varchar(100),
unittype varchar(100),
remark varchar(100),
contactno char(100),
gender char(10),
addressline varchar(100),
city varchar(100),
"state" varchar(100),
pincode char(6),
maritalstatus varchar(100),
emergencycontact char(10),
Primary key (sid),
Foreign key (courseid, year) references Course(courseid, year)
	on update cascade , 
Foreign key (unitname, unittype) references Unit(unitname, unittype)
	on update cascade 
);


Create table Medicalinformation(
sid int,
identificationmark varchar(100),
fitnesslevel int,
	check (fitnesslevel >0 AND fitnesslevel<=5),
height int,
weight decimal(5,2),
bloodgroup varchar(100),
allergies varchar(100),
checkupdate date,
primary key(sid,checkupdate),
Foreign key (sid) references Soldier(sid)
	on update cascade on delete cascade
);
create table Dependents(
name varchar(100),
sid int,
DOB date,
gender char(10),
relationship varchar(100),
primary key (name,sid),
Foreign key (sid) references Soldier(sid)
	on update cascade on delete cascade
);

Create table Awards(
sid int,
awardName varchar(100),
Primary key(sid,awardname),
	
Foreign key (sid) references Soldier(sid)
	on update cascade on delete cascade
);

Create table Base
(
geographicalcoordinate varchar(100),
station varchar(100),
state varchar(100),
primary key (geographicalcoordinate)

);

create table Aircraft(
serialno int,
variant varchar(100),
previousid int,
aircraftstatus varchar(100),
TOC_date date,
SOC_date date,
geographicalcoordinate varchar(100),
Primary key (serialno),
Foreign key (geographicalcoordinate) references Base(geographicalcoordinate)
	on update cascade 
);

create table Mission(
missionid int,
name varchar(100),
location varchar(100),
dateofcommencement date,
missionhead int ,
dateofcompletion date,
Primary key (missionid),
Foreign key (missionhead) references Soldier(sid)
	on update cascade
);

create table Missionassigned(
mid int,
sid int,
Primary key (mid,sid),
Foreign key (mid) references Mission(missionid)
	on update cascade,
Foreign key (sid) references Soldier(sid)
	on update cascade on delete cascade 
);

create table Stationedat(
unitname varchar(100),
unittype varchar(100),
geographicalcoordinate varchar(100),
Primary key (unitname,unittype,geographicalcoordinate),
Foreign key (geographicalcoordinate) references Base(geographicalcoordinate)
	on update cascade on delete cascade,
Foreign key (unitname, unittype) references Unit(unitname, unittype)
	on update cascade on delete cascade
);

create table Assignedaircraft(
mid int,
serialno int,
Primary key (mid,serialno),
Foreign key (mid) references Mission(missionid)
	on update cascade on delete cascade,
Foreign key (serialno) references Aircraft(serialno)
	on update cascade);

    INSERT INTO Base (geographicalcoordinate, station, state)
VALUES 
    ('26.2935,73.0169', 'Indian Air Force Jodhpur', 'Rajasthan'),
    ('28.5861,77.3197', 'Indian Air Force Palam', 'Delhi'),
    ('17.4500,78.5000', 'Indian Air Force Hakimpet', 'Telangana'),
    ('16.5075,80.6480', 'Indian Air Force Begumpet', 'Telangana'),
    ('17.7215,83.3159', 'Indian Air Force Visakhapatnam', 'Andhra Pradesh'),
    ('22.5697,88.3697', 'Indian Air Force Barrackpore', 'West Bengal'),
    ('26.3016,78.2370', 'Indian Air Force Agra', 'Uttar Pradesh'),
    ('28.6415,77.2167', 'Indian Air Force Hindon', 'Uttar Pradesh'),
    ('30.1892,78.1752', 'Indian Air Force Dehradun', 'Uttarakhand'),
    ('13.0604,80.2496', 'Indian Air Force Tambaram', 'Tamil Nadu'),
    ('22.3039,70.8022', 'Indian Air Force Bhuj', 'Gujarat'),
    ('17.4524,78.5718', 'Indian Air Force Hakimpet', 'Telangana'),
    ('28.5679,77.1035', 'Indian Air Force Palam', 'Delhi'),
    ('17.4382,78.4074', 'Indian Air Force Hakimpet', 'Telangana'),
    ('28.6456,77.0882', 'Indian Air Force Hindon', 'Uttar Pradesh'),
    ('20.1196,85.5942', 'Indian Air Force Bhubaneswar', 'Odisha'),
    ('17.7262,83.2863', 'Indian Air Force Visakhapatnam', 'Andhra Pradesh'),
    ('28.5623,77.1035', 'Indian Air Force Palam', 'Delhi'),
    ('26.8341,80.9470', 'Indian Air Force Lucknow', 'Uttar Pradesh'),
    ('17.7016,83.2310', 'Indian Air Force Visakhapatnam', 'Andhra Pradesh');
	

INSERT INTO Aircraft (serialno, variant, previousid, aircraftstatus, TOC_date, SOC_date, geographicalcoordinate)
VALUES 
    (1001, 'Su-30MKI', NULL, 'Active', '2002-01-01', NULL, '26.2935,73.0169'),
    (1002, 'Tejas', NULL, 'Active', '2003-05-15', NULL, '28.5861,77.3197'),
    (1003, 'MiG-21', NULL, 'Inactive', '1999-10-20', '2021-06-30', '17.4500,78.5000'),
    (1004, 'Rafale', NULL, 'Active', '1994-02-28', NULL, '16.5075,80.6480'),
    (1005, 'Jaguar', NULL, 'Active', '1992-07-10', NULL, '17.7215,83.3159'),
    (1006, 'C-17 Globemaster', NULL, 'Active', '1993-11-18', NULL, '22.5697,88.3697'),
    (1007, 'MiG-29', NULL, 'Active', '2000-03-05', NULL, '26.3016,78.2370'),
    (1008, 'AH-64 Apache', NULL, 'Active', '1994-01-10', NULL, '28.6415,77.2167'),
    (1009, 'Chinook', NULL, 'Active', '2000-09-25', NULL, '30.1892,78.1752'),
    (1010, 'C-130J Super Hercules', NULL, 'Active', '2000-08-30', NULL, '13.0604,80.2496'),
    (1011, 'Tejas', 957, 'Active', '2003-06-30', NULL, '22.3039,70.8022'),
    (1012, 'Tejas', NULL, 'Active', '2003-06-30', NULL, '17.4524,78.5718'),
    (1013, 'Tejas', NULL, 'Active', '2004-06-30', NULL, '28.5679,77.1035'),
    (1014, 'Tejas', NULL, 'Active', '2007-06-30', NULL, '28.5623,77.1035'),
    (1015, 'Su-30MKI', 952, 'Inctive', '1993-01-01', '2022-12-31', '20.1196,85.5942'),
    (1016, 'Tejas', NULL, 'Active', '1993-06-30', NULL, '28.6415,77.2167'),
    (1017, 'Tejas', NULL, 'Active', '2008-06-30', NULL, '28.5861,77.3197'),
    (1018, 'Tejas', NULL, 'Active', '2006-06-30', NULL, '17.4500,78.5000'),
    (1019, 'Tejas', NULL, 'Active', '2007-06-30', NULL, '26.2935,73.0169'),
    (1020, 'Su-30MKI', NULL, 'Active', '2004-01-01', NULL, '26.3016,78.2370'),
    (1021, 'Tejas', NULL, 'Active', '2005-06-30', NULL, '17.7262,83.2863'),
    (1022, 'Tejas', NULL, 'Active', '2009-06-30', NULL, '17.4382,78.4074'),
    (1023, 'Tejas', 959, 'Active', '1998-06-30', NULL, '28.6415,77.2167'),
    (1024, 'Tejas', NULL, 'Active', '2003-06-30', NULL, '26.8341,80.9470'),
    (1025, 'Tejas', NULL, 'Active', '2005-06-30', NULL, '28.5679,77.1035'),
    (1026, 'Tejas', NULL, 'Active', '2009-06-30', NULL, '16.5075,80.6480'),
    (1027, 'Tejas', NULL, 'Active', '2002-06-30', NULL, '28.5861,77.3197'),
    (1028, 'Tejas', NULL, 'Active', '2001-06-30', NULL, '22.5697,88.3697'),
    (1029, 'Tejas', NULL, 'Active', '2008-06-30', NULL, '17.4500,78.5000'),
    (1030, 'Su-30MKI', 953, 'Inactive', '2000-01-01', '2010-12-31', '28.5861,77.3197'),
    (1031, 'Tejas', NULL, 'Active', '1998-06-30', NULL, '17.4524,78.5718'),
    (1032, 'Tejas', NULL, 'Active', '1993-06-30', NULL, '28.6415,77.2167'),
    (1033, 'Tejas', NULL, 'Active', '1998-06-30', NULL, '28.5861,77.3197'),
    (1034, 'Tejas', 972, 'Active', '1998-06-30', NULL, '26.2935,73.0169'),
    (1035, 'Tejas', NULL, 'Active', '1995-06-30', NULL, '17.7215,83.3159'),
    (1036, 'Tejas', NULL, 'Active', '1994-06-30', NULL, '22.5697,88.3697'),
    (1037, 'Tejas', NULL, 'Active', '1997-06-30', NULL, '28.6415,77.2167'),
    (1038, 'Tejas', NULL, 'Active', '1998-06-30', NULL, '17.4500,78.5000'),
    (1039, 'Tejas', NULL, 'Active', '1998-06-30', NULL, '26.2935,73.0169'),
    (1040, 'Su-30MKI', NULL, 'Active', '1990-01-01', NULL, '28.5861,77.3197'),
	(1041, 'Tejas', NULL, 'Active', '1990-06-30', NULL, '22.5697,88.3697'),
	(1042, 'Tejas', NULL, 'Active', '1999-06-30', NULL, '28.5861,77.3197'),
	(1043, 'Tejas', 959, 'Active', '1992-06-30', NULL, '28.5861,77.3197'),
	(1044, 'Tejas', NULL, 'Active', '2003-06-10', NULL, '17.4524,78.5718'),
	(1045, 'Tejas', NULL, 'Active', '2003-08-30', NULL, '28.6415,77.2167'),
	(1046, 'Tejas', NULL, 'Active', '2003-06-09', NULL, '17.4500,78.5000'),
	(1047, 'Tejas', NULL, 'Active', '2003-12-01', NULL, '26.2935,73.0169'),
	(1048, 'Tejas', NULL, 'Active', '2003-11-30', NULL, '28.5861,77.3197'),
	(1049, 'Tejas', NULL, 'Active', '2003-09-30', NULL, '26.2935,73.0169'),
	(1050, 'Su-30MKI', NULL, 'Active', '2010-01-01', NULL, '28.6415,77.2167'),
	(1051, 'Su-30MKI', 953, 'Active', '2004-01-01', '2022-12-31', '28.5861,77.3197'),
	(1052, 'Tejas', NULL, 'Active', '2005-08-30', NULL, '28.5861,77.3197'),
	(1053, 'Tejas', NULL, 'Active', '2005-06-14', NULL, '17.4500,78.5000'),
	(1054, 'Tejas', NULL, 'Active', '2023-08-30', NULL, '26.2935,73.0169'),
	(1055, 'Su-30MKI', 952, 'Active', '2005-01-01', '2022-12-31', '17.7262,83.2863'),
	(1056, 'Tejas', NULL, 'Active', '2005-06-30', NULL, '28.5861,77.3197'),
	(1057, 'Tejas', NULL, 'Active', '2005-08-14', NULL, '28.5861,77.3197'),
	(1058, 'Tejas', NULL, 'Active', '2005-08-30', NULL, '26.8341,80.9470'),
	(1059, 'Tejas', NULL, 'Active', '2005-08-14', NULL, '17.4382,78.4074'),
	(1060, 'MiG-29', NULL, 'Inactive', '1992-05-10', '2021-07-20', '28.6415,77.2167'),
    (1061, 'Tejas', NULL, 'Inactive', '1995-11-25', '2022-03-15', '17.7262,83.2863'),
    (1062, 'MiG-21', NULL, 'Inactive', '1995-12-20', '2021-08-30', '22.5697,88.3697'),
    (1063, 'Rafale', NULL, 'Inactive', '1995-02-28', '2023-01-10', '17.4500,78.5000'),
    (1064, 'Chinook', NULL, 'Inactive', '1994-06-12', '2022-04-05', '28.5861,77.3197'),
    (1065, 'AH-64 Apache', NULL, 'Inactive', '1994-09-30', '2022-06-20', '17.4524,78.5718'),
    (1066, 'Tejas', NULL, 'Inactive', '1995-07-19', '2022-02-28', '26.3016,78.2370'),
    (1067, 'MiG-29', NULL, 'Inactive', '1994-03-08', '2021-09-15', '17.7215,83.3159'),
    (1068, 'C-17 Globemaster', NULL, 'Inactive', '1994-11-28', '2023-01-01', '20.1196,85.5942'),
    (1069, 'Tejas', NULL, 'Inactive', '1995-09-25', '2022-05-20', '28.5679,77.1035'),
    (1070, 'Su-30MKI', NULL, 'Inactive', '1994-08-15', '2022-05-30', '26.8341,80.9470'),
	(1071, 'MiG-21', NULL, 'Active', '1994-01-01', NULL, '17.4500,78.5000'),
	(1072, 'Tejas', NULL, 'Active', '1994-05-15', NULL, '28.5861,77.3197'),
	(1073, 'MiG-21', NULL, 'Inactive', '2009-10-20', '2021-06-30', '26.2935,73.0169'),
	(1074, 'Rafale', NULL, 'Active', '2004-02-28', NULL, '17.4524,78.5718'),
	(1075, 'Jaguar', NULL, 'Active', '2002-07-10', NULL, '22.5697,88.3697'),
	(1076, 'C-17 Globemaster', NULL, 'Active', '2003-11-18', NULL, '17.7215,83.3159'),
	(1077, 'MiG-29', NULL, 'Active', '2001-03-05', NULL, '28.6415,77.2167'),
	(1078, 'AH-64 Apache', NULL, 'Active', '2004-01-10', NULL, '26.3016,78.2370'),
	(1079, 'Chinook', NULL, 'Active', '2002-09-25', NULL, '13.0604,80.2496'),
    (1080, 'Jaguar', NULL, 'Inactive', '2001-01-10', '2022-08-28', '13.0604,80.2496'),
	(1081, 'C-130J Super Hercules', NULL, 'Active', '2003-08-30', NULL, '20.1196,85.5942'),
	(1082, 'Tejas', 957, 'Active', '2003-06-30', NULL, '28.5861,77.3197');


INSERT INTO unit (unitname, unittype, doe) VALUES 
('No.1 Squadron', 'flying', '1992-08-12'),
('No.2 Squadron', 'flying', '1994-04-25'),
('No.3 Squadron', 'flying', '1995-09-30'),
('No.4 Squadron', 'flying', '1996-11-18'),
('No.5 Squadron', 'flying', '1998-02-20');

INSERT INTO unit (unitname, unittype, doe) VALUES 
('No.34 Squadron', 'missile', '1992-07-15'),
('No.46 Squadron', 'missile', '1994-03-28'),
('No.58 Squadron', 'missile', '1995-10-10'),
('No.60 Squadron', 'missile', '1997-12-22'),
('No.61 Squadron', 'missile', '1999-02-10');

INSERT INTO unit (unitname, unittype, doe) VALUES 
('254 Signal Unit', 'signal', '1991-06-03'),
('12 Signal Unit', 'signal', '1993-09-18'),
('35 Signal Unit', 'signal', '1995-01-23'),
('55 Signal Unit', 'signal', '1997-04-07'),
('149 Signal Unit', 'signal', '1999-08-14');

INSERT INTO unit (unitname, unittype, doe) VALUES 
('1 Wing', 'operational bases', '1993-08-22'),
('2 Wing', 'operational bases', '1995-11-05'),
('3 Wing', 'operational bases', '1997-02-20'),
('4 Wing', 'operational bases', '1999-06-07'),
('5 Wing', 'operational bases', '2001-09-19');

INSERT INTO unit (unitname, unittype, doe) VALUES 
('AFS Chakeri', 'maintenance&logistics', '1990-12-03'),
('1 Base Repair Depot', 'maintenance&logistics', '1992-05-18'),
('2 Base Repair Depot', 'maintenance&logistics', '1994-08-23'),
('3 Base Repair Depot', 'maintenance&logistics', '1996-11-05'),
('4 Base Repair Depot', 'maintenance&logistics', '1998-02-17');

INSERT INTO unit (unitname, unittype, doe) VALUES 
('Western Air Command', 'command', '1991-04-15'),
('Eastern Air Command', 'command', '1993-06-28'),
('Central Air Command', 'command', '1995-09-10'),
('Southern Air Command', 'command', '1997-12-22'),
('South Western Air Command', 'command', '1999-04-05');

insert into course values('35BCC','Branch Commission - Tech','1995');
insert into course values('1TBCC','Branch Commission - Tech','1997');
insert into course values('2TBCC','Branch Commission - Tech','1991');
insert into course values('3TBCC','Branch Commission - Tech','1994');
insert into course values('5TBCC','Branch Commission - Tech','1996');

insert into course values('001NTBC','Branch Commission - Tech','2000');
insert into course values('002NTBC','Branch Commission - Tech','2005');
insert into course values('004NTBC','Branch Commission - Tech','2003');
insert into course values('033NTBC','Branch Commission - Tech','1998');
insert into course values('053NTBC','Branch Commission - Tech','2001');

insert into course values('82NAV','Navigators - Permanent Commission','2000');
insert into course values('98NAV','Navigators - Permanent Commission','2003');
insert into course values('100NAV','Navigators - Permanent Commission','1997');
insert into course values('87NAV','Navigators - Permanent Commission','2008');
insert into course values('83NAV','Navigators - Permanent Commission','2002');

insert into course values('82NAV(M)','Navs - Short Service Commission - Men','1993');
insert into course values('98NAV(M)','Navs - Short Service Commission - Men','1995');
insert into course values('43NAV(W)','Navs - Short Service Commission - Women','2009');
insert into course values('202NAV(W)','Navs - Short Service Commission - Women','2006');
insert into course values('205NAV(W)','Navs - Short Service Commission - Women','2007');

insert into course values('20DEO','Aeronautical Engineering - Permanent Commission','1992');
insert into course values('30DEO','Aeronautical Engineering - Permanent Commission','2000');
insert into course values('49DEO','Aeronautical Engineering - Permanent Commission','1994');
insert into course values('8AEC','Aeronautical Engineering - Permanent Commission','1999');
insert into course values('20AEC','Aeronautical Engineering - Permanent Commission','2008');

insert into course values('11GDOC','Ground Duties - Permanent Commission','1991');
insert into course values('12GDOC','Ground Duties - Permanent Commission','1997');
insert into course values('13GDOC','Ground Duties - Permanent Commission','1995');
insert into course values('14GDOC','Ground Duties - Permanent Commission','2004');
insert into course values('1ExNDAADM','Ground Duties - Permanent Commission','2007');

insert into course values('1ssc(W)FP','Pilots - Short Service Commission - Women','2002');
insert into course values('4ssc(W)FP','Pilots - Short Service Commission - Women','2003');
insert into course values('7ssc(W)FP','Pilots - Short Service Commission - Women','2005');
insert into course values('20ssc(W)FP','Pilots - Short Service Commission - Women','1993');
insert into course values('21ssc(W)FP','Pilots - Short Service Commission - Women','1992');

insert into course values('1ssc(M)FP','Pilots - Short Service Commission - Men','2001');
insert into course values('3ssc(M)FP','Pilots - Short Service Commission - Men','2007');
insert into course values('5ssc(M)FP','Pilots - Short Service Commission - Men','2004');
insert into course values('8ssc(M)FP','Pilots - Short Service Commission - Men','2008');
insert into course values('10ssc(M)FP','Pilots - Short Service Commission - Men','2006');


INSERT INTO Soldier (sid, sname, rank, DOB, DOC, DOR, courseid, year, unitname, unittype, remark, contactno, gender, addressline, city, "state", pincode, maritalstatus, emergencycontact)
VALUES
    (199001, 'Vikas Singh', 'Wing Commander', '1970-09-25', '1995-12-03', '2015-09-25', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543278', 'Male', '6262 Air Force Street', 'Mumbai', 'Maharashtra', '400015', 'Married', '9876543279'),

    (199002, 'Anita Kumar', 'Group Captain', '1975-12-20', '2005-02-10', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543279', 'Female', '6363 Air Force Road', 'Delhi', 'Delhi', '110015', 'Single', '9876543280'),

    (199003, 'Alok Sharma', 'Squadron Leader', '1980-01-05', '2010-04-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543280', 'Male', '6464 Air Force Lane', 'Chennai', 'Tamil Nadu', '600015', 'Married', '9876543281'),

    (199004, 'Priya Patel', 'Flight Lieutenant', '1985-03-12', '1995-05-28', '2015-03-12', '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying','resigned', '9876543281', 'Female', '6565 Air Force Enclave', 'Kolkata', 'West Bengal', '700015', 'Single', '9876543282'),

    (199005, 'Rajiv Gupta', 'Flying Officer', '1990-06-18', '2000-08-30', '2020-06-18', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543282', 'Male', '6666 Air Force Avenue', 'Hyderabad', 'Telangana', '500015', 'Married', '9876543283'),

    (199006, 'Sunita Singh', 'Wing Commander', '1972-10-15', '1998-11-20', '2018-10-15', '001NTBC', '2000', 'No.34 Squadron', 'missile', 'resigned', '9876543283', 'Female', '6767 Air Force Street', 'Mumbai', 'Maharashtra', '400016', 'Married', '9876543284'),

    (199007, 'Amit Kumar', 'Group Captain', '1978-01-30', '2003-02-25', '2023-01-30', '002NTBC', '2005', 'No.46 Squadron', 'missile', NULL, '9876543284', 'Male', '6868 Air Force Road', 'Delhi', 'Delhi', '110016', 'Single', '9876543285'),

    (199008, 'Ritu Sharma', 'Squadron Leader', '1982-04-28', '2008-06-10', NULL, '004NTBC', '2003', 'No.58 Squadron', 'missile', NULL, '9876543285', 'Female', '6969 Air Force Lane', 'Chennai', 'Tamil Nadu', '600016', 'Married', '9876543286'),

    (199009, 'Vikram Patel', 'Flight Lieutenant', '1987-07-05', '2013-08-20',NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543286', 'Male', '7070 Air Force Enclave', 'Kolkata', 'West Bengal', '700016', 'Single', '9876543287'),

    (199010, 'Anjali Gupta', 'Flying Officer', '1992-09-10', '1998-10-05', '2018-09-10', '053NTBC', '2001', 'No.61 Squadron', 'missile', 'Death', '9876543287', 'Female', '7171 Air Force Avenue', 'Hyderabad', 'Telangana', '500016', 'Married', '9876543288'),

    (199011, 'Naveen Singh', 'Wing Commander', '1971-11-28', '1997-01-15', '2017-11-28', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543288', 'Male', '7272 Air Force Street', 'Mumbai', 'Maharashtra', '400017', 'Married', '9876543289'),

    (199012, 'Anu Kumar', 'Group Captain', '1976-02-14', '2006-03-05', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543289', 'Female', '7373 Air Force Road', 'Delhi', 'Delhi', '110017', 'Single', '9876543290'),
    (199013, 'Rajesh Sharma', 'Squadron Leader', '1981-05-20', '2011-07-08', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543290', 'Male', '7474 Air Force Lane', 'Chennai', 'Tamil Nadu', '600017', 'Married', '9876543291'),
    (199014, 'Pooja Patel', 'Flight Lieutenant', '1986-08-25', '1996-10-15', '2016-08-25', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', 'Death', '9876543291', 'Female', '7575 Air Force Enclave', 'Kolkata', 'West Bengal', '700017', 'Single', '9876543292'),
    (199015, 'Vishal Gupta', 'Flying Officer', '1991-12-01', '2001-01-28', '2021-12-01', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543292', 'Male', '7676 Air Force Avenue', 'Hyderabad', 'Telangana', '500017', 'Married', '9876543293'),
    (199016, 'Sneha Singh', 'Wing Commander', '1973-02-28', '1999-04-10', '2019-02-28', '35BCC', '1995', '1 Wing', 'operational bases', NULL, '9876543293', 'Female', '7777 Air Force Street', 'Mumbai', 'Maharashtra', '400018', 'Married', '9876543294'),
    (199017, 'Rahul Kumar', 'Group Captain', '1977-06-15', '2004-07-20', NULL, '1TBCC', '1997', '2 Wing', 'operational bases', NULL, '9876543294', 'Male', '7878 Air Force Road', 'Delhi', 'Delhi', '110018', 'Single', '9876543295'),
    (199018, 'Preeti Sharma', 'Squadron Leader', '1983-09-05', '2009-11-28', NULL, '82NAV', '2000', '3 Wing', 'operational bases', NULL, '9876543295', 'Female', '7979 Air Force Lane', 'Chennai', 'Tamil Nadu', '600018', 'Married', '9876543296'),
    (199019, 'Arun Patel', 'Flight Lieutenant', '1988-11-10', '2014-01-05', NULL, '1ssc(W)FP', '2002', '4 Wing', 'operational bases', NULL, '9876543296', 'Male', '8080 Air Force Enclave', 'Kolkata', 'West Bengal', '700018', 'Single', '9876543297'),
    (199020, 'Simran Gupta', 'Flying Officer', '1993-01-15', '1999-03-22', '2019-01-15', '82NAV(M)', '1993', '5 Wing', 'operational bases', NULL, '9876543297', 'Female', '8181 Air Force Avenue', 'Hyderabad', 'Telangana', '500018', 'Married', '9876543298'),
    (199021, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics','resigned', '9876543298', 'Male', '8282 Air Force Street', 'Mumbai', 'Maharashtra', '400019', 'Married', '9876543299'),
    (199022, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28',NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543299', 'Female', '8383 Air Force Road', 'Delhi', 'Delhi', '110019', 'Single', '9876543300'),

    (199023, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543300', 'Male', '8484 Air Force Lane', 'Chennai', 'Tamil Nadu', '600019', 'Married', '9876543301'),

    (199024, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543301', 'Female', '8585 Air Force Enclave', 'Kolkata', 'West Bengal', '700019', 'Single', '9876543302'),

    (199025, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543302', 'Male', '8686 Air Force Avenue', 'Hyderabad', 'Telangana', '500019', 'Married', '9876543303'),

    (199026, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543303', 'Male', '8787 Air Force Street', 'Mumbai', 'Maharashtra', '400020', 'Married', '9876543304'),

    (199027, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543304', 'Female', '8888 Air Force Road', 'Delhi', 'Delhi', '110020', 'Single', '9876543305'),

    (199028, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543305', 'Male', '8989 Air Force Lane', 'Chennai', 'Tamil Nadu', '600020', 'Married', '9876543306'),

    (199029, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28', NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543306', 'Female', '9090 Air Force Enclave', 'Kolkata', 'West Bengal', '700020', 'Single', '9876543307'),

    (199030, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543307', 'Male', '9191 Air Force Avenue', 'Hyderabad', 'Telangana', '500020', 'Married', '9876543308'),

    (199031, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543308', 'Male', '9292 Air Force Street', 'Mumbai', 'Maharashtra', '400021', 'Married', '9876543309'),

    (199032, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28',NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543309', 'Female', '9393 Air Force Road', 'Delhi', 'Delhi', '110021', 'Single', '9876543310'),

    (199033, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543310', 'Male', '9494 Air Force Lane', 'Chennai', 'Tamil Nadu', '600021', 'Married', '9876543311'),

    (199034, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10', NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543311', 'Female', '9595 Air Force Enclave', 'Kolkata', 'West Bengal', '700021', 'Single', '9876543312'),

    (199035, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543312', 'Male', '9696 Air Force Avenue', 'Hyderabad', 'Telangana', '500021', 'Married', '9876543313'),

    (199036, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543313', 'Male', '9797 Air Force Street', 'Mumbai', 'Maharashtra', '400022', 'Married', '9876543314'),

    (199037, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', 'Death', '9876543314', 'Female', '9898 Air Force Road', 'Delhi', 'Delhi', '110022', 'Single', '9876543315'),

    (199038, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543315', 'Male', '9999 Air Force Lane', 'Chennai', 'Tamil Nadu', '600022', 'Married', '9876543316'),

    (199039, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10',NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543316', 'Female', '10101 Air Force Enclave', 'Kolkata', 'West Bengal', '700022', 'Single', '9876543317'),

    (199040, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile','resigned', '9876543317', 'Male', '10202 Air Force Avenue', 'Hyderabad', 'Telangana', '500022', 'Married', '9876543318'),

    (199041, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543318', 'Female', '10303 Air Force Street', 'Mumbai', 'Maharashtra', '400023', 'Married', '9876543319'),

    (199042, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543319', 'Male', '10404 Air Force Road', 'Delhi', 'Delhi', '110023', 'Single', '9876543320'),

    (199043, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15',NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543320', 'Female', '10505 Air Force Lane', 'Chennai', 'Tamil Nadu', '600023', 'Married', '9876543321'),

    (199044, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', 'Death', '9876543321', 'Male', '10606 Air Force Enclave', 'Kolkata', 'West Bengal', '700023', 'Single', '9876543322'),

    (199045, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543322', 'Female', '10707 Air Force Avenue', 'Hyderabad', 'Telangana', '500023', 'Married', '9876543323'),

    (199046, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', 'resigned', '9876543323', 'Male', '10808 Air Force Street', 'Mumbai', 'Maharashtra', '400024', 'Married', '9876543324'),

    (199047, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543324', 'Female', '10909 Air Force Road', 'Delhi', 'Delhi', '110024', 'Single', '9876543325'),

    (199048, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543325', 'Male', '11010 Air Force Lane', 'Chennai', 'Tamil Nadu', '600024', 'Married', '9876543326'),

    (199049, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543326', 'Female', '11111 Air Force Enclave', 'Kolkata', 'West Bengal', '700024', 'Single', '9876543327'),

    (199050, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543327', 'Male', '11212 Air Force Avenue', 'Hyderabad', 'Telangana', '500024', 'Married', '9876543328'),

    (199051, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543328', 'Male', '11313 Air Force Street', 'Mumbai', 'Maharashtra', '400025', 'Married', '9876543329'),

    (199052, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543329', 'Female', '11414 Air Force Road', 'Delhi', 'Delhi', '110025', 'Single', '9876543330'),

    (199053, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10',NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543330', 'Male', '11515 Air Force Lane', 'Chennai', 'Tamil Nadu', '600025', 'Married', '9876543331'),

    (199054, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28', NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543331', 'Female', '11616 Air Force Enclave', 'Kolkata', 'West Bengal', '700025', 'Single', '9876543332'),

    (199055, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', 'resigned', '9876543332', 'Male', '11717 Air Force Avenue', 'Hyderabad', 'Telangana', '500025', 'Married', '9876543333'),

    (199056, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543333', 'Male', '11818 Air Force Street', 'Mumbai', 'Maharashtra', '400026', 'Married', '9876543334'),

    (199057, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543334', 'Female', '11919 Air Force Road', 'Delhi', 'Delhi', '110026', 'Single', '9876543335'),

    (199058, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15',NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543335', 'Male', '12020 Air Force Lane', 'Chennai', 'Tamil Nadu', '600026', 'Married', '9876543336'),

    (199059, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10', NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543336', 'Female', '12121 Air Force Enclave', 'Kolkata', 'West Bengal', '700026', 'Single', '9876543337'),

    (199060, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', 'Death', '9876543337', 'Male', '12222 Air Force Avenue', 'Hyderabad', 'Telangana', '500026', 'Married', '9876543338'),


    (199061, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543338', 'Male', '12323 Air Force Street', 'Mumbai', 'Maharashtra', '400027', 'Married', '9876543339'),

    (199062, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543339', 'Female', '12424 Air Force Road', 'Delhi', 'Delhi', '110027', 'Single', '9876543340'),

    (199063, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543340', 'Male', '12525 Air Force Lane', 'Chennai', 'Tamil Nadu', '600027', 'Married', '9876543341'),

    (199064, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543341', 'Female', '12626 Air Force Enclave', 'Kolkata', 'West Bengal', '700027', 'Single', '9876543342'),

    (199065, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543342', 'Male', '12727 Air Force Avenue', 'Hyderabad', 'Telangana', '500027', 'Married', '9876543343'),

    (199066, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543343', 'Female', '12828 Air Force Street', 'Mumbai', 'Maharashtra', '400028', 'Married', '9876543344'),

    (199067, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10',NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543344', 'Male', '12929 Air Force Road', 'Delhi', 'Delhi', '110028', 'Single', '9876543345'),

    (199068, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543345', 'Female', '13030 Air Force Lane', 'Chennai', 'Tamil Nadu', '600028', 'Married', '9876543346'),

    (199069, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543346', 'Male', '13131 Air Force Enclave', 'Kolkata', 'West Bengal', '700028', 'Single', '9876543347'),

    (199070, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', 'resigned', '9876543347', 'Female', '13232 Air Force Avenue', 'Hyderabad', 'Telangana', '500028', 'Married', '9876543348'),

    (199071, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543348', 'Male', '13333 Air Force Street', 'Mumbai', 'Maharashtra', '400029', 'Married', '9876543349'),

    (199072, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543349', 'Female', '13434 Air Force Road', 'Delhi', 'Delhi', '110029', 'Single', '9876543350'),

    (199073, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543350', 'Male', '13535 Air Force Lane', 'Chennai', 'Tamil Nadu', '600029', 'Married', '9876543351'),

    (199074, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543351', 'Female', '13636 Air Force Enclave', 'Kolkata', 'West Bengal', '700029', 'Single', '9876543352'),

    (199075, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543352', 'Male', '13737 Air Force Avenue', 'Hyderabad', 'Telangana', '500029', 'Married', '9876543353'),

    (199076, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', 'resigned', '9876543353', 'Male', '13838 Air Force Street', 'Mumbai', 'Maharashtra', '400030', 'Married', '9876543354'),

    (199077, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543354', 'Female', '13939 Air Force Road', 'Delhi', 'Delhi', '110030', 'Single', '9876543355'),

    (199078, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543355', 'Male', '14040 Air Force Lane', 'Chennai', 'Tamil Nadu', '600030', 'Married', '9876543356'),

    (199079, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28', NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543356', 'Female', '14141 Air Force Enclave', 'Kolkata', 'West Bengal', '700030', 'Single', '9876543357'),

    (199080, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543357', 'Male', '14242 Air Force Avenue', 'Hyderabad', 'Telangana', '500030', 'Married', '9876543358'),

    (199081, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543358', 'Male', '14343 Air Force Street', 'Mumbai', 'Maharashtra', '400031', 'Married', '9876543359'),

    (199082, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28',NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543359', 'Female', '14444 Air Force Road', 'Delhi', 'Delhi', '110031', 'Single', '9876543360'),

    (199083, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15',NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543360', 'Male', '14545 Air Force Lane', 'Chennai', 'Tamil Nadu', '600031', 'Married', '9876543361'),
    (199084, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10',NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543361', 'Female', '14646 Air Force Enclave', 'Kolkata', 'West Bengal', '700031', 'Single', '9876543362'),
    (199085, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543362', 'Male', '14747 Air Force Avenue', 'Hyderabad', 'Telangana', '500031', 'Married', '9876543363'),
    (199086, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543363', 'Male', '14848 Air Force Street', 'Mumbai', 'Maharashtra', '400032', 'Married', '9876543364'),
    (199087, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543364', 'Female', '14949 Air Force Road', 'Delhi', 'Delhi', '110032', 'Single', '9876543365'),
    (199088, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543365', 'Male', '15050 Air Force Lane', 'Chennai', 'Tamil Nadu', '600032', 'Married', '9876543366'),
    (199089, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543366', 'Female', '15151 Air Force Enclave', 'Kolkata', 'West Bengal', '700032', 'Single', '9876543367'),
    (199090, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543367', 'Male', '15252 Air Force Avenue', 'Hyderabad', 'Telangana', '500032', 'Married', '9876543368'),
    (199091, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543368', 'Female', '15353 Air Force Street', 'Mumbai', 'Maharashtra', '400033', 'Married', '9876543369'),
    (199092, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543369', 'Male', '15454 Air Force Road', 'Delhi', 'Delhi', '110033', 'Single', '9876543370'),
    (199093, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543370', 'Female', '15555 Air Force Lane', 'Chennai', 'Tamil Nadu', '600033', 'Married', '9876543371'),
    (199094, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543371', 'Male', '15656 Air Force Enclave', 'Kolkata', 'West Bengal', '700033', 'Single', '9876543372'),
    (199095, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543372', 'Female', '15757 Air Force Avenue', 'Hyderabad', 'Telangana', '500033', 'Married', '9876543373'),
    (199096, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543373', 'Male', '15858 Air Force Street', 'Mumbai', 'Maharashtra', '400034', 'Married', '9876543374'),
    (199097, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543374', 'Female', '15959 Air Force Road', 'Delhi', 'Delhi', '110034', 'Single', '9876543375'),
    (199098, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03',NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543375', 'Male', '16060 Air Force Lane', 'Chennai', 'Tamil Nadu', '600034', 'Married', '9876543376'),
    (199099, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543376', 'Female', '16161 Air Force Enclave', 'Kolkata', 'West Bengal', '700034', 'Single', '9876543377'),
    (199100, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543377', 'Male', '16262 Air Force Avenue', 'Hyderabad', 'Telangana', '500034', 'Married', '9876543378'),
    (199101, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543378', 'Male', '16363 Air Force Street', 'Mumbai', 'Maharashtra', '400035', 'Married', '9876543379'),
    (199102, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543379', 'Female', '16464 Air Force Road', 'Delhi', 'Delhi', '110035', 'Single', '9876543380'),
    (199103, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543380', 'Male', '16565 Air Force Lane', 'Chennai', 'Tamil Nadu', '600035', 'Married', '9876543381'),
    (199104, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28',NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543381', 'Female', '16666 Air Force Enclave', 'Kolkata', 'West Bengal', '700035', 'Single', '9876543382'),
    (199105, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543382', 'Male', '16767 Air Force Avenue', 'Hyderabad', 'Telangana', '500035', 'Married', '9876543383'),
    (199106, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543383', 'Male', '16868 Air Force Street', 'Mumbai', 'Maharashtra', '400036', 'Married', '9876543384'),
    (199107, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543384', 'Female', '16969 Air Force Road', 'Delhi', 'Delhi', '110036', 'Single', '9876543385'),
    (199108, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543385', 'Male', '17070 Air Force Lane', 'Chennai', 'Tamil Nadu', '600036', 'Married', '9876543386'),
    (199109, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10',NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543386', 'Female', '17171 Air Force Enclave', 'Kolkata', 'West Bengal', '700036', 'Single', '9876543387'),
    (199110, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543387', 'Male', '17272 Air Force Avenue', 'Hyderabad', 'Telangana', '500036', 'Married', '9876543388'),
    (199111, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543388', 'Male', '17373 Air Force Street', 'Mumbai', 'Maharashtra', '400037', 'Married', '9876543389'),
    (199112, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543389', 'Female', '17474 Air Force Road', 'Delhi', 'Delhi', '110037', 'Single', '9876543390'),
    (199113, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543390', 'Male', '17575 Air Force Lane', 'Chennai', 'Tamil Nadu', '600037', 'Married', '9876543391'),
    (199114, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543391', 'Female', '17676 Air Force Enclave', 'Kolkata', 'West Bengal', '700037', 'Single', '9876543392'),
    (199115, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543392', 'Male', '17777 Air Force Avenue', 'Hyderabad', 'Telangana', '500037', 'Married', '9876543393'),
    (199116, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543393', 'Female', '17878 Air Force Street', 'Mumbai', 'Maharashtra', '400038', 'Married', '9876543394'),
    (199117, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10',NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543394', 'Male', '17979 Air Force Road', 'Delhi', 'Delhi', '110038', 'Single', '9876543395'),
    (199118, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543395', 'Female', '18080 Air Force Lane', 'Chennai', 'Tamil Nadu', '600038', 'Married', '9876543396'),
    (199119, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543396', 'Male', '18181 Air Force Enclave', 'Kolkata', 'West Bengal', '700038', 'Single', '9876543397'),
    (199120, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543397', 'Female', '18282 Air Force Avenue', 'Hyderabad', 'Telangana', '500038', 'Married', '9876543398'),
    (199121, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543398', 'Male', '18383 Air Force Street', 'Mumbai', 'Maharashtra', '400039', 'Married', '9876543399'),
    (199122, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543399', 'Female', '18484 Air Force Road', 'Delhi', 'Delhi', '110039', 'Single', '9876543400'),
    (199123, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543400', 'Male', '18585 Air Force Lane', 'Chennai', 'Tamil Nadu', '600039', 'Married', '9876543401'),
    (199124, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543401', 'Female', '18686 Air Force Enclave', 'Kolkata', 'West Bengal', '700039', 'Single', '9876543402'),
    (199125, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543402', 'Male', '18787 Air Force Avenue', 'Hyderabad', 'Telangana', '500039', 'Married', '9876543403'),
    (199126, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543403', 'Male', '18888 Air Force Street', 'Mumbai', 'Maharashtra', '400040', 'Married', '9876543404'),
    (199127, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543404', 'Female', '18989 Air Force Road', 'Delhi', 'Delhi', '110040', 'Single', '9876543405'),
    (199128, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543405', 'Male', '19090 Air Force Lane', 'Chennai', 'Tamil Nadu', '600040', 'Married', '9876543406'),
    (199129, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28',NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543406', 'Female', '19191 Air Force Enclave', 'Kolkata', 'West Bengal', '700040', 'Single', '9876543407'),
    (199130, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543407', 'Male', '19292 Air Force Avenue', 'Hyderabad', 'Telangana', '500040', 'Married', '9876543408'),
    (199131, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543408', 'Male', '19393 Air Force Street', 'Mumbai', 'Maharashtra', '400041', 'Married', '9876543409'),
    (199132, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543409', 'Female', '19494 Air Force Road', 'Delhi', 'Delhi', '110041', 'Single', '9876543410'),
    (199133, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543410', 'Male', '19595 Air Force Lane', 'Chennai', 'Tamil Nadu', '600041', 'Married', '9876543411'),
    (199134, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10', NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543411', 'Female', '19696 Air Force Enclave', 'Kolkata', 'West Bengal', '700041', 'Single', '9876543412'),
    (199135, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543412', 'Male', '19797 Air Force Avenue', 'Hyderabad', 'Telangana', '500041', 'Married', '9876543413'),
    (199136, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543413', 'Male', '19898 Air Force Street', 'Mumbai', 'Maharashtra', '400042', 'Married', '9876543414'),
    (199137, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543414', 'Female', '19999 Air Force Road', 'Delhi', 'Delhi', '110042', 'Single', '9876543415'),
    (199138, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543415', 'Male', '20000 Air Force Lane', 'Chennai', 'Tamil Nadu', '600042', 'Married', '9876543416'),
    (199139, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543416', 'Female', '20101 Air Force Enclave', 'Kolkata', 'West Bengal', '700042', 'Single', '9876543417'),
    (199140, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543417', 'Male', '20202 Air Force Avenue', 'Hyderabad', 'Telangana', '500042', 'Married', '9876543418'),
    (199141, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543418', 'Female', '20303 Air Force Street', 'Mumbai', 'Maharashtra', '400043', 'Married', '9876543419'),
    (199142, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543419', 'Male', '20404 Air Force Road', 'Delhi', 'Delhi', '110043', 'Single', '9876543420'),
    (199143, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543420', 'Female', '20505 Air Force Lane', 'Chennai', 'Tamil Nadu', '600043', 'Married', '9876543421'),
    (199144, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543421', 'Male', '20606 Air Force Enclave', 'Kolkata', 'West Bengal', '700043', 'Single', '9876543422'),
    (199145, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543422', 'Female', '20707 Air Force Avenue', 'Hyderabad', 'Telangana', '500043', 'Married', '9876543423'),
    (199146, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543423', 'Male', '20808 Air Force Street', 'Mumbai', 'Maharashtra', '400044', 'Married', '9876543424'),
    (199147, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543424', 'Female', '20909 Air Force Road', 'Delhi', 'Delhi', '110044', 'Single', '9876543425'),
    (199148, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543425', 'Male', '21010 Air Force Lane', 'Chennai', 'Tamil Nadu', '600044', 'Married', '9876543426'),
    (199149, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10', NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543426', 'Female', '21111 Air Force Enclave', 'Kolkata', 'West Bengal', '700044', 'Single', '9876543427'),
    (199150, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543427', 'Male', '21212 Air Force Avenue', 'Hyderabad', 'Telangana', '500044', 'Married', '9876543428'),
    (199151, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543428', 'Male', '21313 Air Force Street', 'Mumbai', 'Maharashtra', '400045', 'Married', '9876543429'),
    (199152, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543429', 'Female', '21414 Air Force Road', 'Delhi', 'Delhi', '110045', 'Single', '9876543430'),
    (199153, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543430', 'Male', '21515 Air Force Lane', 'Chennai', 'Tamil Nadu', '600045', 'Married', '9876543431'),
    (199154, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28',NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543431', 'Female', '21616 Air Force Enclave', 'Kolkata', 'West Bengal', '700045', 'Single', '9876543432'),
    (199155, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543432', 'Male', '21717 Air Force Avenue', 'Hyderabad', 'Telangana', '500045', 'Married', '9876543433'),
    (199156, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543433', 'Male', '21818 Air Force Street', 'Mumbai', 'Maharashtra', '400046', 'Married', '9876543434'),
    (199157, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543434', 'Female', '21919 Air Force Road', 'Delhi', 'Delhi', '110046', 'Single', '9876543435'),
    (199158, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543435', 'Male', '22020 Air Force Lane', 'Chennai', 'Tamil Nadu', '600046', 'Married', '9876543436'),
    (199159, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10', NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543436', 'Female', '22121 Air Force Enclave', 'Kolkata', 'West Bengal', '700046', 'Single', '9876543437'),
    (199160, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543437', 'Male', '22222 Air Force Avenue', 'Hyderabad', 'Telangana', '500046', 'Married', '9876543438'),
    (199161, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543438', 'Male', '22323 Air Force Street', 'Mumbai', 'Maharashtra', '400047', 'Married', '9876543439'),
    (199162, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543439', 'Female', '22424 Air Force Road', 'Delhi', 'Delhi', '110047', 'Single', '9876543440'),
    (199163, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543440', 'Male', '22525 Air Force Lane', 'Chennai', 'Tamil Nadu', '600047', 'Married', '9876543441'),
    (199164, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543441', 'Female', '22626 Air Force Enclave', 'Kolkata', 'West Bengal', '700047', 'Single', '9876543442'),
    (199165, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543442', 'Male', '22727 Air Force Avenue', 'Hyderabad', 'Telangana', '500047', 'Married', '9876543443'),
    (199166, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543443', 'Female', '22828 Air Force Street', 'Mumbai', 'Maharashtra', '400048', 'Married', '9876543444'),
    (199167, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543444', 'Male', '22929 Air Force Road', 'Delhi', 'Delhi', '110048', 'Single', '9876543445'),
    (199168, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15', NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543445', 'Female', '23030 Air Force Lane', 'Chennai', 'Tamil Nadu', '600048', 'Married', '9876543446'),
    (199169, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543446', 'Male', '23131 Air Force Enclave', 'Kolkata', 'West Bengal', '700048', 'Single', '9876543447'),
    (199170, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543447', 'Female', '23232 Air Force Avenue', 'Hyderabad', 'Telangana', '500048', 'Married', '9876543448'),
    (199171, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543448', 'Male', '23333 Air Force Street', 'Mumbai', 'Maharashtra', '400049', 'Married', '9876543449'),
    (199172, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28',NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543449', 'Female', '23434 Air Force Road', 'Delhi', 'Delhi', '110049', 'Single', '9876543450'),
    (199173, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03',NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543450', 'Male', '23535 Air Force Lane', 'Chennai', 'Tamil Nadu', '600049', 'Married', '9876543451'),
    (199174, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10',NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543451', 'Female', '23636 Air Force Enclave', 'Kolkata', 'West Bengal', '700049', 'Single', '9876543452'),
    (199175, 'Rahul Gupta', 'Flying Officer', '1994-02-28', '2000-04-15', '2020-02-28', '82NAV(M)', '1993', '4 Base Repair Depot', 'maintenance&logistics', NULL, '9876543452', 'Male', '23737 Air Force Avenue', 'Hyderabad', 'Telangana', '500049', 'Married', '9876543453'),
    (199176, 'Arun Singh', 'Wing Commander', '1975-05-12', '2001-07-25', '2021-05-12', '35BCC', '1995', 'Western Air Command', 'command', NULL, '9876543453', 'Male', '23838 Air Force Street', 'Mumbai', 'Maharashtra', '400050', 'Married', '9876543454'),
    (199177, 'Anjali Kumari', 'Group Captain', '1980-08-20', '2006-10-05', NULL, '1TBCC', '1997', 'Eastern Air Command', 'command', NULL, '9876543454', 'Female', '23939 Air Force Road', 'Delhi', 'Delhi', '110050', 'Single', '9876543455'),
    (199178, 'Rakesh Sharma', 'Squadron Leader', '1985-10-28', '2011-12-10', NULL, '82NAV', '2000', 'Central Air Command', 'command', NULL, '9876543455', 'Male', '24040 Air Force Lane', 'Chennai', 'Tamil Nadu', '600050', 'Married', '9876543456'),
    (199179, 'Preeti Patel', 'Flight Lieutenant', '1990-01-15', '2016-03-28', NULL, '1ssc(W)FP', '2002', 'Southern Air Command', 'command', NULL, '9876543456', 'Female', '24141 Air Force Enclave', 'Kolkata', 'West Bengal', '700050', 'Single', '9876543457'),
    (199180, 'Sachin Gupta', 'Flying Officer', '1995-03-20', '2001-05-30', '2021-03-20', '82NAV(M)', '1993', 'South Western Air Command', 'command', NULL, '9876543457', 'Male', '24242 Air Force Avenue', 'Hyderabad', 'Telangana', '500050', 'Married', '9876543458'),
    (199181, 'Vivek Singh', 'Wing Commander', '1976-07-28', '2002-09-10', '2022-07-28', '35BCC', '1995', 'No.1 Squadron', 'flying', NULL, '9876543458', 'Male', '24343 Air Force Street', 'Mumbai', 'Maharashtra', '400051', 'Married', '9876543459'),
    (199182, 'Ritu Kumari', 'Group Captain', '1981-11-15', '2007-12-28', NULL, '1TBCC', '1997', 'No.2 Squadron', 'flying', NULL, '9876543459', 'Female', '24444 Air Force Road', 'Delhi', 'Delhi', '110051', 'Single', '9876543460'),
    (199183, 'Rajesh Singh', 'Squadron Leader', '1986-01-22', '2012-03-15', NULL, '82NAV', '2000', 'No.3 Squadron', 'flying', NULL, '9876543460', 'Male', '24545 Air Force Lane', 'Chennai', 'Tamil Nadu', '600051', 'Married', '9876543461'),
    (199184, 'Pooja Kumari', 'Flight Lieutenant', '1991-05-30', '2017-07-10', NULL, '1ssc(W)FP', '2002', 'No.4 Squadron', 'flying', NULL, '9876543461', 'Female', '24646 Air Force Enclave', 'Kolkata', 'West Bengal', '700051', 'Single', '9876543462'),
    (199185, 'Nitin Sharma', 'Flying Officer', '1996-08-10', '2002-10-28', '2022-08-10', '82NAV(M)', '1993', 'No.5 Squadron', 'flying', NULL, '9876543462', 'Male', '24747 Air Force Avenue', 'Hyderabad', 'Telangana', '500051', 'Married', '9876543463'),
    (199186, 'Rajiv Kumar', 'Wing Commander', '1972-12-18', '1998-02-05', '2018-12-18', '35BCC', '1995', 'No.34 Squadron', 'missile', NULL, '9876543463', 'Male', '24848 Air Force Street', 'Mumbai', 'Maharashtra', '400052', 'Married', '9876543464'),
    (199187, 'Vidya Sharma', 'Group Captain', '1977-03-05', '2004-04-20', '2024-03-05', '1TBCC', '1997', 'No.46 Squadron', 'missile', NULL, '9876543464', 'Female', '24949 Air Force Road', 'Delhi', 'Delhi', '110052', 'Single', '9876543465'),
    (199188, 'Alok Singh', 'Squadron Leader', '1982-06-12', '2010-08-30', NULL, '82NAV', '2000', 'No.58 Squadron', 'missile', NULL, '9876543465', 'Male', '25050 Air Force Lane', 'Chennai', 'Tamil Nadu', '600052', 'Married', '9876543466'),
    (199189, 'Anita Gupta', 'Flight Lieutenant', '1987-09-18', '2013-11-10', NULL, '033NTBC', '1998', 'No.60 Squadron', 'missile', NULL, '9876543466', 'Female', '25151 Air Force Enclave', 'Kolkata', 'West Bengal', '700052', 'Single', '9876543467'),
    (199190, 'Vivek Patel', 'Flying Officer', '1992-11-28', '1998-01-15', '2018-11-28', '053NTBC', '2001', 'No.61 Squadron', 'missile', NULL, '9876543467', 'Male', '25252 Air Force Avenue', 'Hyderabad', 'Telangana', '500052', 'Married', '9876543468'),
    (199191, 'Neha Singh', 'Wing Commander', '1970-02-15', '1996-04-28', '2016-02-15', '82NAV', '2000', '254 Signal Unit', 'signal', NULL, '9876543468', 'Female', '25353 Air Force Street', 'Mumbai', 'Maharashtra', '400053', 'Married', '9876543469'),
    (199192, 'Raj Kumar', 'Group Captain', '1975-05-20', '2005-07-10', NULL, '1TBCC', '1997', '12 Signal Unit', 'signal', NULL, '9876543469', 'Male', '25454 Air Force Road', 'Delhi', 'Delhi', '110053', 'Single', '9876543470'),
    (199193, 'Anu Sharma', 'Squadron Leader', '1980-08-28', '2010-10-15',NULL, '82NAV', '2000', '35 Signal Unit', 'signal', NULL, '9876543470', 'Female', '25555 Air Force Lane', 'Chennai', 'Tamil Nadu', '600053', 'Married', '9876543471'),
    (199194, 'Rajesh Kumar', 'Flight Lieutenant', '1985-11-05', '1995-12-18', '2015-11-05', '1ssc(W)FP', '2002', '55 Signal Unit', 'signal', NULL, '9876543471', 'Male', '25656 Air Force Enclave', 'Kolkata', 'West Bengal', '700053', 'Single', '9876543472'),
    (199195, 'Pooja Gupta', 'Flying Officer', '1991-01-15', '2001-03-30', '2021-01-15', '82NAV(M)', '1993', '149 Signal Unit', 'signal', NULL, '9876543472', 'Female', '25757 Air Force Avenue', 'Hyderabad', 'Telangana', '500053', 'Married', '9876543473'),
    (199196, 'Amit Singh', 'Wing Commander', '1974-03-30', '2000-05-12', '2020-03-30', '35BCC', '1995', 'AFS Chakeri', 'maintenance&logistics', NULL, '9876543473', 'Male', '25858 Air Force Street', 'Mumbai', 'Maharashtra', '400054', 'Married', '9876543474'),
    (199197, 'Kavita Kumar', 'Group Captain', '1979-07-10', '2005-08-28', NULL, '1TBCC', '1997', '1 Base Repair Depot', 'maintenance&logistics', NULL, '9876543474', 'Female', '25959 Air Force Road', 'Delhi', 'Delhi', '110054', 'Single', '9876543475'),
    (199198, 'Rajat Sharma', 'Squadron Leader', '1984-09-18', '2010-11-03', NULL, '82NAV', '2000', '2 Base Repair Depot', 'maintenance&logistics', NULL, '9876543475', 'Male', '26060 Air Force Lane', 'Chennai', 'Tamil Nadu', '600054', 'Married', '9876543476'),
    (199199, 'Nisha Patel', 'Flight Lieutenant', '1989-12-25', '2015-02-10',NULL, '1ssc(W)FP', '2002', '3 Base Repair Depot', 'maintenance&logistics', NULL, '9876543476', 'Female', '26161 Air Force Enclave', 'Kolkata', 'West Bengal', '700054', 'Single', '9876543477'),
(199200, 'Sachin Kumar', 'Flight Lieutenant', '1990-04-12', '2016-06-25', NULL, '004NTBC', '2003', 'No.61 Squadron', 'missile', NULL, '9876543478', 'Male', '26262 Air Force Avenue', 'Hyderabad', 'Telangana', '500054', 'Married', '9876543479');

INSERT INTO Awards (sid, awardName) VALUES
(199001, 'Param Vir Chakra'),
(199002, 'Ashok Chakra'),
(199003, 'Padma Vibhushan'),
(199004, 'Padma Bhushan'),
(199005, 'Sarvottam Yudh Seva Medal'),
(199006, 'Param Vishist Seva Medal'),
(199007, 'Maha Vir Chakra'),
(199008, 'Uttam Yudh Seva Medal'),
(199009, 'Kirti Chakra'),
(199010, 'Padma Shri'),
(199011, 'Ati Vishist Seva Medal'),
(199012, 'Vir Chakra'),
(199013, 'Shaurya Chakra'),
(199014, 'Yudh Seva Medal'),
(199015, 'Vayu Sena Medal'),
(199016, 'Sena Medal (Gallantry)'),
(199017, 'Vishist Seva Medal'),
(199101, 'Param Vir Chakra'),
(199102, 'Ashok Chakra'),
(199103, 'Padma Vibhushan'),
(199104, 'Padma Bhushan'),
(199105, 'Sarvottam Yudh Seva Medal'),
(199106, 'Param Vishist Seva Medal'),
(199107, 'Maha Vir Chakra'),
(199108, 'Uttam Yudh Seva Medal'),
(199109, 'Kirti Chakra'),
(199110, 'Padma Shri'),
(199111, 'Ati Vishist Seva Medal'),
(199112, 'Vir Chakra'),
(199113, 'Shaurya Chakra'),
(199114, 'Yudh Seva Medal'),
(199115, 'Vayu Sena Medal'),
(199116, 'Sena Medal (Gallantry)'),
(199117, 'Vishist Seva Medal'),
(199151, 'Param Vir Chakra'),
(199152, 'Ashok Chakra'),
(199153, 'Padma Vibhushan'),
(199154, 'Padma Bhushan'),
(199155, 'Sarvottam Yudh Seva Medal'),
(199156, 'Param Vishist Seva Medal'),
(199157, 'Maha Vir Chakra'),
(199158, 'Uttam Yudh Seva Medal'),
(199159, 'Kirti Chakra'),
(199160, 'Padma Shri'),
(199161, 'Ati Vishist Seva Medal'),
(199162, 'Vir Chakra'),
(199163, 'Shaurya Chakra'),
(199164, 'Yudh Seva Medal'),
(199165, 'Vayu Sena Medal'),
(199166, 'Sena Medal (Gallantry)'),
(199167, 'Vishist Seva Medal');

    insert into Dependents (sid,name,relationship,dob,gender) values
    (199001, 'Rajeshri Sharma', 'Spouse', '1978-05-12', 'Female'),
    ('199001', 'Abhinav Sharma', 'Child', '2005-10-25', 'Male'),
    ('199002', 'Amit Verma', 'Spouse', '1982-08-20', 'Male'),
    ('199002', 'Rit Verma', 'Child', '2010-03-15', 'Male'),
    ('199003', 'Aniti Singh', 'Spouse', '1976-11-18', 'Female'),
    ('199003', 'Preet Singh', 'Child', '2004-02-10', 'Male'),
    ('199004', 'Vikram Kumar', 'Spouse', '1980-03-25', 'Male'),
    ('199004', 'Nehal Kumar', 'Child', '2007-06-30', 'Male'),
    ('199005', 'Sanjay Patel', 'Spouse', '1979-09-15', 'Female'),
    ('199005', 'Sunil Patel', 'Child', '2006-12-20', 'Male'),
    ('199006', 'Rahul Gupta', 'Spouse', '1984-02-28', 'Male'),
    ('199006', 'Divya Gupta', 'Child', '2011-05-05', 'Male'),
    ('199007', 'Arun Kumar', 'Spouse', '1975-07-10', 'Female'),
    ('199007', 'Shikhar Kumar', 'Child', '2003-10-15', 'Male'),
    ('199008', 'Vivek Sharma', 'Spouse', '1981-12-22', 'Male'),
    ('199008', 'Nishant Sharma', 'Child', '2009-03-27', 'Male'),
    ('199009', 'Suresh Reddy', 'Spouse', '1977-04-18', 'Female'),
    ('199009', 'Deep Reddy', 'Child', '2004-07-25', 'Female'),
    ('199010', 'Vinod Tiwari', 'Spouse', '1983-06-02', 'Male'),
    ('199010', 'Kkavy Tiwari', 'Child', '2010-09-10', 'Male'),
    ('199011', 'Alok Singh', 'Spouse', '1974-08-28', 'Female'),
    ('199011', 'Anuj Singh', 'Child', '2001-11-30', 'Male'),
    ('199012', 'Ravi Mishra', 'Spouse', '1979-01-08', 'Male'),
    ('199012', 'Pritam Mishra', 'Child', '2006-04-15', 'Male'),
    ('199013', 'Amit Kumar', 'Spouse', '1985-03-14', 'Female'),
    ('199013', 'Swapnil Kumar', 'Child', '2012-06-20', 'Male'),
    ('199014', 'Ankur Gupta', 'Spouse', '1976-09-20', 'Male'),
    ('199014', 'Shilp Gupta', 'Child', '2003-12-25', 'Male'),
    ('199015', 'Rajesh Patel', 'Spouse', '1980-04-02', 'Female'),
    ('199015', 'Purva Patel', 'Child', '2007-07-10', 'Male'),
    ('199016', 'Manoj Singh', 'Spouse', '1978-11-15', 'Male'),
    ('199016', 'Vandan Singh', 'Child', '2006-02-28', 'Male'),
    ('199017', 'Arun Sharma', 'Spouse', '1982-07-05', 'Female'),
    ('199017', 'Jeet Sharma', 'Child', '2009-10-12', 'Male'),
    ('199018', 'Ajay Kumar', 'Spouse', '1977-12-30', 'Male'),
    ('199018', 'Shwet Kumar', 'Child', '2005-04-05', 'Male'),
    ('199019', 'Vikas Verma', 'Spouse', '1981-06-18', 'Female'),
    ('199019', 'Pallash Verma', 'Child', '2008-09-25', 'Male'),
    ('199020', 'Nitin Singh', 'Spouse', '1975-10-22', 'Male'),
    ('199020', 'Jyot Singh', 'Child', '2003-01-30', 'Male'),
    ('199021', 'Rahul Sharma', 'Spouse', '1979-03-28', 'Female'),
    ('199021', 'Shivam Sharma', 'Child', '2006-07-05', 'Male'),
    ('199022', 'Amar Verma', 'Spouse', '1984-05-12', 'Male'),
    ('199022', 'Snehal Verma', 'Child', '2011-08-20', 'Male'),
    ('199023', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Female'),
    ('199023', 'Renu Singh', 'Child', '2003-11-25', 'Male'),
    ('199024', 'Anil Kumar', 'Spouse', '1980-02-14', 'Male'),
    ('199024', 'Sur Kumar', 'Child', '2007-05-20', 'Male'),
    ('199025', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199025', 'Neet Gupta', 'Child', '2005-01-25', 'Male'),
    ('199026', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199026', 'Priyank Patel', 'Child', '2009-07-12', 'Male'),
    ('199027', 'Alok Sharma', 'Spouse', '1977-06-30', 'Male'),
    ('199027', 'Vidya Sharma', 'Child', '2004-10-05', 'Male'),
    ('199028', 'Amit Kumar', 'Spouse', '1981-09-22', 'Female'),
    ('199028', 'Anjali Kumar', 'Child', '2008-12-30', 'Male'),
    ('199029', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Male'),
    ('199029', 'Rajni Singh', 'Child', '2003-02-15', 'Male'),
    ('199030', 'Vikas Verma', 'Spouse', '1979-12-28', 'Female'),
    ('199030', 'Priya Verma', 'Child', '2007-04-05', 'Male'),
    ('199031', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Female'),
    ('199031', 'Pooja Gupta', 'Child', '2010-06-20', 'Male'),
    ('199032', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199032', 'Swati Singh', 'Child', '2004-12-25', 'Male'),
    ('199033', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199033', 'Sneha Mishra', 'Child', '2007-05-10', 'Male'),
    ('199034', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Male'),
    ('199034', 'Deepika Patel', 'Child', '2005-08-30', 'Male'),
    ('199035', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199035', 'Shweta Sharma', 'Child', '2011-09-25', 'Male'),
    ('199036', 'Alok Kumar', 'Spouse', '1976-11-22', 'Female'),
    ('199036', 'Rachana Kumar', 'Child', '2004-02-28', 'Male'),
    ('199037', 'Rahul Verma', 'Spouse', '1980-03-18', 'Male'),
    ('199037', 'Komal Verma', 'Child', '2007-06-25', 'Male'),
    ('199038', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Male'),
    ('199038', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199039', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199039', 'Neelam Sharma', 'Child', '2008-10-30', 'Male'),
    ('199040', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Female'),
    ('199040', 'Poonam Gupta', 'Child', '2007-04-05', 'Male'),
    ('199041', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199041', 'Kiran Tiwari', 'Child', '2003-01-30', 'Male'),
    ('199042', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Female'),
    ('199042', 'Reena Kumar', 'Child', '2006-07-05', 'Male'),
    ('199043', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199043', 'Neha Verma', 'Child', '2011-08-20', 'Male'),
    ('199044', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Female'),
    ('199044', 'Renu Singh', 'Child', '2003-11-25', 'Male'),
    ('199045', 'Anil Kumar', 'Spouse', '1980-02-14', 'Female'),
    ('199045', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Male'),
    ('199046', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199046', 'Neetu Gupta', 'Child', '2005-01-25', 'Male'),
    ('199047', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199047', 'Priyanka Patel', 'Child', '2009-07-12', 'Male'),
    ('199048', 'Alok Sharma', 'Spouse', '1977-06-30', 'Female'),
    ('199048', 'Vidya Sharma', 'Child', '2004-10-05', 'Male'),
    ('199049', 'Amit Kumar', 'Spouse', '1981-09-22', 'Male'),
    ('199049', 'Anjali Kumar', 'Child', '2008-12-30', 'Male'),
    ('199050', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199050', 'Rajni Singh', 'Child', '2003-02-15', 'Male'),
    ('199051', 'Vikas Verma', 'Spouse', '1979-12-28', 'Female'),
    ('199051', 'Priya Verma', 'Child', '2007-04-05', 'Male'),
    ('199052', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Male'),
    ('199052', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199053', 'Ankit Singh', 'Spouse', '1976-09-20', 'Female'),
    ('199053', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199054', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Male'),
    ('199054', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199055', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Female'),
    ('199055', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199056', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199056', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199057', 'Alok Kumar', 'Spouse', '1976-11-22', 'Male'),
    ('199057', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199058', 'Rahul Verma', 'Spouse', '1980-03-18', 'Female'),
    ('199058', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199059', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Male'),
    ('199059', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199060', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199060', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199061', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Female'),
    ('199061', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199062', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Male'),
    ('199062', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199063', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Female'),
    ('199063', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199064', 'Amar Verma', 'Spouse', '1984-05-12', 'Male'),
    ('199064', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199065', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Female'),
    ('199065', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199066', 'Anil Kumar', 'Spouse', '1980-02-14', 'Male'),
    ('199066', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199067', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199067', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199068', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Male'),
    ('199068', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199069', 'Alok Sharma', 'Spouse', '1977-06-30', 'Female'),
    ('199069', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199070', 'Amit Kumar', 'Spouse', '1981-09-22', 'Male'),
    ('199070', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199071', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199071', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199072', 'Vikas Verma', 'Spouse', '1979-12-28', 'Male'),
    ('199072', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199073', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Male'),
    ('199073', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199074', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199074', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199075', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199075', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199076', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Female'),
    ('199076', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199077', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Male'),
    ('199077', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199078', 'Alok Kumar', 'Spouse', '1976-11-22', 'Female'),
    ('199078', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199079', 'Rahul Verma', 'Spouse', '1980-03-18', 'Male'),
    ('199079', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199080', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Female'),
    ('199080', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199081', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199081', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199082', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Male'),
    ('199082', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199083', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199083', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199084', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Male'),
    ('199084', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199085', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199085', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199086', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Female'),
    ('199086', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199087', 'Anil Kumar', 'Spouse', '1980-02-14', 'Male'),
    ('199087', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199088', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199088', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199089', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Male'),
    ('199089', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199090', 'Alok Sharma', 'Spouse', '1977-06-30', 'Female'),
    ('199090', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199091', 'Amit Kumar', 'Spouse', '1981-09-22', 'Male'),
    ('199091', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199092', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199092', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199093', 'Vikas Verma', 'Spouse', '1979-12-28', 'Male'),
    ('199093', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199094', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Female'),
    ('199094', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199095', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199095', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199096', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199096', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199097', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Male'),
    ('199097', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199098', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199098', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199099', 'Alok Kumar', 'Spouse', '1976-11-22', 'Male'),
    ('199099', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199100', 'Rahul Verma', 'Spouse', '1980-03-18', 'Female'),
    ('199100', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199101', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Female'),
    ('199101', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199102', 'Amit Sharma', 'Spouse', '1981-07-22', 'Male'),
    ('199102', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199103', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Female'),
    ('199103', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199104', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Male'),
    ('199104', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199105', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Female'),
    ('199105', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199106', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199106', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199107', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Male'),
    ('199107', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199108', 'Anil Kumar', 'Spouse', '1980-02-14', 'Female'),
    ('199108', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199109', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Male'),
    ('199109', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199110', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199110', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199111', 'Alok Sharma', 'Spouse', '1977-06-30', 'Female'),
    ('199111', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199112', 'Amit Kumar', 'Spouse', '1981-09-22', 'Male'),
    ('199112', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199113', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199113', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199114', 'Vikas Verma', 'Spouse', '1979-12-28', 'Male'),
    ('199114', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199115', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Female'),
    ('199115', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199116', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199116', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199117', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199117', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199118', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Male'),
    ('199118', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199119', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199119', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199120', 'Alok Kumar', 'Spouse', '1976-11-22', 'Male'),
    ('199120', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199121', 'Rahul Verma', 'Spouse', '1980-03-18', 'Female'),
    ('199121', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199122', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Male'),
    ('199122', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199123', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199123', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199124', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Male'),
    ('199124', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199125', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199125', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199126', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Female'),
    ('199126', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199127', 'Amar Verma', 'Spouse', '1984-05-12', 'Male'),
    ('199127', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199128', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Female'),
    ('199128', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199129', 'Anil Kumar', 'Spouse', '1980-02-14', 'Male'),
    ('199129', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199130', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199130', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199131', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199131', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199132', 'Alok Sharma', 'Spouse', '1977-06-30', 'Male'),
    ('199132', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199133', 'Amit Kumar', 'Spouse', '1981-09-22', 'Female'),
    ('199133', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199134', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Male'),
    ('199134', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199135', 'Vikas Verma', 'Spouse', '1979-12-28', 'Female'),
    ('199135', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199136', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Female'),
    ('199136', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199137', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199137', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199138', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199138', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199139', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Male'),
    ('199139', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199140', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199140', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199141', 'Alok Kumar', 'Spouse', '1976-11-22', 'Male'),
    ('199141', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199142', 'Rahul Verma', 'Spouse', '1980-03-18', 'Female'),
    ('199142', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199143', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Male'),
    ('199143', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199144', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199144', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199145', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Male'),
    ('199145', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199146', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199146', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199147', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Male'),
    ('199147', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199148', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199148', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199149', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Male'),
    ('199149', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199150', 'Anil Kumar', 'Spouse', '1980-02-14', 'Female'),
    ('199150', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199151', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Female'),
    ('199151', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199152', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Male'),
    ('199152', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199153', 'Alok Sharma', 'Spouse', '1977-06-30', 'Female'),
    ('199153', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199154', 'Amit Kumar', 'Spouse', '1981-09-22', 'Male'),
    ('199154', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199155', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199155', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199156', 'Vikas Verma', 'Spouse', '1979-12-28', 'Female'),
    ('199156', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199157', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Male'),
    ('199157', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199158', 'Ankit Singh', 'Spouse', '1976-09-20', 'Female'),
    ('199158', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199159', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Male'),
    ('199159', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199160', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Female'),
    ('199160', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199161', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Female'),
    ('199161', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199162', 'Alok Kumar', 'Spouse', '1976-11-22', 'Male'),
    ('199162', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199163', 'Rahul Verma', 'Spouse', '1980-03-18', 'Female'),
    ('199163', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199164', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Male'),
    ('199164', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199165', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199165', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199166', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Male'),
    ('199166', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199167', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199167', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199168', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Male'),
    ('199168', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199169', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199169', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199170', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Male'),
    ('199170', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199171', 'Anil Kumar', 'Spouse', '1980-02-14', 'Female'),
    ('199171', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199172', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Male'),
    ('199172', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199173', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199173', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199174', 'Alok Sharma', 'Spouse', '1977-06-30', 'Male'),
    ('199174', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199175', 'Amit Kumar', 'Spouse', '1981-09-22', 'Female'),
    ('199175', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199176', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Female'),
    ('199176', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199177', 'Vikas Verma', 'Spouse', '1979-12-28', 'Male'),
    ('199177', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199178', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Female'),
    ('199178', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199179', 'Ankit Singh', 'Spouse', '1976-09-20', 'Male'),
    ('199179', 'Swati Singh', 'Child', '2004-12-25', 'Female'),
    ('199180', 'Avinash Mishra', 'Spouse', '1980-02-02', 'Female'),
    ('199180', 'Sneha Mishra', 'Child', '2007-05-10', 'Female'),
    ('199181', 'Rajesh Patel', 'Spouse', '1978-05-22', 'Female'),
    ('199181', 'Deepika Patel', 'Child', '2005-08-30', 'Female'),
    ('199182', 'Vivek Sharma', 'Spouse', '1984-06-18', 'Male'),
    ('199182', 'Shweta Sharma', 'Child', '2011-09-25', 'Female'),
    ('199183', 'Alok Kumar', 'Spouse', '1976-11-22', 'Female'),
    ('199183', 'Rachana Kumar', 'Child', '2004-02-28', 'Female'),
    ('199184', 'Rahul Verma', 'Spouse', '1980-03-18', 'Male'),
    ('199184', 'Komal Verma', 'Child', '2007-06-25', 'Female'),
    ('199185', 'Sanjay Singh', 'Spouse', '1977-04-20', 'Female'),
    ('199185', 'Sapna Singh', 'Child', '2004-07-25', 'Female'),
    ('199186', 'Amit Sharma', 'Spouse', '1981-07-22', 'Female'),
    ('199186', 'Neelam Sharma', 'Child', '2008-10-30', 'Female'),
    ('199187', 'Suresh Gupta', 'Spouse', '1979-12-28', 'Male'),
    ('199187', 'Poonam Gupta', 'Child', '2007-04-05', 'Female'),
    ('199188', 'Vikas Tiwari', 'Spouse', '1975-10-22', 'Female'),
    ('199188', 'Kiran Tiwari', 'Child', '2003-01-30', 'Female'),
    ('199189', 'Rajesh Kumar', 'Spouse', '1979-03-28', 'Male'),
    ('199189', 'Reena Kumar', 'Child', '2006-07-05', 'Female'),
    ('199190', 'Amar Verma', 'Spouse', '1984-05-12', 'Female'),
    ('199190', 'Neha Verma', 'Child', '2011-08-20', 'Female'),
    ('199191', 'Ramesh Singh', 'Spouse', '1976-08-18', 'Male'),
    ('199191', 'Renu Singh', 'Child', '2003-11-25', 'Female'),
    ('199192', 'Anil Kumar', 'Spouse', '1980-02-14', 'Female'),
    ('199192', 'Sangeeta Kumar', 'Child', '2007-05-20', 'Female'),
    ('199193', 'Sunil Gupta', 'Spouse', '1978-10-20', 'Male'),
    ('199193', 'Neetu Gupta', 'Child', '2005-01-25', 'Female'),
    ('199194', 'Rajesh Patel', 'Spouse', '1982-04-05', 'Female'),
    ('199194', 'Priyanka Patel', 'Child', '2009-07-12', 'Female'),
    ('199195', 'Alok Sharma', 'Spouse', '1977-06-30', 'Male'),
    ('199195', 'Vidya Sharma', 'Child', '2004-10-05', 'Female'),
    ('199196', 'Amit Kumar', 'Spouse', '1981-09-22', 'Female'),
    ('199196', 'Anjali Kumar', 'Child', '2008-12-30', 'Female'),
    ('199197', 'Sanjay Singh', 'Spouse', '1975-11-10', 'Male'),
    ('199197', 'Rajni Singh', 'Child', '2003-02-15', 'Female'),
    ('199198', 'Vikas Verma', 'Spouse', '1979-12-28', 'Female'),
    ('199198', 'Priya Verma', 'Child', '2007-04-05', 'Female'),
    ('199199', 'Rahul Gupta', 'Spouse', '1983-03-14', 'Male'),
    ('199199', 'Pooja Gupta', 'Child', '2010-06-20', 'Female'),
    ('199200', 'Ankit Singh', 'Spouse', '1976-09-20', 'Female'),
    ('199200', 'Swati Singh', 'Child', '2004-12-25', 'Female');

INSERT INTO medicalinformation (sid, identificationmark, fitnesslevel, height, weight, bloodgroup, allergies, checkupdate) VALUES

-- For sid 199001
(199001, 'Scar on the left arm', 3, 175, 70.5, 'AB+', 'Pollen', '1995-04-03'),
(199001, 'Scar on the left arm', 4, 175, 70.5, 'AB+', 'Pollen', '1996-04-04'),
(199001, 'Scar on the left arm', 4, 175, 70.5, 'AB+', 'Pollen', '1997-04-04'),
-- For sid 199002
(199002, 'Scar on the back', 2, 180, 75.2, 'O+', 'None', '1995-04-05'),
(199002, 'Birthmark on the shoulder', 3, 180, 75.2, 'O+', 'None', '1995-04-06'),

-- For sid 199003
(199003, 'Scar on the forehead', 4, 165, 55.0, 'A-', 'Peanuts', '1995-04-07'),
(199003, 'Birthmark on the left hand', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-08'),

-- For sid 199004
(199004, 'Birthmark on the right leg', 3, 170, 60.0, 'B+', 'Dust', '1995-04-09'),
(199004, 'Scar on the left arm', 4, 170, 60.0, 'B+', 'Dust', '1995-04-10'),

-- For sid 199005
(199005, 'Scar on the right hand', 2, 172, 65.5, 'AB-', 'Pollen', '1995-04-11'),
(199005, 'Birthmark on the left leg', 3, 172, 65.5, 'AB-', 'Pollen', '2004-04-12'),

-- For sid 199006
(199006, 'Birthmark on the forehead', 4, 178, 70.2, 'A+', 'Peanuts', '1995-04-13'),
(199006, 'Scar on the right leg', 5, 178, 70.2, 'A+', 'Peanuts', '2002-04-14'),

-- For sid 199007
(199007, 'Scar on the right hand', 3, 175, 68.0, 'O-', 'Dust', '1995-04-15'),
(199007, 'Birthmark on the left leg', 4, 175, 68.0, 'O-', 'Dust', '1995-04-16'),

-- For sid 199008
(199008, 'Birthmark on the left hand', 2, 180, 72.3, 'A+', 'Pollen', '1995-04-17'),
(199008, 'Scar on the right arm', 3, 180, 72.3, 'A+', 'Pollen', '1995-04-18'),

-- For sid 199009
(199009, 'Scar on the back', 4, 167, 63.8, 'B-', 'None', '1995-04-19'),
(199009, 'Birthmark on the forehead', 5, 167, 63.8, 'B-', 'None', '1995-04-20'),

-- For sid 199010
(199010, 'Birthmark on the back', 3, 172, 67.1, 'AB+', 'Shellfish', '1995-04-21'),
(199010, 'Scar on the right leg', 4, 172, 67.1, 'AB+', 'Shellfish', '1995-04-22'),

-- For sid 199011
(199011, 'Scar on the left leg', 2, 179, 71.4, 'O+', 'Dust', '1995-04-23'),
(199011, 'Birthmark on the left arm', 3, 179, 71.4, 'O+', 'Dust', '1995-04-24'),

-- For sid 199012
(199012, 'Birthmark on the left arm', 4, 173, 66.7, 'A-', 'Pollen', '1995-04-25'),
(199012, 'Scar on the right leg', 5, 173, 66.7, 'A-', 'Pollen', '1995-04-26'),

-- For sid 199013
(199013, 'Scar on the back', 3, 177, 69.0, 'B+', 'None', '1995-04-27'),
(199013, 'Birthmark on the shoulder', 4, 177, 69.0, 'B+', 'None', '1995-04-28'),

-- For sid 199014
(199014, 'Birthmark on the right leg', 2, 168, 61.5, 'O-', 'Peanuts', '1995-04-29'),
(199014, 'Scar on the left arm', 3, 168, 61.5, 'O-', 'Peanuts', '1995-04-30'),

-- For sid 199015
(199015, 'Scar on the right leg', 4, 176, 68.3, 'AB+', 'Dust', '1995-05-01'),
(199015, 'Birthmark on the left hand', 5, 176, 68.3, 'AB+', 'Dust', '1995-05-02'),

-- For sid 199016
(199016, 'Birthmark on the left leg', 3, 181, 73.0, 'O-', 'Shellfish', '1995-05-03'),
(199016, 'Scar on the right arm', 4, 181, 73.0, 'O-', 'Shellfish', '1995-05-04'),

-- For sid 199017
(199017, 'Scar on the forehead', 2, 170, 64.2, 'A+', 'Pollen', '1995-05-05'),
(199017, 'Birthmark on the back', 3, 170, 64.2, 'A+', 'Pollen', '1995-05-06'),

-- For sid 199018
(199018, 'Birthmark on the forehead', 4, 174, 67.8, 'B-', 'None', '1995-05-07'),
(199018, 'Scar on the left leg', 5, 174, 67.8, 'B-', 'None', '1995-05-08'),

-- For sid 199019
(199019, 'Scar on the right hand', 3, 178, 70.5, 'AB+', 'Peanuts', '1995-05-09'),
(199019, 'Birthmark on the left leg', 4, 178, 70.5, 'AB+', 'Peanuts', '1995-05-10'),

-- For sid 199020
(199020, 'Scar on the left arm', 2, 171, 66.0, 'A-', 'Dust', '1995-05-11'),
(199020, 'Birthmark on the right leg', 3, 171, 66.0, 'A-', 'Dust', '1995-05-12'),

-- For sid 199021
(199021, 'Birthmark on the right hand', 4, 175, 68.9, 'O+', 'Shellfish', '1995-05-13'),
(199021, 'Scar on the left leg', 5, 175, 68.9, 'O+', 'Shellfish', '1995-05-14'),

-- For sid 199022
(199022, 'Scar on the back', 3, 179, 72.1, 'AB-', 'Pollen', '1995-05-15'),
(199022, 'Birthmark on the forehead', 4, 179, 72.1, 'AB-', 'Pollen', '1995-05-16'),

-- For sid 199023
(199023, 'Birthmark on the back', 2, 167, 60.8, 'B+', 'None', '1995-05-17'),
(199023, 'Scar on the right leg', 3, 167, 60.8, 'B+', 'None', '1995-05-18'),

-- For sid 199024
(199024, 'Scar on the right hand', 4, 172, 66.4, 'A+', 'Peanuts', '1995-05-19'),
(199024, 'Birthmark on the left leg', 5, 172, 66.4, 'A+', 'Peanuts', '1995-05-20'),

-- For sid 199025
(199025, 'Scar on the forehead', 3, 176, 69.3, 'O-', 'Dust', '1995-05-21'),
(199025, 'Birthmark on the left arm', 4, 176, 69.3, 'O-', 'Dust', '1995-05-22'),

-- For sid 199026
(199026, 'Birthmark on the right leg', 2, 180, 73.6, 'AB+', 'Shellfish', '1995-05-23'),
(199026, 'Scar on the left arm', 3, 180, 73.6, 'AB+', 'Shellfish', '1995-05-24'),

-- For sid 199027
(199027, 'Scar on the right leg', 4, 168, 62.0, 'B-', 'Pollen', '1995-05-25'),
(199027, 'Birthmark on the left hand', 5, 168, 62.0, 'B-', 'Pollen', '1995-05-26'),

-- For sid 199028
(199028, 'Birthmark on the left leg', 3, 173, 67.1, 'A+', 'None', '1995-05-27'),
(199028, 'Scar on the right arm', 4, 173, 67.1, 'A+', 'None', '1995-05-28'),

-- For sid 199029
(199029, 'Scar on the forehead', 2, 177, 70.4, 'O+', 'Pollen', '1995-05-29'),
(199029, 'Birthmark on the back', 3, 177, 70.4, 'O+', 'Pollen', '2013-05-30'),

-- For sid 199030
(199030, 'Birthmark on the forehead', 4, 175, 68.5, 'AB-', 'Shellfish', '1995-05-31'),
(199030, 'Scar on the left leg', 5, 175, 68.5, 'AB-', 'Shellfish', '1995-06-01'),

-- For sid 199031
(199031, 'Scar on the right hand', 3, 171, 65.2, 'B-', 'Dust', '1995-06-02'),
(199031, 'Birthmark on the left leg', 4, 171, 65.2, 'B-', 'Dust', '1995-06-03'),

-- For sid 199032
(199032, 'Birthmark on the left hand', 2, 176, 69.7, 'A-', 'Peanuts', '1995-06-04'),
(199032, 'Scar on the right leg', 3, 176, 69.7, 'A-', 'Peanuts', '1995-06-05'),

-- For sid 199033
(199033, 'Scar on the back', 4, 180, 72.4, 'O-', 'None', '1995-06-06'),
(199033, 'Birthmark on the shoulder', 5, 180, 72.4, 'O-', 'None', '1995-06-07'),

-- For sid 199034
(199034, 'Birthmark on the right leg', 3, 168, 63.0, 'A+', 'Pollen', '1995-06-08'),
(199034, 'Scar on the left arm', 4, 168, 63.0, 'A+', 'Pollen', '1995-06-09'),

-- For sid 199035
(199035, 'Scar on the right leg', 2, 172, 66.3, 'B+', 'Dust', '1995-06-10'),
(199035, 'Birthmark on the left hand', 3, 172, 66.3, 'B+', 'Dust', '1995-06-11'),

-- For sid 199036
(199036, 'Birthmark on the forehead', 4, 178, 70.1, 'AB-', 'Peanuts', '1995-06-12'),
(199036, 'Scar on the right arm', 5, 178, 70.1, 'AB-', 'Peanuts', '1995-06-13'),

-- For sid 199037
(199037, 'Scar on the right hand', 3, 175, 68.2, 'O+', 'Dust', '1995-06-14'),
(199037, 'Birthmark on the left leg', 4, 175, 68.2, 'O+', 'Dust', '1995-06-15'),

-- For sid 199038
(199038, 'Scar on the left leg', 2, 179, 71.8, 'A-', 'Shellfish', '1995-06-16'),
(199038, 'Birthmark on the left arm', 3, 179, 71.8, 'A-', 'Shellfish', '1995-06-17'),

-- For sid 199039
(199039, 'Birthmark on the back', 4, 167, 63.2, 'B-', 'Pollen', '1995-06-18'),
(199039, 'Scar on the forehead', 5, 167, 63.2, 'B-', 'Pollen', '2012-06-19'),

-- For sid 199040
(199040, 'Scar on the right leg', 3, 172, 66.5, 'AB+', 'None', '1995-06-20'),
(199040, 'Birthmark on the left hand', 4, 172, 66.5, 'AB+', 'None', '1995-06-21'),

-- For sid 199041
(199041, 'Birthmark on the left leg', 2, 180, 72.0, 'O-', 'Pollen', '1995-06-22'),
(199041, 'Scar on the right arm', 3, 180, 72.0, 'O-', 'Pollen', '1995-06-23'),

-- For sid 199042
(199042, 'Scar on the back', 4, 174, 68.5, 'A+', 'Shellfish', '1995-06-24'),
(199042, 'Birthmark on the forehead', 5, 174, 68.5, 'A+', 'Shellfish', '1995-06-25'),

-- For sid 199043
(199043, 'Birthmark on the right hand', 3, 177, 71.1, 'O-', 'Peanuts', '1995-06-26'),
(199043, 'Scar on the left leg', 4, 177, 71.1, 'O-', 'Peanuts', '1995-06-27'),

-- For sid 199044
(199044, 'Scar on the forehead', 2, 169, 64.8, 'AB-', 'Dust', '1995-06-28'),
(199044, 'Birthmark on the back', 3, 169, 64.8, 'AB-', 'Dust', '1995-06-29'),

-- For sid 199045
(199045, 'Birthmark on the forehead', 4, 173, 67.3, 'B+', 'Pollen', '1995-06-30'),
(199045, 'Scar on the left leg', 5, 173, 67.3, 'B+', 'Pollen', '2005-07-01'),

-- For sid 199046
(199046, 'Scar on the right hand', 3, 178, 70.2, 'A-', 'None', '1995-07-02'),
(199046, 'Birthmark on the left leg', 4, 178, 70.2, 'A-', 'None', '1995-07-03'),

-- For sid 199047
(199047, 'Scar on the left leg', 2, 171, 66.5, 'O+', 'Pollen', '1995-07-04'),
(199047, 'Birthmark on the left arm', 3, 171, 66.5, 'O+', 'Pollen', '1995-07-05'),

-- For sid 199048
(199048, 'Birthmark on the back', 4, 175, 68.9, 'AB-', 'Shellfish', '1995-07-06'),
(199048, 'Scar on the forehead', 5, 175, 68.9, 'AB-', 'Shellfish', '1995-07-07'),

-- For sid 199049
(199049, 'Birthmark on the right hand', 3, 179, 71.6, 'B-', 'Peanuts', '1995-07-08'),
(199049, 'Scar on the right leg', 4, 179, 71.6, 'B-', 'Peanuts', '1995-07-09'),

-- For sid 199050
(199050, 'Scar on the back', 2, 167, 63.3, 'A+', 'Dust', '1995-07-10'),
(199050, 'Birthmark on the shoulder', 3, 167, 63.3, 'A+', 'Dust', '1995-07-11'),

-- For sid 199051
(199051, 'Birthmark on the right leg', 4, 172, 67.0, 'O-', 'Pollen', '1995-07-12'),
(199051, 'Scar on the left arm', 5, 172, 67.0, 'O-', 'Pollen', '2021-07-13'),

-- For sid 199052
(199052, 'Scar on the right hand', 3, 176, 69.5, 'AB+', 'None', '1995-07-14'),
(199052, 'Birthmark on the left leg', 4, 176, 69.5, 'AB+', 'None', '1995-07-15'),

-- For sid 199053
(199053, 'Scar on the forehead', 2, 180, 72.3, 'A-', 'Shellfish', '1995-07-16'),
(199053, 'Birthmark on the back', 3, 180, 72.3, 'A-', 'Shellfish', '1995-07-17'),

-- For sid 199054
(199054, 'Birthmark on the forehead', 4, 168, 64.2, 'B+', 'Peanuts', '1995-07-18'),
(199054, 'Scar on the left leg', 5, 168, 64.2, 'B+', 'Peanuts', '1995-07-19'),

-- For sid 199055
(199055, 'Scar on the right leg', 3, 172, 67.7, 'O-', 'Dust', '1995-07-20'),
(199055, 'Birthmark on the left hand', 4, 172, 67.7, 'O-', 'Dust', '1995-07-21'),

-- For sid 199056
(199056, 'Birthmark on the left leg', 2, 179, 71.2, 'AB-', 'Pollen', '1995-07-22'),
(199056, 'Scar on the right arm', 3, 179, 71.2, 'AB-', 'Pollen', '1995-07-23'),

-- For sid 199057
(199057, 'Scar on the back', 4, 173, 67.3, 'A+', 'None', '1995-07-24'),
(199057, 'Birthmark on the forehead', 5, 173, 67.3, 'A+', 'None', '1995-07-25'),

-- For sid 199058
(199058, 'Birthmark on the right leg', 3, 177, 70.1, 'O+', 'Peanuts', '1995-07-26'),
(199058, 'Scar on the left arm', 4, 177, 70.1, 'O+', 'Peanuts', '1995-07-27'),

-- For sid 199059
(199059, 'Scar on the right hand', 2, 169, 64.6, 'B-', 'Shellfish', '1995-07-28'),
(199059, 'Birthmark on the left leg', 3, 169, 64.6, 'B-', 'Shellfish', '1995-07-29'),

-- For sid 199060
(199060, 'Scar on the left leg', 4, 174, 68.0, 'AB-', 'Pollen', '1995-07-30'),
(199060, 'Birthmark on the left arm', 5, 174, 68.0, 'AB-', 'Pollen', '1995-07-31'),

-- For sid 199061
(199061, 'Birthmark on the back', 3, 178, 71.0, 'A+', 'Dust', '1995-08-01'),
(199061, 'Scar on the forehead', 4, 178, 71.0, 'A+', 'Dust', '1995-08-02'),

-- For sid 199062
(199062, 'Birthmark on the right hand', 2, 171, 66.1, 'O-', 'None', '1995-08-03'),
(199062, 'Scar on the right leg', 3, 171, 66.1, 'O-', 'None', '1995-08-04'),

-- For sid 199063
(199063, 'Scar on the right hand', 4, 175, 68.9, 'AB+', 'Pollen', '1995-08-05'),
(199063, 'Birthmark on the left leg', 5, 175, 68.9, 'AB+', 'Pollen', '1995-08-06'),

-- For sid 199064
(199064, 'Birthmark on the left leg', 3, 179, 72.3, 'B+', 'Shellfish', '1995-08-07'),
(199064, 'Scar on the right arm', 4, 179, 72.3, 'B+', 'Shellfish', '1995-08-08'),

-- For sid 199065
(199065, 'Scar on the back', 2, 167, 63.5, 'A-', 'Peanuts', '1995-08-09'),
(199065, 'Birthmark on the shoulder', 3, 167, 63.5, 'A-', 'Peanuts', '1995-08-10'),

-- For sid 199066
(199066, 'Scar on the forehead', 4, 172, 67.1, 'O+', 'Dust', '1995-08-11'),
(199066, 'Birthmark on the back', 5, 172, 67.1, 'O+', 'Dust', '1995-08-12'),

-- For sid 199067
(199067, 'Birthmark on the forehead', 3, 176, 69.5, 'AB-', 'Pollen', '1995-08-13'),
(199067, 'Scar on the left leg', 4, 176, 69.5, 'AB-', 'Pollen', '1995-08-14'),

-- For sid 199068
(199068, 'Scar on the right leg', 2, 180, 72.5, 'A+', 'Shellfish', '1995-08-15'),
(199068, 'Birthmark on the left arm', 3, 180, 72.5, 'A+', 'Shellfish', '1995-08-16'),

-- For sid 199069
(199069, 'Scar on the right hand', 4, 168, 64.7, 'B-', 'None', '1995-08-17'),
(199069, 'Birthmark on the left leg', 5, 168, 64.7, 'B-', 'None', '1995-08-18'),

-- For sid 199070
(199070, 'Birthmark on the left hand', 3, 172, 67.4, 'O-', 'Pollen', '1995-08-19'),
(199070, 'Scar on the right leg', 4, 172, 67.4, 'O-', 'Pollen', '1995-08-20'),

-- For sid 199071
(199071, 'Scar on the left leg', 2, 176, 70.1, 'AB+', 'Dust', '1995-08-21'),
(199071, 'Birthmark on the right leg', 3, 176, 70.1, 'AB+', 'Dust', '1995-08-22'),

-- For sid 199072
(199072, 'Scar on the back', 4, 180, 73.2, 'A-', 'Peanuts', '1995-08-23'),
(199072, 'Birthmark on the shoulder', 5, 180, 73.2, 'A-', 'Peanuts', '1995-08-24'),

-- For sid 199073
(199073, 'Birthmark on the right leg', 3, 169, 65.0, 'O+', 'Shellfish', '1995-08-25'),
(199073, 'Scar on the left arm', 4, 169, 65.0, 'O+', 'Shellfish', '1995-08-26'),

-- For sid 199074
(199074, 'Scar on the forehead', 2, 173, 67.2, 'B+', 'Pollen', '1995-08-27'),
(199074, 'Birthmark on the back', 3, 173, 67.2, 'B+', 'Pollen', '1995-08-28'),

-- For sid 199075
(199075, 'Birthmark on the forehead', 4, 177, 70.0, 'AB-', 'None', '1995-08-29'),
(199075, 'Scar on the left leg', 5, 177, 70.0, 'AB-', 'None', '1995-08-30'),

-- For sid 199076
(199076, 'Scar on the right hand', 3, 171, 65.5, 'A+', 'Pollen', '1995-08-31'),
(199076, 'Birthmark on the left leg', 4, 171, 65.5, 'A+', 'Pollen', '1995-09-01'),

-- For sid 199077
(199077, 'Scar on the left leg', 2, 175, 68.5, 'O-', 'Dust', '1995-09-02'),
(199077, 'Birthmark on the left arm', 3, 175, 68.5, 'O-', 'Dust', '1995-09-03'),

-- For sid 199078
(199078, 'Birthmark on the back', 4, 179, 71.3, 'AB+', 'Peanuts', '1995-09-04'),
(199078, 'Scar on the forehead', 5, 179, 71.3, 'AB+', 'Peanuts', '1995-09-05'),

-- For sid 199079
(199079, 'Birthmark on the right hand', 3, 167, 64.0, 'A-', 'Shellfish', '1995-09-06'),
(199079, 'Scar on the right leg', 4, 167, 64.0, 'A-', 'Shellfish', '1995-09-07'),

-- For sid 199080
(199080, 'Scar on the back', 2, 172, 66.8, 'B-', 'None', '1995-09-08'),
(199080, 'Birthmark on the shoulder', 3, 172, 66.8, 'B-', 'None', '1995-09-09'),

-- For sid 199081
(199081, 'Birthmark on the forehead', 4, 176, 69.1, 'O+', 'Pollen', '1995-09-10'),
(199081, 'Scar on the right leg', 5, 176, 69.1, 'O+', 'Pollen', '1995-09-11'),

-- For sid 199082
(199082, 'Scar on the right hand', 3, 180, 72.8, 'AB-', 'Dust', '1995-09-12'),
(199082, 'Birthmark on the left leg', 4, 180, 72.8, 'AB-', 'Dust', '1995-09-13'),

-- For sid 199083
(199083, 'Birthmark on the left leg', 2, 168, 64.5, 'A+', 'Peanuts', '1995-09-14'),
(199083, 'Scar on the left arm', 3, 168, 64.5, 'A+', 'Peanuts', '1995-09-15'),

-- For sid 199084
(199084, 'Scar on the forehead', 4, 172, 67.0, 'B+', 'None', '1995-09-16'),
(199084, 'Birthmark on the back', 5, 172, 67.0, 'B+', 'None', '1995-09-17'),

-- For sid 199085
(199085, 'Birthmark on the forehead', 3, 176, 69.4, 'AB-', 'Pollen', '1995-09-18'),
(199085, 'Scar on the left leg', 4, 176, 69.4, 'AB-', 'Pollen', '1995-09-19'),

-- For sid 199086
(199086, 'Scar on the right hand', 2, 180, 72.2, 'O-', 'Shellfish', '1995-09-20'),
(199086, 'Birthmark on the left leg', 3, 180, 72.2, 'O-', 'Shellfish', '1995-09-21'),

-- For sid 199087
(199087, 'Scar on the left leg', 4, 170, 65.7, 'A-', 'Peanuts', '1995-09-22'),
(199087, 'Birthmark on the shoulder', 5, 170, 65.7, 'A-', 'Peanuts', '1995-09-23'),

-- For sid 199088
(199088, 'Birthmark on the right hand', 3, 174, 68.3, 'O+', 'Dust', '1995-09-24'),
(199088, 'Scar on the right leg', 4, 174, 68.3, 'O+', 'Dust', '1995-09-25'),

-- For sid 199089
(199089, 'Scar on the back', 2, 178, 71.0, 'AB+', 'Pollen', '1995-09-26'),
(199089, 'Birthmark on the forehead', 3, 178, 71.0, 'AB+', 'Pollen', '1995-09-27'),

-- For sid 199090
(199090, 'Scar on the right hand', 4, 168, 64.0, 'B-', 'None', '1995-09-28'),
(199090, 'Birthmark on the left leg', 5, 168, 64.0, 'B-', 'None', '1995-09-29'),

-- For sid 199091
(199091, 'Birthmark on the back', 3, 172, 66.6, 'A+', 'Pollen', '1995-09-30'),
(199091, 'Scar on the forehead', 4, 172, 66.6, 'A+', 'Pollen', '1995-10-01'),

-- For sid 199092
(199092, 'Birthmark on the forehead', 2, 176, 69.3, 'O-', 'Dust', '1995-10-02'),
(199092, 'Scar on the left leg', 3, 176, 69.3, 'O-', 'Dust', '1995-10-03'),

-- For sid 199093
(199093, 'Scar on the right leg', 4, 180, 72.4, 'AB-', 'Peanuts', '1995-10-04'),
(199093, 'Birthmark on the left leg', 5, 180, 72.4, 'AB-', 'Peanuts', '1995-10-05'),

-- For sid 199094
(199094, 'Birthmark on the right leg', 3, 167, 63.8, 'B+', 'Shellfish', '1995-10-06'),
(199094, 'Scar on the left arm', 4, 167, 63.8, 'B+', 'Shellfish', '1995-10-07'),

-- For sid 199095
(199095, 'Scar on the right hand', 2, 171, 66.2, 'O+', 'Pollen', '1995-10-08'),
(199095, 'Birthmark on the left leg', 3, 171, 66.2, 'O+', 'Pollen', '1995-10-09'),

-- For sid 199096
(199096, 'Scar on the left leg', 4, 175, 68.6, 'AB-', 'None', '1995-10-10'),
(199096, 'Birthmark on the left arm', 5, 175, 68.6, 'AB-', 'None', '1995-10-11'),

-- For sid 199097
(199097, 'Birthmark on the back', 3, 179, 72.1, 'B-', 'Dust', '1995-10-12'),
(199097, 'Scar on the forehead', 4, 179, 72.1, 'B-', 'Dust', '1995-10-13'),

-- For sid 199098
(199098, 'Birthmark on the right hand', 2, 169, 64.9, 'A+', 'Pollen', '1995-10-14'),
(199098, 'Scar on the right leg', 3, 169, 64.9, 'A+', 'Pollen', '1995-10-15'),

-- For sid 199099
(199099, 'Scar on the back', 4, 173, 67.5, 'O-', 'Shellfish', '1995-10-16'),
(199099, 'Birthmark on the forehead', 5, 173, 67.5, 'O-', 'Shellfish', '1995-10-17'),

-- For sid 199100
(199100, 'Scar on the left arm', 3, 175, 70.5, 'AB+', 'Pollen', '1995-04-03'),
(199100, 'Birthmark on the right leg', 4, 175, 70.5, 'AB+', 'Pollen', '1995-04-04'),

-- For sid 199101
(199101, 'Scar on the back', 2, 180, 75.2, 'O+', 'None', '1995-04-05'),
(199101, 'Birthmark on the shoulder', 3, 180, 75.2, 'O+', 'None', '1995-04-06'),

-- For sid 199102
(199102, 'Scar on the forehead', 4, 165, 55.0, 'A-', 'Peanuts', '1995-04-07'),
(199102, 'Birthmark on the left hand', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-08'),

-- For sid 199103
(199103, 'Birthmark on the right leg', 3, 170, 60.0, 'B+', 'Dust', '1995-04-09'),
(199103, 'Scar on the left arm', 4, 170, 60.0, 'B+', 'Dust', '1995-04-10'),

-- For sid 199104
(199104, 'Scar on the right hand', 2, 172, 65.5, 'AB-', 'Pollen', '1995-04-11'),
(199104, 'Birthmark on the left leg', 3, 172, 65.5, 'AB-', 'Pollen', '1995-04-12'),

-- For sid 199105
(199105, 'Birthmark on the forehead', 4, 178, 70.2, 'A+', 'Peanuts', '1995-04-13'),
(199105, 'Scar on the right leg', 5, 178, 70.2, 'A+', 'Peanuts', '1995-04-14'),

-- For sid 199106
(199106, 'Scar on the right hand', 3, 175, 68.0, 'O-', 'Dust', '1995-04-15'),
(199106, 'Birthmark on the left leg', 4, 175, 68.0, 'O-', 'Dust', '1995-04-16'),

-- For sid 199107
(199107, 'Birthmark on the left hand', 2, 180, 72.3, 'A+', 'Pollen', '1995-04-17'),
(199107, 'Scar on the right arm', 3, 180, 72.3, 'A+', 'Pollen', '1995-04-18'),

-- For sid 199108
(199108, 'Scar on the back', 4, 167, 63.8, 'B-', 'None', '1995-04-19'),
(199108, 'Birthmark on the forehead', 5, 167, 63.8, 'B-', 'None', '1995-04-20'),

-- For sid 199109
(199109, 'Birthmark on the back', 3, 172, 67.1, 'AB+', 'Shellfish', '1995-04-21'),
(199109, 'Scar on the right leg', 4, 172, 67.1, 'AB+', 'Shellfish', '1995-04-22'),

-- For sid 199110
(199110, 'Scar on the left leg', 2, 179, 71.4, 'O+', 'Dust', '1995-04-23'),
(199110, 'Birthmark on the left arm', 3, 179, 71.4, 'O+', 'Dust', '1995-04-24'),

-- For sid 199111
(199111, 'Birthmark on the left arm', 4, 173, 66.7, 'A-', 'Pollen', '1995-04-25'),
(199111, 'Scar on the right leg', 5, 173, 66.7, 'A-', 'Pollen', '1995-04-26'),

-- For sid 199112
(199112, 'Scar on the back', 3, 177, 69.0, 'B+', 'None', '1995-04-27'),
(199112, 'Birthmark on the shoulder', 4, 177, 69.0, 'B+', 'None', '1995-04-28'),

-- For sid 199113
(199113, 'Birthmark on the right leg', 2, 168, 61.5, 'AB-', 'Peanuts', '1995-04-29'),
(199113, 'Scar on the left arm', 3, 168, 61.5, 'AB-', 'Peanuts', '1995-04-30'),

-- For sid 199114
(199114, 'Scar on the right leg', 4, 176, 70.2, 'O+', 'Dust', '1995-05-01'),
(199114, 'Birthmark on the left hand', 5, 176, 70.2, 'O+', 'Dust', '1995-05-02'),

-- For sid 199115
(199115, 'Birthmark on the left leg', 3, 181, 74.8, 'A+', 'Pollen', '1995-05-03'),
(199115, 'Scar on the right arm', 4, 181, 74.8, 'A+', 'Pollen', '1995-05-04'),

-- For sid 199116
(199116, 'Scar on the forehead', 2, 170, 65.0, 'B-', 'None', '1995-05-05'),
(199116, 'Birthmark on the back', 3, 170, 65.0, 'B-', 'None', '1995-05-06'),

-- For sid 199117
(199117, 'Birthmark on the forehead', 4, 174, 68.3, 'AB+', 'Shellfish', '1995-05-07'),
(199117, 'Scar on the left leg', 5, 174, 68.3, 'AB+', 'Shellfish', '1995-05-08'),

-- For sid 199118
(199118, 'Scar on the right leg', 3, 178, 72.0, 'O-', 'Dust', '1995-05-09'),
(199118, 'Birthmark on the left arm', 4, 178, 72.0, 'O-', 'Dust', '1995-05-10'),

-- For sid 199119
(199119, 'Birthmark on the right arm', 2, 179, 69.5, 'A-', 'Pollen', '1995-05-11'),
(199119, 'Scar on the left hand', 3, 179, 69.5, 'A-', 'Pollen', '1995-05-12'),

-- For sid 199120
(199120, 'Scar on the back', 4, 172, 65.2, 'B+', 'None', '1995-05-13'),
(199120, 'Birthmark on the shoulder', 5, 172, 65.2, 'B+', 'None', '1995-05-14'),

-- For sid 199121
(199121, 'Birthmark on the right leg', 3, 177, 70.0, 'AB-', 'Peanuts', '1995-05-15'),
(199121, 'Scar on the left arm', 4, 177, 70.0, 'AB-', 'Peanuts', '1995-05-16'),

-- For sid 199122
(199122, 'Scar on the right hand', 2, 168, 62.3, 'O+', 'Dust', '1995-05-17'),
(199122, 'Birthmark on the left leg', 3, 168, 62.3, 'O+', 'Dust', '1995-05-18'),

-- For sid 199123
(199123, 'Birthmark on the forehead', 4, 179, 71.2, 'A+', 'Pollen', '1995-05-19'),
(199123, 'Scar on the right leg', 5, 179, 71.2, 'A+', 'Pollen', '1995-05-20'),

-- For sid 199124
(199124, 'Scar on the right hand', 3, 176, 68.5, 'B-', 'None', '1995-05-21'),
(199124, 'Birthmark on the left leg', 4, 176, 68.5, 'B-', 'None', '1995-05-22'),

-- For sid 199125
(199125, 'Birthmark on the left hand', 2, 183, 76.0, 'AB+', 'Shellfish', '1995-05-23'),
(199125, 'Scar on the right arm', 3, 183, 76.0, 'AB+', 'Shellfish', '1995-05-24'),

-- For sid 199126
(199126, 'Scar on the back', 4, 173, 67.2, 'O-', 'Dust', '1995-05-25'),
(199126, 'Birthmark on the forehead', 5, 173, 67.2, 'O-', 'Dust', '1995-05-26'),

-- For sid 199127
(199127, 'Birthmark on the back', 3, 178, 70.1, 'A-', 'Pollen', '1995-05-27'),
(199127, 'Scar on the right leg', 4, 178, 70.1, 'A-', 'Pollen', '1995-05-28'),

-- For sid 199128
(199128, 'Scar on the left leg', 2, 175, 67.3, 'B+', 'None', '1995-05-29'),
(199128, 'Birthmark on the left arm', 3, 175, 67.3, 'B+', 'None', '1995-05-30'),

-- For sid 199129
(199129, 'Birthmark on the left arm', 4, 180, 72.5, 'AB-', 'Peanuts', '1995-05-31'),
(199129, 'Scar on the right leg', 5, 180, 72.5, 'AB-', 'Peanuts', '1995-06-01'),

-- For sid 199130
(199130, 'Scar on the right hand', 3, 169, 63.0, 'O+', 'Dust', '1995-06-02'),
(199130, 'Birthmark on the left leg', 4, 169, 63.0, 'O+', 'Dust', '1995-06-03'),

-- For sid 199131
(199131, 'Birthmark on the right leg', 2, 172, 68.2, 'A+', 'Pollen', '1995-06-04'),
(199131, 'Scar on the left arm', 3, 172, 68.2, 'A+', 'Pollen', '1995-06-05'),

-- For sid 199132
(199132, 'Scar on the back', 4, 177, 71.0, 'B-', 'None', '1995-06-06'),
(199132, 'Birthmark on the shoulder', 5, 177, 71.0, 'B-', 'None', '1995-06-07'),

-- For sid 199133
(199133, 'Birthmark on the right leg', 3, 179, 73.1, 'AB+', 'Shellfish', '1995-06-08'),
(199133, 'Scar on the left arm', 4, 179, 73.1, 'AB+', 'Shellfish', '1995-06-09'),

-- For sid 199134
(199134, 'Scar on the right leg', 2, 174, 69.0, 'O-', 'Dust', '1995-06-10'),
(199134, 'Birthmark on the left hand', 3, 174, 69.0, 'O-', 'Dust', '1995-06-11'),

-- For sid 199135
(199135, 'Birthmark on the forehead', 4, 171, 66.3, 'A-', 'Pollen', '1995-06-12'),
(199135, 'Scar on the right leg', 5, 171, 66.3, 'A-', 'Pollen', '1995-06-13'),

-- For sid 199136
(199136, 'Scar on the right hand', 3, 178, 70.5, 'B+', 'None', '1995-06-14'),
(199136, 'Birthmark on the left leg', 4, 178, 70.5, 'B+', 'None', '1995-06-15'),

-- For sid 199137
(199137, 'Birthmark on the left leg', 2, 175, 68.1, 'AB-', 'Peanuts', '1995-06-16'),
(199137, 'Scar on the right arm', 3, 175, 68.1, 'AB-', 'Peanuts', '1995-06-17'),

-- For sid 199138
(199138, 'Scar on the back', 4, 180, 73.0, 'O+', 'Dust', '1995-06-18'),
(199138, 'Birthmark on the forehead', 5, 180, 73.0, 'O+', 'Dust', '1995-06-19'),

-- For sid 199139
(199139, 'Birthmark on the back', 3, 170, 65.2, 'A+', 'Pollen', '1995-06-20'),
(199139, 'Scar on the left leg', 4, 170, 65.2, 'A+', 'Pollen', '1995-06-21'),

-- For sid 199140
(199140, 'Scar on the left leg', 2, 179, 71.3, 'B-', 'None', '1995-06-22'),
(199140, 'Birthmark on the left arm', 3, 179, 71.3, 'B-', 'None', '1995-06-23'),

-- For sid 199141
(199141, 'Birthmark on the left arm', 4, 173, 67.5, 'AB+', 'Shellfish', '1995-06-24'),
(199141, 'Scar on the right leg', 5, 173, 67.5, 'AB+', 'Shellfish', '1995-06-25'),

-- For sid 199142
(199142, 'Scar on the back', 3, 177, 70.2, 'O-', 'Dust', '1995-06-26'),
(199142, 'Birthmark on the shoulder', 4, 177, 70.2, 'O-', 'Dust', '1995-06-27'),

-- For sid 199143
(199143, 'Birthmark on the right leg', 2, 168, 62.8, 'A-', 'Pollen', '1995-06-28'),
(199143, 'Scar on the left arm', 3, 168, 62.8, 'A-', 'Pollen', '1995-06-29'),

-- For sid 199144
(199144, 'Scar on the right leg', 4, 176, 69.3, 'B+', 'None', '1995-06-30'),
(199144, 'Birthmark on the left hand', 5, 176, 69.3, 'B+', 'None', '1995-07-01'),

-- For sid 199145
(199145, 'Birthmark on the left leg', 3, 181, 74.1, 'AB-', 'Peanuts', '1995-07-02'),
(199145, 'Scar on the right arm', 4, 181, 74.1, 'AB-', 'Peanuts', '1995-07-03'),

-- For sid 199146
(199146, 'Scar on the forehead', 2, 170, 65.5, 'O+', 'Shellfish', '1995-07-04'),
(199146, 'Birthmark on the back', 3, 170, 65.5, 'O+', 'Shellfish', '1995-07-05'),

-- For sid 199147
(199147, 'Birthmark on the forehead', 4, 174, 68.7, 'A+', 'Dust', '1995-07-06'),
(199147, 'Scar on the left leg', 5, 174, 68.7, 'A+', 'Dust', '1995-07-07'),

-- For sid 199148
(199148, 'Scar on the right hand', 3, 178, 71.0, 'B-', 'Pollen', '1995-07-08'),
(199148, 'Birthmark on the left leg', 4, 178, 71.0, 'B-', 'Pollen', '1995-07-09'),

-- For sid 199149
(199149, 'Birthmark on the right arm', 2, 179, 72.1, 'AB+', 'None', '1995-07-10'),
(199149, 'Scar on the left leg', 3, 179, 72.1, 'AB+', 'None', '1995-07-11'),

-- For sid 199150
(199150, 'Scar on the back', 4, 172, 66.8, 'O-', 'Peanuts', '1995-07-12'),
(199150, 'Birthmark on the shoulder', 5, 172, 66.8, 'O-', 'Peanuts', '1995-07-13'),

-- For sid 199151
(199151, 'Birthmark on the right leg', 3, 177, 70.3, 'A-', 'Shellfish', '1995-07-14'),
(199151, 'Scar on the left arm', 4, 177, 70.3, 'A-', 'Shellfish', '1995-07-15'),

-- For sid 199152
(199152, 'Scar on the right hand', 2, 168, 63.5, 'B+', 'Dust', '1995-07-16'),
(199152, 'Birthmark on the left leg', 3, 168, 63.5, 'B+', 'Dust', '1995-07-17'),

-- For sid 199153
(199153, 'Birthmark on the forehead', 4, 179, 72.0, 'AB-', 'Pollen', '1995-07-18'),
(199153, 'Scar on the right leg', 5, 179, 72.0, 'AB-', 'Pollen', '1995-07-19'),

-- For sid 199154
(199154, 'Scar on the right hand', 3, 176, 68.3, 'O+', 'None', '1995-07-20'),
(199154, 'Birthmark on the left leg', 4, 176, 68.3, 'O+', 'None', '1995-07-21'),

-- For sid 199155
(199155, 'Birthmark on the left hand', 2, 183, 75.0, 'A+', 'Peanuts', '1995-07-22'),
(199155, 'Scar on the right arm', 3, 183, 75.0, 'A+', 'Peanuts', '1995-07-23'),

-- For sid 199156
(199156, 'Scar on the back', 4, 173, 67.5, 'B-', 'Shellfish', '1995-07-24'),
(199156, 'Birthmark on the forehead', 5, 173, 67.5, 'B-', 'Shellfish', '1995-07-25'),

-- For sid 199157
(199157, 'Birthmark on the back', 3, 178, 70.2, 'AB+', 'Dust', '1995-07-26'),
(199157, 'Scar on the right leg', 4, 178, 70.2, 'AB+', 'Dust', '1995-07-27'),

-- For sid 199158
(199158, 'Scar on the left leg', 2, 175, 67.8, 'O-', 'Pollen', '1995-07-28'),
(199158, 'Birthmark on the left arm', 3, 175, 67.8, 'O-', 'Pollen', '1995-07-29'),

-- For sid 199159
(199159, 'Birthmark on the left arm', 4, 180, 72.3, 'A-', 'None', '1995-07-30'),
(199159, 'Scar on the right leg', 5, 180, 72.3, 'A-', 'None', '1995-07-31'),

-- For sid 199160
(199160, 'Scar on the right hand', 3, 169, 63.8, 'B+', 'Peanuts', '1995-08-01'),
(199160, 'Birthmark on the left leg', 4, 169, 63.8, 'B+', 'Peanuts', '1995-08-02'),

-- For sid 199161
(199161, 'Birthmark on the right leg', 2, 172, 68.5, 'AB-', 'Shellfish', '1995-08-03'),
(199161, 'Scar on the left arm', 3, 172, 68.5, 'AB-', 'Shellfish', '1995-08-04'),

-- For sid 199162
(199162, 'Scar on the back', 4, 177, 71.0, 'O+', 'Dust', '1995-08-05'),
(199162, 'Birthmark on the shoulder', 5, 177, 71.0, 'O+', 'Dust', '1995-08-06'),

-- For sid 199163
(199163, 'Birthmark on the right leg', 3, 179, 73.2, 'A+', 'Pollen', '1995-08-07'),
(199163, 'Scar on the left arm', 4, 179, 73.2, 'A+', 'Pollen', '1995-08-08'),

-- For sid 199164
(199164, 'Scar on the right leg', 2, 174, 69.1, 'B-', 'None', '1995-08-09'),
(199164, 'Birthmark on the left hand', 3, 174, 69.1, 'B-', 'None', '1995-08-10'),

-- For sid 199165
(199165, 'Birthmark on the forehead', 4, 171, 66.5, 'AB+', 'Peanuts', '1995-08-11'),
(199165, 'Scar on the right leg', 5, 171, 66.5, 'AB+', 'Peanuts', '1995-08-12'),

-- For sid 199166
(199166, 'Scar on the right hand', 3, 178, 70.8, 'O-', 'Dust', '1995-08-13'),
(199166, 'Birthmark on the left leg', 4, 178, 70.8, 'O-', 'Dust', '1995-08-14'),

-- For sid 199167
(199167, 'Birthmark on the left leg', 2, 175, 68.3, 'A+', 'Pollen', '1995-08-15'),
(199167, 'Scar on the right arm', 3, 175, 68.3, 'A+', 'Pollen', '1995-08-16'),

-- For sid 199168
(199168, 'Scar on the back', 4, 180, 73.1, 'B-', 'Shellfish', '1995-08-17'),
(199168, 'Birthmark on the forehead', 5, 180, 73.1, 'B-', 'Shellfish', '1995-08-18'),

-- For sid 199169
(199169, 'Birthmark on the back', 3, 170, 65.8, 'AB+', 'Dust', '1995-08-19'),
(199169, 'Scar on the left leg', 4, 170, 65.8, 'AB+', 'Dust', '1995-08-20'),

-- For sid 199170
(199170, 'Scar on the left leg', 2, 179, 71.5, 'O+', 'Pollen', '1995-08-21'),
(199170, 'Birthmark on the left arm', 3, 179, 71.5, 'O+', 'Pollen', '1995-08-22'),


-- For sid 199171
(199171, 'Birthmark on the left arm', 4, 173, 67.7, 'A-', 'None', '1995-08-23'),
(199171, 'Scar on the right leg', 5, 173, 67.7, 'A-', 'None', '1995-08-24'),

-- For sid 199172
(199172, 'Scar on the right hand', 3, 178, 71.2, 'B+', 'Peanuts', '1995-08-25'),
(199172, 'Birthmark on the left leg', 4, 178, 71.2, 'B+', 'Peanuts', '1995-08-26'),

-- For sid 199173
(199173, 'Birthmark on the right leg', 2, 172, 68.0, 'AB-', 'Shellfish', '1995-08-27'),
(199173, 'Scar on the left arm', 3, 172, 68.0, 'AB-', 'Shellfish', '1995-08-28'),

-- For sid 199174
(199174, 'Scar on the back', 4, 177, 70.5, 'O-', 'Dust', '1995-08-29'),
(199174, 'Birthmark on the shoulder', 5, 177, 70.5, 'O-', 'Dust', '1995-08-30'),

-- For sid 199175
(199175, 'Birthmark on the right leg', 3, 179, 72.3, 'A+', 'Pollen', '1995-08-31'),
(199175, 'Scar on the left arm', 4, 179, 72.3, 'A+', 'Pollen', '1995-09-01'),

-- For sid 199176
(199176, 'Scar on the right hand', 2, 168, 63.3, 'B-', 'None', '1995-09-02'),
(199176, 'Birthmark on the left leg', 3, 168, 63.3, 'B-', 'None', '1995-09-03'),

-- For sid 199177
(199177, 'Birthmark on the forehead', 4, 179, 71.0, 'AB+', 'Peanuts', '1995-09-04'),
(199177, 'Scar on the right leg', 5, 179, 71.0, 'AB+', 'Peanuts', '1995-09-05'),

-- For sid 199178
(199178, 'Scar on the right hand', 3, 176, 68.8, 'O+', 'Dust', '1995-09-06'),
(199178, 'Birthmark on the left leg', 4, 176, 68.8, 'O+', 'Dust', '1995-09-07'),

(199179, 'Birthmark on the left arm', 3, 175, 70.5, 'AB+', 'Pollen', '1995-04-03'),
(199179, 'Scar on the right leg', 4, 175, 70.5, 'AB+', 'Pollen', '1995-04-04'),

(199180, 'Scar on the back', 2, 180, 75.2, 'O+', 'None', '1995-04-03'),
(199180, 'Birthmark on the shoulder', 3, 180, 75.2, 'O+', 'None', '1995-04-04'),

(199181, 'Birthmark on the right hand', 4, 165, 55.0, 'A-', 'Peanuts', '1995-04-03'),
(199181, 'Scar on the left leg', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-04'),

(199182, 'Scar on the chest', 3, 170, 60.8, 'B+', 'Shellfish', '1995-04-03'),
(199182, 'Birthmark on the left leg', 4, 170, 60.8, 'B+', 'Shellfish', '1995-04-04'),

(199183, 'Birthmark on the forehead', 5, 185, 80.0, 'O-', 'Penicillin', '1995-04-03'),
(199183, 'Scar on the back', 3, 185, 80.0, 'O-', 'Penicillin', '1995-04-04'),

(199184, 'Scar on the left arm', 2, 160, 50.0, 'AB-', 'Dust', '1995-04-03'),
(199184, 'Birthmark on the right leg', 3, 160, 50.0, 'AB-', 'Dust', '1995-04-04'),

(199185, 'Birthmark on the chest', 4, 175, 70.5, 'B-', 'Pollen', '1995-04-03'),
(199185, 'Scar on the left hand', 5, 175, 70.5, 'B-', 'Pollen', '1995-04-04'),

(199186, 'Scar on the left leg', 3, 180, 75.2, 'O+', 'None', '1995-04-03'),
(199186, 'Birthmark on the shoulder', 4, 180, 75.2, 'O+', 'None', '1995-04-04'),

(199187, 'Birthmark on the right hand', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-03'),
(199187, 'Scar on the left leg', 3, 165, 55.0, 'A-', 'Peanuts', '1995-04-04'),

(199188, 'Scar on the chest', 4, 170, 60.8, 'B+', 'Shellfish', '1995-04-03'),
(199188, 'Birthmark on the left leg', 5, 170, 60.8, 'B+', 'Shellfish', '1995-04-04'),

(199189, 'Birthmark on the forehead', 3, 185, 80.0, 'O-', 'Penicillin', '1995-04-03'),
(199189, 'Scar on the back', 4, 185, 80.0, 'O-', 'Penicillin', '1995-04-04'),

(199190, 'Scar on the left arm', 5, 160, 50.0, 'AB-', 'Dust', '1995-04-03'),
(199190, 'Birthmark on the right leg', 3, 160, 50.0, 'AB-', 'Dust', '1995-04-04'),

(199191, 'Birthmark on the chest', 4, 175, 70.5, 'B-', 'Pollen', '1995-04-03'),
(199191, 'Scar on the left hand', 5, 175, 70.5, 'B-', 'Pollen', '1995-04-04'),

(199192, 'Scar on the left leg', 3, 180, 75.2, 'O+', 'None', '1995-04-03'),
(199192, 'Birthmark on the shoulder', 4, 180, 75.2, 'O+', 'None', '1995-04-04'),

(199193, 'Birthmark on the right hand', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-03'),
(199193, 'Scar on the left leg', 3, 165, 55.0, 'A-', 'Peanuts', '1995-04-04'),

(199194, 'Scar on the chest', 4, 170, 60.8, 'B+', 'Shellfish', '1995-04-03'),
(199194, 'Birthmark on the left leg', 5, 170, 60.8, 'B+', 'Shellfish', '1995-04-04'),

(199195, 'Birthmark on the forehead', 3, 185, 80.0, 'O-', 'Penicillin', '1995-04-03'),
(199195, 'Scar on the back', 4, 185, 80.0, 'O-', 'Penicillin', '1995-04-04'),

(199196, 'Scar on the left arm', 5, 160, 50.0, 'AB-', 'Dust', '1995-04-03'),
(199196, 'Birthmark on the right leg', 3, 160, 50.0, 'AB-', 'Dust', '1995-04-04'),

(199197, 'Birthmark on the chest', 4, 175, 70.5, 'B-', 'Pollen', '1995-04-03'),
(199197, 'Scar on the left hand', 5, 175, 70.5, 'B-', 'Pollen', '1995-04-04'),

(199198, 'Scar on the left leg', 3, 180, 75.2, 'O+', 'None', '1995-04-03'),
(199198, 'Birthmark on the shoulder', 4, 180, 75.2, 'O+', 'None', '1995-04-04'),

(199199, 'Birthmark on the right hand', 5, 165, 55.0, 'A-', 'Peanuts', '1995-04-03'),
(199199, 'Scar on the left leg', 3, 165, 55.0, 'A-', 'Peanuts', '1995-04-04'),

(199200, 'Scar on the chest', 4, 170, 60.8, 'B+', 'Shellfish', '1995-04-03'),
(199200, 'Birthmark on the left leg', 5, 170, 60.8, 'B+', 'Shellfish', '1995-04-04');

INSERT INTO Mission (missionid, name, location, dateofcommencement, missionhead, dateofcompletion) VALUES
(501, 'Operation Skyfall', 'Kashmir', '2001-07-15', 199001, '2001-08-25'),
(502, 'Operation Thunder', 'Rajasthan', '1998-05-10', 199101, '1998-06-20'),
(503, 'Operation Blue Thunder', 'Andaman Islands', '2005-09-02', 199101, '2005-10-15'),
(504, 'Operation Red Dawn', 'Punjab', '1994-11-28', 199111, '1995-01-10'),
(505, 'Operation Black Hawk', 'Assam', '2000-03-17', 199131, '2000-04-30'),
(506, 'Operation Mountain Strike', 'Afghanistan', '2007-08-10', 199031, '2007-09-20'),
(507, 'Operation Thunderbolt', 'Myanmar', '1997-12-05', 199079, '1998-01-15'),
(508, 'Operation Desert Storm', 'Iran', '2003-04-20', 199122, '2003-05-30'),
(509, 'Operation Crimson Tide', 'Turkmenistan', '1995-10-15', 199067, '1995-11-25'),
(510, 'Operation Black Hawk', 'Bangladesh', '2009-06-12', 199124, '2009-07-25'),
(511, 'Operation Golden Eagle', 'Kyrgyzstan', '1993-03-28', 199047, '1993-05-10'),
(512, 'Operation Swift Strike', 'Uzbekistan', '2001-09-15', 199011, '2001-10-30'),
(513, 'Operation Steel Hammer', 'Russia', '1996-07-20', 199136, '1996-08-30'),
(514, 'Operation Firestorm', 'Kazakhstan', '2005-11-03', 199175, '2005-12-15'),
(515, 'Operation Iron Fist', 'Iraq', '1994-05-18', 199051, '1994-06-30'),
(516, 'Operation Diamondback', 'Sri Lanka', '2007-02-12', 199092, '2007-03-25'),
(517, 'Operation Silent Thunder', 'Nepal', '1998-08-25', 199188, '1998-10-05'),
(518, 'Operation Swift Justice', 'Pakistan', '2000-01-10', 199184, '2000-02-20'),
(519, 'Operation Red Dawn', 'China', '2008-04-05', 199156, '2008-05-15'),
(520, 'Operation Silver Fox', 'Tajikistan', '1999-11-18', 199197, '1999-12-30'),
(521, 'Operation Blue Lightning', 'Maldives', '2003-06-22', 199147, '2003-08-02'),
(522, 'Operation Storm Warning', 'Bhutan', '1992-09-30', 199090, '1992-11-10'),
(523, 'Operation Crimson Blade', 'Bangladesh', '2006-07-15', 199120, '2006-08-25'),
(524, 'Operation Eagle Claw', 'Myanmar', '1997-04-10', 199034, '1997-05-20'),
(525, 'Operation Iron Resolve', 'Iran', '2004-11-05', 199048, '2004-12-15'),
(526, 'Operation Desert Fury', 'Turkmenistan', '1996-12-20', 199164, '1997-01-30'),
(527, 'Operation Black Thunder', 'Afghanistan', '2008-10-08', 199043, '2008-11-20'),
(528, 'Operation Silver Dagger', 'Kazakhstan', '2001-05-15', 199099, '2001-06-25'),
(529, 'Operation Golden Dawn', 'Kyrgyzstan', '1994-08-28', 199039, '1994-10-10'),
(530, 'Operation Swift Strike', 'Uzbekistan', '2003-03-15', 199155, '2003-04-25'),
(531, 'Operation Thunderbolt', 'Russia', '1995-06-20', 199121, '1995-07-30'),
(532, 'Operation Firestorm', 'China', '2009-01-12', 199075, '2009-02-25'),
(533, 'Operation Iron Fist', 'Tajikistan', '2002-04-18', 199113, '2002-05-30'),
(534, 'Operation Diamondback', 'Maldives', '1998-11-05', 199068, '1998-12-15'),
(535, 'Operation Silent Thunder', 'Pakistan', '2001-08-10', 199158, '2001-09-20');



INSERT INTO Missionassigned (mid, sid) VALUES 
(501, 199001),
(501, 199002),
(501, 199003),
(501, 199004),
(501, 199005),
(501, 199006),
(501, 199007),
(501, 199008),
(501, 199009),
(501, 199010),
(502, 199011),
(502, 199012),
(502, 199013),
(502, 199014),
(502, 199015),
(502, 199016),
(502, 199017),
(502, 199018),
(502, 199019),
(502, 199020),
(503, 199021),
(503, 199022),
(503, 199023),
(503, 199024),
(503, 199025),
(503, 199026),
(503, 199027),
(503, 199028),
(503, 199029),
(503, 199030),
(503, 199031),
(504, 199032),
(504, 199033),
(504, 199034),
(504, 199035),
(504, 199036),
(504, 199037),
(504, 199038),
(504, 199039),
(504, 199040),
(504, 199041),
(505, 199042),
(505, 199043),
(505, 199044),
(505, 199045),
(505, 199046),
(505, 199047),
(505, 199048),
(505, 199049),
(505, 199050),
(506, 199051),
(506, 199052),
(506, 199053),
(506, 199054),
(506, 199055),
(506, 199056),
(506, 199057),
(506, 199058),
(506, 199059),
(506, 199060),
(507, 199061),
(507, 199062),
(507, 199063),
(507, 199064),
(507, 199065),
(507, 199066),
(507, 199067),
(507, 199068),
(507, 199069),
(507, 199070),
(507, 199071),
(507, 199072),
(508, 199073),
(508, 199074),
(508, 199075),
(508, 199076),
(508, 199077),
(508, 199078),
(508, 199079),
(508, 199080),
(508, 199081),
(508, 199082),
(509, 199083),
(509, 199084),
(509, 199085),
(509, 199086),
(509, 199087),
(509, 199088),
(509, 199089),
(509, 199090),
(509, 199091),
(509, 199092),
(509, 199093),
(510, 199094),
(510, 199095),
(510, 199096),
(510, 199097),
(510, 199098),
(510, 199099),
(510, 199100),
(510, 199101),
(511, 199102),
(511, 199103),
(511, 199104),
(511, 199105),
(511, 199106),
(511, 199107),
(511, 199108),
(511, 199109),
(511, 199110),
(511, 199111),
(511, 199112),
(512, 199113),
(512, 199114),
(512, 199115),
(512, 199116),
(512, 199117),
(512, 199118),
(512, 199119),
(512, 199120),
(512, 199121),
(512, 199122),
(513, 199123),
(513, 199124),
(513, 199125),
(513, 199126),
(513, 199127),
(513, 199128),
(513, 199129),
(513, 199130),
(513, 199131),
(513, 199132),
(513, 199133),
(514, 199134),
(514, 199135),
(514, 199136),
(514, 199137),
(514, 199138),
(514, 199139),
(514, 199140),
(514, 199141),
(514, 199142),
(514, 199143),
(515, 199144),
(515, 199145),
(515, 199146),
(515, 199147),
(515, 199148),
(515, 199149),
(515, 199150),
(515, 199151),
(515, 199152),
(515, 199153),
(516, 199154),
(516, 199155),
(516, 199156),
(516, 199157),
(516, 199158),
(516, 199159),
(516, 199160),
(516, 199161),
(516, 199162),
(516, 199163),
(517, 199164),
(517, 199165),
(517, 199166),
(517, 199167),
(517, 199168),
(517, 199169),
(517, 199170),
(517, 199171),
(517, 199172),
(517, 199173),
(517, 199174),
(518, 199175),
(518, 199176),
(518, 199177),
(518, 199178),
(518, 199179),
(518, 199180),
(518, 199181),
(518, 199182),
(518, 199183),
(518, 199184),
(518, 199185),
(519, 199186),
(519, 199187),
(519, 199188),
(519, 199189),
(519, 199190),
(519, 199191),
(519, 199192),
(519, 199193),
(519, 199194),
(519, 199195),
(520, 199196),
(520, 199197),
(520, 199198),
(520, 199199),
(520, 199200),
(521, 199001),
(521, 199002),
(521, 199003),
(521, 199004),
(521, 199005),
(521, 199006),
(521, 199007),
(521, 199008),
(521, 199009),
(521, 199010),
(522, 199011),
(522, 199012),
(522, 199013),
(522, 199014),
(522, 199015),
(522, 199016),
(522, 199017),
(522, 199018),
(522, 199019),
(522, 199020),
(522, 199021),
(523, 199022),
(523, 199023),
(523, 199024),
(523, 199025),
(523, 199026),
(523, 199027),
(523, 199028),
(523, 199029),
(523, 199030),
(523, 199031),
(524, 199032),
(524, 199033),
(524, 199034),
(524, 199035),
(524, 199036),
(524, 199037),
(524, 199038),
(524, 199039),
(524, 199040),
(524, 199041),
(524, 199042),
(525, 199043),
(525, 199044),
(525, 199045),
(525, 199046),
(525, 199047),
(525, 199048),
(525, 199049),
(525, 199050),
(525, 199051),
(525, 199052),
(526, 199053),
(526, 199054),
(526, 199055),
(526, 199056),
(526, 199057),
(526, 199058),
(526, 199059),
(526, 199060),
(526, 199061),
(526, 199062),
(527, 199063),
(527, 199064),
(527, 199065),
(527, 199066),
(527, 199067),
(527, 199068),
(527, 199069),
(527, 199070),
(527, 199071),
(527, 199072),
(527, 199073),
(527, 199074),
(528, 199075),
(528, 199076),
(528, 199077),
(528, 199078),
(528, 199079),
(528, 199080),
(528, 199081),
(528, 199082),
(528, 199083),
(528, 199084),
(529, 199085),
(529, 199086),
(529, 199087),
(529, 199088),
(529, 199089),
(529, 199090),
(529, 199091),
(529, 199092),
(529, 199093),
(529, 199094),
(529, 199095),
(530, 199096),
(530, 199097),
(530, 199098),
(530, 199099),
(530, 199100),
(530, 199101),
(530, 199102),
(530, 199103),
(530, 199104),
(530, 199105),
(530, 199106),
(530, 199107),
(530, 199108),
(530, 199109),
(531, 199110),
(531, 199111),
(531, 199112),
(531, 199113),
(531, 199114),
(531, 199115),
(531, 199116),
(531, 199117),
(531, 199118),
(531, 199119),
(532, 199120),
(532, 199121),
(532, 199122),
(532, 199123),
(532, 199124),
(532, 199125),
(532, 199126),
(532, 199127),
(532, 199128),
(532, 199129),
(533, 199130),
(533, 199131),
(533, 199132),
(533, 199133),
(533, 199134),
(533, 199135),
(533, 199136),
(533, 199137),
(533, 199138),
(533, 199139),
(533, 199140),
(534, 199141),
(534, 199142),
(534, 199143),
(534, 199144),
(534, 199145),
(534, 199146),
(534, 199147),
(534, 199148),
(534, 199149),
(534, 199150),
(535, 199151),
(535, 199152),
(535, 199153),
(535, 199154),
(535, 199155),
(535, 199156),
(535, 199157),
(535, 199158),
(535, 199159),
(535, 199160),
(535, 199161);

INSERT INTO Assignedaircraft (mid, serialno) VALUES
(501, 1001),
(501, 1002),
(502, 1003),
(502, 1004),
(503, 1005),
(504, 1006),
(504, 1007),
(505, 1008),
(506, 1009),
(506, 1010),
(507, 1011),
(508, 1012),
(509, 1013),
(510, 1014),
(511, 1015),
(512, 1016),
(513, 1017),
(514, 1018),
(515, 1019),
(516, 1020),
(517, 1021),
(518, 1022),
(519, 1023),
(520, 1024),
(521, 1025),
(522, 1026),
(523, 1027),
(524, 1028),
(525, 1029),
(526, 1030),
(527, 1031),
(528, 1032),
(529, 1033),
(530, 1034),
(531, 1035),
(532, 1036),
(533, 1037),
(534, 1038),
(535, 1039),
(535, 1040),
(501, 1041),
(501, 1042),
(502, 1043),
(503, 1044),
(503, 1045),
(504, 1046),
(505, 1047),
(505, 1048),
(506, 1049),
(507, 1050),
(507, 1051),
(508, 1052),
(509, 1053),
(509, 1054),
(510, 1055),
(511, 1056),
(512, 1057),
(513, 1058),
(513, 1059),
(514, 1060),
(515, 1061),
(516, 1062),
(517, 1063),
(518, 1064),
(519, 1065),
(520, 1066),
(521, 1067),
(522, 1068),
(523, 1069),
(524, 1070),
(525, 1071),
(526, 1072),
(527, 1073),
(528, 1074),
(529, 1075),
(530, 1076),
(531, 1077),
(532, 1078),
(533, 1079),
(534, 1080),
(535, 1081),
(535, 1082);


INSERT INTO stationedat (unittype, unitname, geographicalcoordinate) VALUES

('flying', 'No.1 Squadron', '26.2935,73.0169'),
('flying', 'No.1 Squadron', '28.5861,77.3197'),
('flying', 'No.2 Squadron', '17.4500,78.5000'),
('flying', 'No.2 Squadron', '16.5075,80.6480'),
('flying', 'No.3 Squadron', '17.7215,83.3159'),
('flying', 'No.3 Squadron', '22.5697,88.3697'),
('flying', 'No.4 Squadron', '26.3016,78.2370'),
('flying', 'No.4 Squadron', '28.6415,77.2167'),
('flying', 'No.5 Squadron', '30.1892,78.1752'),
('flying', 'No.5 Squadron', '13.0604,80.2496'),

('missile', 'No.34 Squadron', '22.3039,70.8022'),
('missile', 'No.34 Squadron', '17.4524,78.5718'),
('missile', 'No.46 Squadron', '28.5679,77.1035'),
('missile', 'No.46 Squadron', '17.4382,78.4074'),
('missile', 'No.58 Squadron', '28.6456,77.0882'),
('missile', 'No.58 Squadron', '20.1196,85.5942'),
('missile', 'No.60 Squadron', '17.7262,83.2863'),
('missile', 'No.60 Squadron', '28.5623,77.1035'),
('missile', 'No.61 Squadron', '26.8341,80.9470'),
('missile', 'No.61 Squadron', '17.7016,83.2310'),

('signal', '254 Signal Unit', '26.2935,73.0169'),
('signal', '254 Signal Unit', '28.5861,77.3197'),
('signal', '12 Signal Unit', '17.4500,78.5000'),
('signal', '12 Signal Unit', '16.5075,80.6480'),
('signal', '35 Signal Unit', '17.7215,83.3159'),
('signal', '35 Signal Unit', '22.5697,88.3697'),
('signal', '55 Signal Unit', '26.3016,78.2370'),
('signal', '55 Signal Unit', '28.6415,77.2167'),
('signal', '149 Signal Unit', '30.1892,78.1752'),
('signal', '149 Signal Unit', '13.0604,80.2496'),


('operational bases', '1 Wing', '22.3039,70.8022'),
('operational bases', '1 Wing', '17.4524,78.5718'),
('operational bases', '2 Wing', '28.5679,77.1035'),
('operational bases', '2 Wing', '17.4382,78.4074'),
('operational bases', '3 Wing', '28.6456,77.0882'),
('operational bases', '3 Wing', '20.1196,85.5942'),
('operational bases', '4 Wing', '17.7262,83.2863'),
('operational bases', '4 Wing', '28.5623,77.1035'),
('operational bases', '5 Wing', '26.8341,80.9470'),
('operational bases', '5 Wing', '17.7016,83.2310'),


('maintenance&logistics', 'AFS Chakeri', '26.2935,73.0169'),
('maintenance&logistics', 'AFS Chakeri', '28.5861,77.3197'),
('maintenance&logistics', '1 Base Repair Depot', '17.4500,78.5000'),
('maintenance&logistics', '1 Base Repair Depot', '16.5075,80.6480'),
('maintenance&logistics', '2 Base Repair Depot', '17.7215,83.3159'),
('maintenance&logistics', '2 Base Repair Depot', '22.5697,88.3697'),
('maintenance&logistics', '3 Base Repair Depot', '26.3016,78.2370'),
('maintenance&logistics', '3 Base Repair Depot', '28.6415,77.2167'),
('maintenance&logistics', '4 Base Repair Depot', '30.1892,78.1752'),
('maintenance&logistics', '4 Base Repair Depot', '13.0604,80.2496'),

('command', 'Western Air Command', '22.3039,70.8022'),
('command', 'Western Air Command', '17.4524,78.5718'),
('command', 'Eastern Air Command', '28.5679,77.1035'),
('command', 'Eastern Air Command', '17.4382,78.4074'),
('command', 'Central Air Command', '28.6456,77.0882'),
('command', 'Central Air Command', '20.1196,85.5942'),
('command', 'Southern Air Command', '17.7262,83.2863'),
('command', 'Southern Air Command', '28.5623,77.1035'),
('command', 'South Western Air Command', '26.8341,80.9470'),
('command', 'South Western Air Command', '17.7016,83.2310');

--1 List sid, sname of all Group Captains.
SELECT sid,sname,"rank" 
FROM soldier
WHERE "rank" ='Group Captain';

--2 find the total number of missions each soldier has been assigned to lead, along with their ranks and names, sorted in descending order of the mission count. 
SELECT s.sid, s.rank, s.sname, COUNT(m.missionid) AS mission_count
FROM Soldier s
LEFT JOIN Mission m ON s.sid = m.missionhead
GROUP BY s.sid, s.rank, s.sname
ORDER BY mission_count DESC;

--3  list all the units which are working at a particular station.
SELECT b.station, s.unitname, s.unittype, b.geographicalcoordinate
FROM Base b
natural JOIN Stationedat s order by b.station;

--4 list all soldiers who have received the 'Vayu Sena Medal'.
SELECT s.sid, s.sname
FROM Soldier s
JOIN Awards a ON s.sid = a.sid
WHERE a.awardname = 'Vayu Sena Medal';

--5 List name of soldier'sname and sid who have O- blood group.
SELECT DISTINCT s.sname,s.sid 
FROM medicalinformation AS m 
NATURAL JOIN soldier AS s 
WHERE m.bloodgroup = 'O-';

--6 Count number of soldiers for every bloodgroup.
SELECT bloodgroup, count(sid)
FROM (select distinct sid, bloodgroup from medicalinformation) as s group by bloodgroup;

--7  Display the details of all aircraft with the status 'Inactive', including their serial numbers, variants, and the dates they were transferred into custody (TOC date).
SELECT serialno, variant, TOC_date
FROM Aircraft
WHERE aircraftstatus = 'Inactive';

--8 List soldier name, sid who has worked for missionid= '529'.
SELECT s.sname, s.sid, ma.mid
FROM Soldier as s
JOIN Missionassigned as ma ON s.sid = ma.sid
WHERE ma.mid = 529;


--9  list the mission name and the soldiers who worked for each mission.
SELECT Mission.name AS mission_name, mission.missionid, soldier.sname as soldier_name, soldier.sid  
FROM Mission
JOIN Missionassigned ON Mission.missionid = Missionassigned.mid
JOIN Soldier ON Missionassigned.sid = Soldier.sid;

--10  List all missions headed by soldier id =199101
select m.missionhead,m.name,s.sname from mission as m join soldier as s on m.missionhead=s.sid 
where sid=199101;

--11 List all the soldiers who have headed more than 1 mission 
select m.missionhead,count(m.name) from mission as m  group by m.missionhead 
having count(m.name)>1;

--12 which is the most used aircraft ?
select a.variant from aircraft as a natural join assignedaircraft as aa group by (a.variant) order by count(a.variant) desc limit 1;

--13 Give the name and id of soldier who is working in flying unit and whose fitnesslevel is more than 2 on last ckeckup date 
SELECT s.sid, s.sname FROM Soldier AS s JOIN MedicalInformation AS mi ON s.sid = mi.sid WHERE mi.checkupdate = (SELECT MAX(checkupdate) FROM MedicalInformation WHERE sid = s.sid) AND mi.fitnesslevel > 2 AND unittype = 'flying'

--14 List all soldier whose last checkup date is earlier than DDMMYY
SELECT s.sid, s.sname FROM Soldier AS s JOIN MedicalInformation AS mi ON s.sid = mi.sid WHERE mi.checkupdate = (SELECT MAX(checkupdate) FROM MedicalInformation WHERE sid = s.sid) AND mi.checkupdate < '2002-04-04';

--15 List all soldier who have resigned before their retirement
select s.sid, s.sname from soldier as s where s.remark = 'resigned';

--16 List all soldiers who have served for country more than 15 years
select s.sid, s.sname from soldier as s where (s.dor IS NULL AND ('2024-04-4' - s.doc) > 15) OR (s.doc - s.dor) > 15; 

--17 State wise count of  bases  in ascending order.
SELECT b.state, COUNT(b.station)  FROM base AS b group BY b.state ORDER BY COUNT(b.station);

--18 Number of aircraft of any variant having aircraft status 'Active'.
SELECT a.variant, count(a.serialno)
FROM aircraft AS a
WHERE a.aircraftstatus = 'Active'
GROUP BY a.variant;