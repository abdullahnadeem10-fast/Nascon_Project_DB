-- Users table
CREATE TABLE User (
    UserID VARCHAR(50) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Name VARCHAR(100),
    ContactNumber VARCHAR(20),
    Role VARCHAR(50),
    JudgeID VARCHAR(50) UNIQUE
);

-- Event table
CREATE TABLE Event (
    EventID VARCHAR(50) PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    Description TEXT,
    Rules TEXT,
    MaxParticipants INT,
    RegistrationFee DECIMAL(10, 2),
    DateTime DATETIME,
    Category VARCHAR(50),
    VenueID VARCHAR(50),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);

-- Team table
CREATE TABLE Team (
    TeamID VARCHAR(50) PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    EventID VARCHAR(50) NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Participant table
CREATE TABLE Participant (
    ParticipantID VARCHAR(50) PRIMARY KEY,
    UserID VARCHAR(50) NOT NULL,
    TeamID VARCHAR(50),
    OrganizationID VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- Registration table
CREATE TABLE Registration (
    RegistrationID VARCHAR(50) PRIMARY KEY,
    EventID VARCHAR(50) NOT NULL,
    ParticipantID VARCHAR(50) NOT NULL,
    RegistrationDate DATETIME NOT NULL,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID)
);

-- Venue table
CREATE TABLE Venue (
    VenueID VARCHAR(50) PRIMARY KEY,
    VenueName VARCHAR(100) NOT NULL,
    Location VARCHAR(255),
    Capacity INT,
    Type VARCHAR(50)
);

-- Sponsor table
CREATE TABLE Sponsor (
    SponsorID VARCHAR(50) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    UserID VARCHAR(50),
    SponsorType VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Sponsorship table
CREATE TABLE Sponsorship (
    SponsorshipID VARCHAR(50) PRIMARY KEY,
    SponsorID VARCHAR(50) NOT NULL,
    EventID VARCHAR(50) NOT NULL,
    Amount DECIMAL(10, 2),
    ContractDate DATE,
    PaymentStatus VARCHAR(50),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Accommodation table
CREATE TABLE Accommodation (
    AccommodationID VARCHAR(50) PRIMARY KEY,
    Capacity INT,
    Cost DECIMAL(10, 2),
    Location VARCHAR(255),
    AvailabilityStatus VARCHAR(50)
);

-- AccommodationAssignment table
CREATE TABLE AccommodationAssignment (
    AssignmentID VARCHAR(50) PRIMARY KEY,
    AccommodationID VARCHAR(50) NOT NULL,
    ParticipantID VARCHAR(50) NOT NULL,
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID)
);

-- Payment table
CREATE TABLE Payment (
    PaymentID VARCHAR(50) PRIMARY KEY,
    UserID VARCHAR(50) NOT NULL,
    PartnerID VARCHAR(50),
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentType VARCHAR(50),
    ReferenceNo VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Judge table
CREATE TABLE Judge (
    JudgeID VARCHAR(50) PRIMARY KEY,
    UserID VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Score table
CREATE TABLE Score (
    ScoreID VARCHAR(50) PRIMARY KEY,
    EventID VARCHAR(50) NOT NULL,
    ParticipantID VARCHAR(50) NOT NULL,
    JudgeID VARCHAR(50) NOT NULL,
    ScoreValue DECIMAL(5, 2) NOT NULL,
    Criteria VARCHAR(100),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID),
    FOREIGN KEY (JudgeID) REFERENCES Judge(JudgeID)
);