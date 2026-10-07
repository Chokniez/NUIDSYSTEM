/* =========================================================
   NU STUDENT ID SYSTEM
   NORMALIZED DATABASE
   BASIC / INTERMEDIATE SQL
   ========================================================= */


/* =========================================================
   1. CREATE DATABASE
   ========================================================= */

CREATE DATABASE NU_Student_ID_System;
GO

USE NU_Student_ID_System;
GO


/* =========================================================
   2. STUDENTS
   Stores student information.
   ========================================================= */

CREATE TABLE Students
(
    StudentID VARCHAR(30) PRIMARY KEY,

    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    Suffix VARCHAR(10),

    Email VARCHAR(100),

    Program VARCHAR(100),
    YearLevel VARCHAR(30)
);
GO


/* =========================================================
   3. STAFF
   Stores staff information.
   Column names follow the Excel table.
   ========================================================= */

CREATE TABLE Staff
(
    StaffID VARCHAR(30) PRIMARY KEY,

    Name VARCHAR(100),

    [S] VARCHAR(100),

    Role VARCHAR(50),

    Status VARCHAR(30),

    [__PowerAppsId__] VARCHAR(100)
);
GO


/* =========================================================
   4. SCHEDULES
   Stores available schedules for each request type.
   ========================================================= */

CREATE TABLE Schedules
(
    ScheduleID VARCHAR(30) PRIMARY KEY,

    ScheduleDate DATE NOT NULL,

    StartTime TIME NOT NULL,

    EndTime TIME NOT NULL,

    RequestType VARCHAR(50) NOT NULL,

    Term VARCHAR(30),

    Venue VARCHAR(100),

    MaxSlots INT NOT NULL,

    CurrentSlots INT,

    AvailabilityStartDate DATE,

    AvailabilityEndDate DATE,

    Status VARCHAR(30),

    /* Basic slot validation */
    CHECK (MaxSlots > 0),

    CHECK (CurrentSlots >= 0),

    CHECK (CurrentSlots <= MaxSlots)
);
GO


/* =========================================================
   5. ID APPLICATIONS
   Each application belongs to a student.
   ========================================================= */

CREATE TABLE IDApplications
(
    ApplicationID VARCHAR(30) PRIMARY KEY,

    StudentID VARCHAR(30) NOT NULL,

    RequestType VARCHAR(50) NOT NULL,

    Term VARCHAR(30),

    CORFileLink VARCHAR(500),

    CORStatus VARCHAR(50),

    Status VARCHAR(50),

    StaffRemarks VARCHAR(255),

    DateSubmitted DATETIME,

    DateReviewed DATETIME,

    /* Student relationship */
    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
);
GO


/* =========================================================
   6. APPOINTMENTS
   Connects an application to a schedule.
   ========================================================= */

CREATE TABLE Appointments
(
    AppointmentID VARCHAR(30) PRIMARY KEY,

    ApplicationID VARCHAR(30) NOT NULL,

    ScheduleID VARCHAR(30) NOT NULL,

    QueueNumber VARCHAR(20),

    QueueStatus VARCHAR(30),

    IDProcessingStatus VARCHAR(50),

    /* Application relationship */
    FOREIGN KEY (ApplicationID)
        REFERENCES IDApplications(ApplicationID),

    /* Schedule relationship */
    FOREIGN KEY (ScheduleID)
        REFERENCES Schedules(ScheduleID)
);
GO


/* =========================================================
   7. AUDIT LOG
   Records actions made on applications.
   ========================================================= */

CREATE TABLE AuditLog
(
    LogID VARCHAR(30) PRIMARY KEY,

    ApplicationID VARCHAR(30) NOT NULL,

    Action VARCHAR(100),

    PerformedBy VARCHAR(100),

    [Timestamp] DATETIME,

    Notes VARCHAR(255),

    /* Application relationship */
    FOREIGN KEY (ApplicationID)
        REFERENCES IDApplications(ApplicationID)
);
GO


/* =========================================================
   8. STUDENT DATA
   Six fresh students.
   ========================================================= */

INSERT INTO Students
(
    StudentID,
    LastName,
    FirstName,
    MiddleName,
    Suffix,
    Email,
    Program,
    YearLevel
)
VALUES

(
    '2026-100001',
    'Navarro',
    'Adrian',
    'Lopez',
    NULL,
    'anavarro@student.nu-fairview.edu.ph',
    'BS Information Technology',
    '1st Year'
),

(
    '2026-100002',
    'Castillo',
    'Bianca',
    'Reyes',
    NULL,
    'bcastillo@student.nu-fairview.edu.ph',
    'BS Computer Science',
    '2nd Year'
),

(
    '2026-100003',
    'Aquino',
    'Cedric',
    'Flores',
    NULL,
    'caquino@student.nu-fairview.edu.ph',
    'BS Architecture',
    '3rd Year'
),

(
    '2026-100004',
    'Villanueva',
    'Denise',
    'Garcia',
    NULL,
    'dvillanueva@student.nu-fairview.edu.ph',
    'BS Civil Engineering',
    '2nd Year'
),

(
    '2026-100005',
    'Mendoza',
    'Ethan',
    'Cruz',
    'Jr',
    'emendoza@student.nu-fairview.edu.ph',
    'BS Accountancy',
    '1st Year'
),

(
    '2026-100006',
    'Ramos',
    'Faith',
    'Torres',
    NULL,
    'framos@student.nu-fairview.edu.ph',
    'BS Hospitality Management',
    '4th Year'
);
GO


/* =========================================================
   9. STAFF DATA
   Five fresh staff records.
   ========================================================= */

INSERT INTO Staff
(
    StaffID,
    Name,
    [S],
    Role,
    Status,
    [__PowerAppsId__]
)
VALUES

(
    'STF-001',
    'Andrea Santos',
    'asantos@nu-fairview.edu.ph',
    'Administrator',
    'Active',
    'PA-STAFF-001'
),

(
    'STF-002',
    'Miguel Rivera',
    'mrivera@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-002'
),

(
    'STF-003',
    'Clarisse Lim',
    'clim@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-003'
),

(
    'STF-004',
    'Joshua Tan',
    'jtan@nu-fairview.edu.ph',
    'Staff',
    'Active',
    'PA-STAFF-004'
),

(
    'STF-005',
    'Patricia Gomez',
    'pgomez@nu-fairview.edu.ph',
    'Staff',
    'Inactive',
    'PA-STAFF-005'
);
GO


/* =========================================================
   10. SCHEDULE DATA

   New ID     = 2 schedules
   Update     = 2 schedules
   Lost ID    = 1 schedule
   Damaged ID = 1 schedule
   ========================================================= */

INSERT INTO Schedules
(
    ScheduleID,
    ScheduleDate,
    StartTime,
    EndTime,
    RequestType,
    Term,
    Venue,
    MaxSlots,
    CurrentSlots,
    AvailabilityStartDate,
    AvailabilityEndDate,
    Status
)
VALUES

(
    'SCH-001',
    '2026-10-15',
    '09:00:00',
    '11:00:00',
    'New ID',
    '1st Term',
    'ITSO Office',
    30,
    1,
    '2026-10-08',
    '2026-10-14',
    'Available'
),

(
    'SCH-002',
    '2026-10-15',
    '13:00:00',
    '15:00:00',
    'New ID',
    '1st Term',
    'ITSO Office',
    30,
    1,
    '2026-10-08',
    '2026-10-14',
    'Available'
),

(
    'SCH-003',
    '2026-10-16',
    '09:00:00',
    '11:00:00',
    'Update',
    '1st Term',
    'ITSO Office',
    25,
    1,
    '2026-10-08',
    '2026-10-15',
    'Available'
),

(
    'SCH-004',
    '2026-10-16',
    '13:00:00',
    '15:00:00',
    'Update',
    '1st Term',
    'ITSO Office',
    25,
    1,
    '2026-10-08',
    '2026-10-15',
    'Available'
),

(
    'SCH-005',
    '2026-10-17',
    '09:00:00',
    '11:00:00',
    'Lost ID',
    '1st Term',
    'ITSO Office',
    20,
    1,
    '2026-10-08',
    '2026-10-16',
    'Available'
),

(
    'SCH-006',
    '2026-10-17',
    '13:00:00',
    '15:00:00',
    'Damaged ID',
    '1st Term',
    'ITSO Office',
    20,
    1,
    '2026-10-08',
    '2026-10-16',
    'Available'
);
GO


/* =========================================================
   11. ID APPLICATION DATA

   New ID     = 2 students
   Update     = 2 students
   Lost ID    = 1 student
   Damaged ID = 1 student
   ========================================================= */

INSERT INTO IDApplications
(
    ApplicationID,
    StudentID,
    RequestType,
    Term,
    CORFileLink,
    CORStatus,
    Status,
    StaffRemarks,
    DateSubmitted,
    DateReviewed
)
VALUES

(
    'APP-001',
    '2026-100001',
    'New ID',
    '1st Term',
    'https://example.com/cor/student1',
    'Verified',
    'Approved',
    'Requirements complete',
    '2026-10-08 08:00:00',
    '2026-10-08 09:00:00'
),

(
    'APP-002',
    '2026-100002',
    'New ID',
    '1st Term',
    'https://example.com/cor/student2',
    'Verified',
    'Approved',
    'Requirements complete',
    '2026-10-08 08:15:00',
    '2026-10-08 09:15:00'
),

(
    'APP-003',
    '2026-100003',
    'Update',
    '1st Term',
    'https://example.com/cor/student3',
    'Verified',
    'Approved',
    'Update request approved',
    '2026-10-08 08:30:00',
    '2026-10-08 09:30:00'
),

(
    'APP-004',
    '2026-100004',
    'Update',
    '1st Term',
    'https://example.com/cor/student4',
    'Verified',
    'Approved',
    'Update request approved',
    '2026-10-08 08:45:00',
    '2026-10-08 09:45:00'
),

(
    'APP-005',
    '2026-100005',
    'Lost ID',
    '1st Term',
    'https://example.com/cor/student5',
    'Verified',
    'Approved',
    'Lost ID request approved',
    '2026-10-08 09:00:00',
    '2026-10-08 10:00:00'
),

(
    'APP-006',
    '2026-100006',
    'Damaged ID',
    '1st Term',
    'https://example.com/cor/student6',
    'Verified',
    'Approved',
    'Damaged ID request approved',
    '2026-10-08 09:15:00',
    '2026-10-08 10:15:00'
);
GO


/* =========================================================
   12. APPOINTMENT DATA

   Queue prefixes:
   N = New ID
   U = Update
   L = Lost ID
   D = Damaged ID

   Queue numbers increment per request type.
   ========================================================= */

INSERT INTO Appointments
(
    AppointmentID,
    ApplicationID,
    ScheduleID,
    QueueNumber,
    QueueStatus,
    IDProcessingStatus
)
VALUES

(
    'APT-001',
    'APP-001',
    'SCH-001',
    'N001',
    'Waiting',
    'Pending'
),

(
    'APT-002',
    'APP-002',
    'SCH-002',
    'N002',
    'Waiting',
    'Pending'
),

(
    'APT-003',
    'APP-003',
    'SCH-003',
    'U001',
    'Waiting',
    'Pending'
),

(
    'APT-004',
    'APP-004',
    'SCH-004',
    'U002',
    'Waiting',
    'Pending'
),

(
    'APT-005',
    'APP-005',
    'SCH-005',
    'L001',
    'Waiting',
    'Pending'
),

(
    'APT-006',
    'APP-006',
    'SCH-006',
    'D001',
    'Waiting',
    'Pending'
);
GO


/* =========================================================
   13. AUDIT LOG DATA
   Tracks actions performed on applications.
   ========================================================= */

INSERT INTO AuditLog
(
    LogID,
    ApplicationID,
    Action,
    PerformedBy,
    [Timestamp],
    Notes
)
VALUES

(
    'LOG-001',
    'APP-001',
    'Submitted',
    '2026-100001',
    '2026-10-08 08:00:00',
    'New ID application submitted'
),

(
    'LOG-002',
    'APP-001',
    'Approved',
    'STF-001',
    '2026-10-08 09:00:00',
    'New ID application approved'
),

(
    'LOG-003',
    'APP-002',
    'Approved',
    'STF-002',
    '2026-10-08 09:15:00',
    'New ID application approved'
),

(
    'LOG-004',
    'APP-003',
    'Approved',
    'STF-003',
    '2026-10-08 09:30:00',
    'Update request approved'
),

(
    'LOG-005',
    'APP-004',
    'Approved',
    'STF-002',
    '2026-10-08 09:45:00',
    'Update request approved'
),

(
    'LOG-006',
    'APP-005',
    'Approved',
    'STF-003',
    '2026-10-08 10:00:00',
    'Lost ID request approved'
),

(
    'LOG-007',
    'APP-006',
    'Approved',
    'STF-004',
    '2026-10-08 10:15:00',
    'Damaged ID request approved'
);
GO


/* =========================================================
   14. DISPLAY ALL TABLES
   Used to check inserted records.
   ========================================================= */

SELECT * FROM Students;

SELECT * FROM Staff;

SELECT * FROM Schedules;

SELECT * FROM IDApplications;

SELECT * FROM Appointments;

SELECT * FROM AuditLog;
GO


/* =========================================================
   15. SIMPLE JOIN
   Shows Student -> Application -> Appointment -> Schedule.
   ========================================================= */

SELECT
    Students.StudentID,
    Students.FirstName,
    Students.LastName,

    IDApplications.ApplicationID,
    IDApplications.RequestType,

    Appointments.AppointmentID,
    Appointments.QueueNumber,
    Appointments.QueueStatus,
    Appointments.IDProcessingStatus,

    Schedules.ScheduleID,
    Schedules.ScheduleDate,
    Schedules.StartTime,
    Schedules.EndTime,
    Schedules.Venue

FROM Students

INNER JOIN IDApplications
ON Students.StudentID = IDApplications.StudentID

INNER JOIN Appointments
ON IDApplications.ApplicationID = Appointments.ApplicationID

INNER JOIN Schedules
ON Appointments.ScheduleID = Schedules.ScheduleID;
GO