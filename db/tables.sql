use Referrals
go

print '*** Table: CommMethod ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'CommMethod')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_CommMethod')
	begin
		alter table Communication drop constraint fk_Communication_CommMethod
	end
	
	drop table dbo.CommMethod
end
create table dbo.CommMethod
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(50) not null
)
insert into CommMethod
select 'Email'
union
select 'Internal Message'
union
select 'Text Message'
go

print '*** Table: Action ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Action')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_Action')
	begin
		alter table Communication drop constraint fk_Communication_Action
	end
	
	drop table dbo.[Action]
end
create table dbo.[Action]
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(50) not null
)
insert into [Action]
select 'Invitation'
union
select 'None'
union
select 'Nudge'
union
select 'Referral'
union
select 'Reward'
go

print '*** Table: Status ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Status')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Account_Status')
	begin
		alter table [Account] drop constraint fk_Account_Status
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountContact_Status')
	begin
		alter table AccountContacts drop constraint fk_AccountContact_Status
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Job_Status')
	begin
		alter table Job drop constraint fk_Job_Status
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_StatusTo')
	begin
		alter table Communication drop constraint fk_Communication_StatusTo
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_StatusReferred')
	begin
		alter table Communication drop constraint fk_Communication_StatusReferred
	end
	
	drop table dbo.[Status]
end
create table dbo.[Status]
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(50) not null,
	Icon nvarchar(50) not null,
	Color nvarchar(15) not null
)
insert into [Status]
select 'Failed', 'icon_failed.jpg', 'red'
union
select 'New', 'icon_new.jpg', 'orange'
union
select 'Sent', 'icon_sent.jpg', 'orange'
union
select 'Read', 'icon_read.jpg', 'gray'
union
select 'UnRead', 'icon_unread.jpg', 'gray'
union
select 'Online', 'icon_online.jpg', 'orange'
union
select 'Offline', 'icon_offline.jpg', 'gray'
union
select 'Invited', 'icon_invited.jpg', 'gray'
go

print '*** Table: State ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'State')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Account_State')
	begin
		alter table Account drop constraint fk_Account_State
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountLocations_State')
	begin
		alter table AccountLocations drop constraint fk_AccountLocations_State
	end

	drop table dbo.[State]
end
create table dbo.[State]
(
	Id int identity(1,1) not null primary key,
	Abbrev nvarchar(5) not null,
	Name nvarchar(50) not null
)
insert into [State]
select 'AL', 'Alabama'
union select 'AK', 'Alaska'
union select 'AZ', 'Arizona'
union select 'AR', 'Arkansas'
union select 'CA', 'California'
union select 'CO', 'Colorado'
union select 'CT', 'Connecticut'
union select 'DE', 'Delaware'
union select 'DC', 'District Of Columbia'
union select 'FL', 'Florida'
union select 'GA', 'Georgia'
union select 'HI', 'Hawaii'
union select 'ID', 'Idaho'
union select 'IL', 'Illinois'
union select 'IN', 'Indiana'
union select 'IA', 'Iowa'
union select 'KS', 'Kansas'
union select 'KY', 'Kentucky'
union select 'LA', 'Louisiana'
union select 'ME', 'Maine'
union select 'MD', 'Maryland'
union select 'MA', 'Massachusetts'
union select 'MI', 'Michigan'
union select 'MN', 'Minnesota'
union select 'MS', 'Mississippi'
union select 'MO', 'Missouri'
union select 'MT', 'Montana'
union select 'NE', 'Nebraska'
union select 'NV', 'Nevada'
union select 'NH', 'New Hampshire'
union select 'NJ', 'New Jersey'
union select 'NM', 'New Mexico'
union select 'NY', 'New York'
union select 'NC', 'North Carolina'
union select 'ND', 'North Dakota'
union select 'OH', 'Ohio'
union select 'OK', 'Oklahoma'
union select 'OR', 'Oregon'
union select 'PA', 'Pennsylvania'
union select 'RI', 'Rhode Island'
union select 'SC', 'South Carolina'
union select 'SD', 'South Dakota'
union select 'TN', 'Tennessee'
union select 'TX', 'Texas'
union select 'UT', 'Utah'
union select 'VT', 'Vermont'
union select 'VA', 'Virginia'
union select 'WA', 'Washington'
union select 'WV', 'West Virginia'
union select 'WI', 'Wisconsin'
union select 'WY', 'Wyoming'
go

print '*** Table: Country ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Country')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Account_Country')
	begin
		alter table Account drop constraint fk_Account_Country
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountLocations_Country')
	begin
		alter table AccountLocations drop constraint fk_AccountLocations_Country
	end

	drop table dbo.Country
end
create table dbo.Country
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(50) not null,
	Abbrev nvarchar(5) not null
)
insert into Country
select 'United States', 'U.S.'
go

print '*** Table: Profession ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Profession')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountProfessions_Profession')
	begin
		alter table AccountProfessions drop constraint fk_AccountProfessions_Profession
	end
	
	drop table dbo.Profession
end
create table dbo.Profession
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(250) not null,
	Parent int null default 0,
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)
insert into Profession
select 'Architecture and Engineering', 0, getdate(), 'system', getdate(), 'system'
union select 'Arts, Design, Entertainment, Sports, and Media', 0, getdate(), 'system', getdate(), 'system'
union select 'Building and Grounds Cleaning and Maintenance', 0, getdate(), 'system', getdate(), 'system'
union select 'Business and Financial Operations', 0, getdate(), 'system', getdate(), 'system'
union select 'Community and Social Service', 0, getdate(), 'system', getdate(), 'system'
union select 'Computer and Mathematical', 0, getdate(), 'system', getdate(), 'system'
union select 'Construction and Extraction', 0, getdate(), 'system', getdate(), 'system'
union select 'Education, Training, and Library', 0, getdate(), 'system', getdate(), 'system'
union select 'Farming, Fishing, and Forestry', 0, getdate(), 'system', getdate(), 'system'
union select 'Food Preparation and Serving', 0, getdate(), 'system', getdate(), 'system'
union select 'Healthcare Practitioners and Technical', 0, getdate(), 'system', getdate(), 'system'
union select 'Healthcare Support', 0, getdate(), 'system', getdate(), 'system'
union select 'Installation, Maintenance, and Repair', 0, getdate(), 'system', getdate(), 'system'
union select 'Legal', 0, getdate(), 'system', getdate(), 'system'
union select 'Life, Physical, and Social Science', 0, getdate(), 'system', getdate(), 'system'
union select 'Management', 0, getdate(), 'system', getdate(), 'system'
union select 'Military Specific', 0, getdate(), 'system', getdate(), 'system'
union select 'Office and Administrative Support', 0, getdate(), 'system', getdate(), 'system'
union select 'Personal Care and Service', 0, getdate(), 'system', getdate(), 'system'
union select 'Production/Manufacturing', 0, getdate(), 'system', getdate(), 'system'
union select 'Protective Service', 0, getdate(), 'system', getdate(), 'system'
union select 'Sales and Related', 0, getdate(), 'system', getdate(), 'system'
union select 'Transportation and Material Moving', 0, getdate(), 'system', getdate(), 'system'
union select 'Able Seamen---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Accountants---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Accountants and Auditors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Actors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Actuaries---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Adjustment Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Administrative Law Judges, Adjudicators, and Hearing Officers---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Administrative Services Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Adult Literacy, Remedial Education, and GED Teachers and Instructors---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Advertising and Promotions Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Advertising Sales Agents---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aerospace Engineering and Operations Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aerospace Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agents and Business Managers of Artists, Performers, and Athletes---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural and Food Science Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Crop Farm Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Equipment Operators---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Inspectors---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Sciences Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Agricultural Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Air Crew Members---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Air Crew Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Air Traffic Controllers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Body and Bonded Structure Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Cargo Handling Supervisors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Engine Specialists---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Launch and Recovery Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Launch and Recovery Specialists---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Mechanics and Service Technicians---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Rigging Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Structure Assemblers, Precision---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Structure, Surfaces, Rigging, and Systems Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aircraft Systems Assemblers, Precision---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Airfield Operations Specialists---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Airframe-and-Power-Plant Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Airline Pilots, Copilots, and Flight Engineers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ambulance Drivers and Attendants, Except Emergency Medical Technicians---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Amusement and Recreation Attendants---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Anesthesiologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Animal Breeders---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Animal Control Workers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Animal Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Animal Trainers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Anthropologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Anthropologists and Archeologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Anthropology and Archeology Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Appraisers and Assessors of Real Estate---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Appraisers, Real Estate---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Arbitrators, Mediators, and Conciliators---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Archeologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Architects, Except Landscape and Naval---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Architectural and Civil Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Architectural Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Architecture Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Archivists---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Area, Ethnic, and Cultural Studies Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Armored Assault Vehicle Crew Members---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Armored Assault Vehicle Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Art Directors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Art, Drama, and Music Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Artillery and Missile Crew Members---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Artillery and Missile Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Assessors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Astronomers---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Athletes and Sports Competitors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Athletic Trainers---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Atmospheric and Space Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Atmospheric, Earth, Marine, and Space Sciences Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Audio and Video Equipment Technicians---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Audiologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Audio-Visual Collections Specialists---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Auditors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automatic Teller Machine Servicers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automotive Body and Related Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automotive Glass Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automotive Master Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automotive Service Technicians and Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Automotive Specialty Technicians---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Auxiliary Equipment Operators, Power---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Aviation Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Avionics Technicians---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Baggage Porters and Bellhops---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bailiffs---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bakers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bakers, Bread and Pastry---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bakers, Manufacturing---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Barbers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bartenders---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Battery Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bench Workers, Jewelry---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bicycle Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bill and Account Collectors---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Billing and Posting Clerks and Machine Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Billing, Cost, and Rate Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Billing, Posting, and Calculating Machine Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bindery Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bindery Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bindery Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biochemists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biochemists and Biophysicists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biological Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biological Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biomedical Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Biophysicists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Boat Builders and Shipwrights---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Boiler Operators and Tenders, Low Pressure---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Boilermakers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bookbinders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bookkeeping, Accounting, and Auditing Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Brattice Builders---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Brazers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Brickmasons and Blockmasons---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bridge and Lock Tenders---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Broadcast News Analysts---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Broadcast Technicians---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Brokerage Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Budget Analysts---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Buffing and Polishing Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bus and Truck Mechanics and Diesel Engine Specialists---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bus Drivers, School---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Bus Drivers, Transit and Intercity---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Business Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Butchers and Meat Cutters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cabinetmakers and Bench Carpenters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Calibration and Instrumentation Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Camera and Photographic Equipment Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Camera Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Camera Operators, Television, Video, and Motion Picture---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Captains, Mates, and Pilots of Water Vessels---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Caption Writers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cardiovascular Technologists and Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cargo and Freight Agents---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Carpenter Assemblers and Repairers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Carpenters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Carpet Installers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cartographers and Photogrammetrists---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cartoonists---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cashiers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Casting Machine Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ceiling Tile Installers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cement Masons and Concrete Finishers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cementing and Gluing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Central Office and PBX Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Central Office Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chefs and Head Cooks---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Equipment Controllers and Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Equipment Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Equipment Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Plant and System Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemical Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemistry Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chemists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chief Executives---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Child Care Workers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Child Support, Missing Persons, and Unemployment Insurance Fraud Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Child, Family, and School Social Workers---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Chiropractors---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Choreographers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'City Planning Aides---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Civil Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Civil Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Civil Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Claims Adjusters, Examiners, and Investigators---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Claims Examiners, Property and Casualty Insurance---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Claims Takers, Unemployment Benefits---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cleaners of Vehicles and Equipment---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cleaning, Washing, and Metal Pickling Equipment Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Clergy---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Clinical Psychologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Clinical, Counseling, and School Psychologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coaches and Scouts---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coating, Painting, and Spraying Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coating, Painting, and Spraying Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coating, Painting, and Spraying Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coil Winders, Tapers, and Finishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coin, Vending, and Amusement Machine Servicers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Combination Machine Tool Operators and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Combination Machine Tool Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Combined Food Preparation and Serving Workers, Including Fast Food---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Command and Control Center Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Command and Control Center Specialists---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Commercial and Industrial Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Commercial Divers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Commercial Pilots---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Communication Equipment Mechanics, Installers, and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Communications Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Compensation and Benefits Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Compensation, Benefits, and Job Analysis Specialists---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Compliance Officers, Except Agriculture, Construction, Health and Safety, and Transportation---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Composers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer and Information Scientists, Research---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer and Information Systems Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Hardware Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Programmers---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Security Specialists---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Software Engineers, Applications---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Software Engineers, Systems Software---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Support Specialists---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer Systems Analysts---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer, Automated Teller, and Office Machine Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Computer-Controlled Machine Tool Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Concierges---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Conservation Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Construction and Building Inspectors---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Construction Carpenters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Construction Drillers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Construction Laborers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Construction Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Continuous Mining Machine Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Control and Valve Installers and Repairers, Except Mechanical Door---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Conveyor Operators and Tenders---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooks, Fast Food---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooks, Institution and Cafeteria---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooks, Private Household---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooks, Restaurant---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooks, Short Order---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cooling and Freezing Equipment Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Copy Writers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Coroners---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Correctional Officers and Jailers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Correspondence Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cost Estimators---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Costume Attendants---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Counseling Psychologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Counter and Rental Clerks---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Counter Attendants, Cafeteria, Food Concession, and Coffee Shop---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Couriers and Messengers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Court Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Court Reporters---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Court, Municipal, and License Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Craft Artists---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Crane and Tower Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Creative Writers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Credit Analysts---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Credit Authorizers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Credit Authorizers, Checkers, and Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Credit Checkers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Criminal Investigators and Special Agents---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Criminal Justice and Law Enforcement Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Crossing Guards---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Crushing, Grinding, and Polishing Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Curators---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Custom Tailors---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Customer Service Representatives---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Customer Service Representatives, Utilities---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cutters and Trimmers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cutting and Slicing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cutting and Slicing Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Cutting, Punching, and Press Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dancers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Data Entry Keyers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Data Processing Equipment Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Database Administrators---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Demonstrators and Product Promoters---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dental Assistants---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dental Hygienists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dental Laboratory Technicians---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dentists, General---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Derrick Operators, Oil and Gas---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Design Printing Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Desktop Publishers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Detectives and Criminal Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Diagnostic Medical Sonographers---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dietetic Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dietitians and Nutritionists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dining Room and Cafeteria Attendants and Bartender Helpers---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Directors- Stage, Motion Pictures, Television, and Radio---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Directors, Religious Activities and Education---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Directory Assistance Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dishwashers---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dispatchers, Except Police, Fire, and Ambulance---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Door-To-Door Sales Workers, News and Street Vendors, and Related Workers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dot Etchers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dragline Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Dredge Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Drilling and Boring Machine Tool Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Driver/Sales Workers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Drywall and Ceiling Tile Installers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Drywall Installers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Duplicating Machine Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Earth Drillers, Except Oil and Gas---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Economics Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Economists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Editors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Education Administrators, Elementary and Secondary School---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Education Administrators, Postsecondary---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Education Administrators, Preschool and Child Care Center/Program---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Education Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Educational Psychologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Educational, Vocational, and School Counselors---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electric Home Appliance and Power Tool Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electric Meter Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electric Motor and Switch Assemblers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electric Motor, Power Tool, and Related Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronic Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronic Equipment Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronic Inspectors and Testers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronics Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronics Installers and Repairers, Transportation Equipment---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronics Repairers, Commercial and Industrial Equipment---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical and Electronics Repairers, Powerhouse, Substation, and Relay---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical Parts Reconditioners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrical Power-Line Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electricians---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrolytic Plating and Coating Machine Operators and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrolytic Plating and Coating Machine Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electromechanical Equipment Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electro-Mechanical Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronic Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronic Equipment Installers and Repairers, Motor Vehicles---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronic Home Entertainment Equipment Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronic Masking System Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronics Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electronics Engineers, Except Computer---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Electrotypers and Stereotypers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Elementary School Teachers, Except Special Education---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Elevator Installers and Repairers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Eligibility Interviewers, Government Programs---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Embalmers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Embossing Machine Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Emergency Management Specialists---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Emergency Medical Technicians and Paramedics---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Employment Interviewers, Private or Public Employment Service---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Employment, Recruitment, and Placement Specialists---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engine and Other Machine Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engineering Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engineering Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'English Language and Literature Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engraver Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engravers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Engravers/Carvers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Compliance Inspectors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Science and Protection Technicians, Including Health---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Environmental Scientists and Specialists, Including Health---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Epidemiologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Equal Opportunity Representatives and Officers---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Etchers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Etchers and Engravers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Etchers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Excavating and Loading Machine and Dragline Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Excavating and Loading Machine Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Executive Secretaries and Administrative Assistants---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Exhibit Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Explosives Workers, Ordnance Handling Experts, and Blasters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding and Drawing Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding and Forming Machine Operators and Tenders, Synthetic or Glass Fibers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding and Forming Machine Setters, Operators, and Tenders, Synthetic and Glass Fibers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding, Forming, Pressing, and Compacting Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding, Forming, Pressing, and Compacting Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Extruding, Forming, Pressing, and Compacting Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fabric and Apparel Patternmakers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fabric Menders, Except Garment---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fallers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Family and General Practitioners---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farm and Home Management Advisors---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farm Equipment Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farm Labor Contractors---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farm, Ranch, and Other Agricultural Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farmers and Ranchers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farmworkers and Laborers, Crop, Nursery, and Greenhouse---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Farmworkers, Farm and Ranch Animals---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fashion Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fence Erectors---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fiber Product Cutting Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fiberglass Laminators and Fabricators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'File Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Film and Video Editors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Film Laboratory Technicians---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Financial Analysts---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Financial Examiners---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Financial Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Financial Managers, Branch or Department---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fine Artists, Including Painters, Sculptors, and Illustrators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fire Fighters---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fire Inspectors---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fire Inspectors and Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fire Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fire-Prevention and Protection Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Agricultural Crop Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Animal Care Workers, Except Livestock---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Animal Husbandry Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Fishery Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Horticultural Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Landscaping Workers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors - Logging Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors- Construction Trades Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors and Manager/Supervisors- Extractive Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors, Administrative Support---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors, Customer Service---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Air Crew Members---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of All Other Tactical Operations Specialists---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Construction Trades and Extraction Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Correctional Officers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Farming, Fishing, and Forestry Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Fire Fighting and Prevention Workers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Food Preparation and Serving Workers---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Helpers, Laborers, and Material Movers, Hand---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Housekeeping and Janitorial Workers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Landscaping, Lawn Service, and Groundskeeping Workers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Mechanics, Installers, and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Non-Retail Sales Workers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Office and Administrative Support Workers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Personal Service Workers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Police and Detectives---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Production and Operating Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Retail Sales Workers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Transportation and Material-Moving Machine and Vehicle Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'First-Line Supervisors/Managers of Weapons Specialists/Crew Members---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fish and Game Wardens---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fish Hatchery Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fishers and Related Fishing Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fitness Trainers and Aerobics Instructors---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Fitters, Structural Metal- Precision---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Flight Attendants---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Floor Layers, Except Carpet, Wood, and Hard Tiles---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Floor Sanders and Finishers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Floral Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Batchmakers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Cooking Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Preparation Workers---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Science Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Scientists and Technologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Servers, Nonrestaurant---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Food Service Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Foreign Language and Literature Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forensic Science Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forest and Conservation Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forest and Conservation Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forest Fire Fighters---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forest Fire Fighting and Prevention Supervisors---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forest Fire Inspectors and Prevention Specialists---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Foresters---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forestry and Conservation Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Forging Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Foundry Mold and Coremakers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Frame Wirers, Central Office---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Freight Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Freight, Stock, and Material Movers, Hand---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Funeral Attendants---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Funeral Directors---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Furnace, Kiln, Oven, Drier, and Kettle Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Furniture Finishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming and Sports Book Writers and Runners---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Cage Workers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Change Persons and Booth Cashiers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Dealers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Supervisors---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaming Surveillance Officers and Gaming Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Appliance Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Compressor and Gas Pumping Station Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Compressor Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Distribution Plant Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Plant Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Processing Plant Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gas Pumping Station Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gaugers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Gem and Diamond Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'General and Operations Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'General Farmworkers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geographers---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geography Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geological and Petroleum Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geological Data Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geological Sample Test Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Geoscientists, Except Hydrologists and Geographers---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Glass Blowers, Molders, Benders, and Finishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Glass Cutting Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Glaziers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Government Property Inspectors and Investigators---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Government Service Executives---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Grader, Bulldozer, and Scraper Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Graders and Sorters, Agricultural Products---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Graduate Teaching Assistants---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Graphic Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Grinding and Polishing Workers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Grinding, Honing, Lapping, and Deburring Machine Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Grinding, Lapping, Polishing, and Buffing Machine Tool Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Grips and Set-Up Workers, Motion Picture Sets, Studios, and Stages---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hairdressers, Hairstylists, and Cosmetologists---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hand and Portable Power Tool Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hand Compositors and Typesetters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hazardous Materials Removal Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Health and Safety Engineers, Except Mining Safety Engineers and Inspectors---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Health Educators---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Health Specialties Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heat Treating Equipment Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heat Treating, Annealing, and Tempering Machine Operators and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heaters, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heating and Air Conditioning Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heating Equipment Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Heating, Air Conditioning, and Refrigeration Mechanics and Installers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Brickmasons, Blockmasons, Stonemasons, and Tile and Marble Setters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Carpenters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Electricians---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Extraction Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Installation, Maintenance, and Repair Workers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Painters, Paperhangers, Plasterers, and Stucco Masons---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Pipelayers, Plumbers, Pipefitters, and Steamfitters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Production Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Helpers--Roofers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Highway Maintenance Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Highway Patrol Pilots---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Historians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'History Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hoist and Winch Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Home Appliance Installers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Home Appliance Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Home Economics Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Home Health Aides---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hosts and Hostesses, Restaurant, Lounge, and Coffee Shop---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hotel, Motel, and Resort Desk Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Housekeeping Supervisors---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Human Resources Assistants, Except Payroll and Timekeeping---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Human Resources Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hunters and Trappers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Hydrologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Immigration and Customs Inspectors---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Machinery Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Production Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Safety and Health Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial Truck and Tractor Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Industrial-Organizational Psychologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Infantry---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Infantry Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Inspectors, Testers, Sorters, Samplers, and Weighers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Instructional Coordinators---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insulation Workers, Floor, Ceiling, and Wall---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insulation Workers, Mechanical---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Adjusters, Examiners, and Investigators---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Appraisers, Auto Damage---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Claims and Policy Processing Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Claims Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Policy Processing Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Sales Agents---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Insurance Underwriters---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Interior Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Internists, General---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Interpreters and Translators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Interviewers, Except Eligibility and Loan---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Irradiated-Fuel Handlers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Janitorial Supervisors---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Janitors and Cleaners, Except Maids and Housekeeping Cleaners---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Jewelers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Jewelers and Precious Stone and Metal Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Job Printers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Judges, Magistrate Judges, and Magistrates---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Keyboard Instrument Repairers and Tuners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Kindergarten Teachers, Except Special Education---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Laborers and Freight, Stock, and Material Movers, Hand---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Landscape Architects---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Landscaping and Groundskeeping Workers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lathe and Turning Machine Tool Setters, Operators, and Tenders Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Laundry and Drycleaning Machine Operators and Tenders, Except Pressing---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Laundry and Dry-Cleaning Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Law Clerks---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Law Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lawn Service Managers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lawyers---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lay-Out Workers, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Legal Secretaries---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Legislators---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Letterpress Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Librarians---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Library Assistants, Clerical---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Library Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Library Technicians---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'License Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Licensed Practical and Licensed Vocational Nurses---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Licensing Examiners and Inspectors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lifeguards, Ski Patrol, and Other Recreational Protective Service Workers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Loading Machine Operators, Underground Mining---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Loan Counselors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Loan Interviewers and Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Loan Officers---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Locker Room, Coatroom, and Dressing Room Attendants---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Locksmiths and Safe Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Locomotive Engineers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Locomotive Firers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Lodging Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Log Graders and Scalers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Logging Equipment Operators---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Logging Tractor Operators---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Logisticians---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Machine Feeders and Offbearers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Machinists---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Maids and Housekeeping Cleaners---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mail Clerks and Mail Machine Operators, Except Postal Service---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mail Clerks, Except Mail Machine Operators and Postal Service---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mail Machine Operators, Preparation and Handling---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Maintenance and Repair Workers, General---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Maintenance Workers, Machinery---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Makeup Artists, Theatrical and Performance---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Management Analysts---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Manicurists and Pedicurists---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Manufactured Building and Mobile Home Installers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mapping Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marine Architects---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marine Cargo Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marine Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marine Engineers and Naval Architects---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Market Research Analysts---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marketing Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marking and Identification Printing Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marking Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Marriage and Family Therapists---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Massage Therapists---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Materials Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Materials Inspectors---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Materials Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mates- Ship, Boat, and Barge---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mathematical Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mathematical Technicians---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mathematicians---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Meat, Poultry, and Fish Cutters and Trimmers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mechanical Door Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mechanical Drafters---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mechanical Engineering Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mechanical Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mechanical Inspectors---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical and Clinical Laboratory Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical and Clinical Laboratory Technologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical and Health Services Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical and Public Health Social Workers---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Appliance Technicians---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Assistants---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Equipment Preparers---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Equipment Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Records and Health Information Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Scientists, Except Epidemiologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Secretaries---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Medical Transcriptionists---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Meeting and Convention Planners---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mental Health and Substance Abuse Social Workers---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mental Health Counselors---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Merchandise Displayers and Window Trimmers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Metal Fabricators, Structural Metal Products---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Metal Molding, Coremaking, and Casting Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Metal Molding, Coremaking, and Casting Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Metal-Refining Furnace Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Meter Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Meter Readers, Utilities---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Microbiologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Middle School Teachers, Except Special and Vocational Education---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Milling and Planing Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Millwrights---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mine Cutting and Channeling Machine Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mining and Geological Engineers, Including Mining Safety Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mixing and Blending Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mobile Heavy Equipment Mechanics, Except Engines---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Model and Mold Makers, Jewelry---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Model Makers, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Model Makers, Wood---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Models---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Mold Makers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Molders, Shapers, and Casters, Except Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Molding and Casting Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Molding, Coremaking, and Casting Machine Setters,Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Motion Picture Projectionists---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Motor Vehicle Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Motorboat Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Motorboat Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Motorcycle Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Multi-Media Artists and Animators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Multiple Machine Tool Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Municipal Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Municipal Fire Fighters---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Municipal Fire Fighting and Prevention Supervisors---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Museum Technicians and Conservators---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Music Arrangers and Orchestrators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Music Directors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Music Directors and Composers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Musical Instrument Repairers and Tuners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Musicians and Singers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Musicians, Instrumental---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Natural Sciences Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Network and Computer Systems Administrators---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Network Systems and Data Communications Analysts---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'New Accounts Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nonelectrolytic Plating and Coating Machine Operators and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nonelectrolytic Plating and Coating Machine Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nonfarm Animal Caretakers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Equipment Operation Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Medicine Technologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Monitoring Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Power Reactor Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nuclear Technicians---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Numerical Control Machine Tool Operators and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Numerical Tool and Process Control Programmers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nursery and Greenhouse Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nursery Workers---Farming, Fishing, and Forestry Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nursing Aides, Orderlies, and Attendants---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Nursing Instructors and Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Obstetricians and Gynecologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Occupational Health and Safety Specialists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Occupational Health and Safety Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Occupational Therapist Aides---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Occupational Therapist Assistants---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Occupational Therapists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Office Clerks, General---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Office Machine and Cash Register Servicers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Office Machine Operators, Except Computer---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Offset Lithographic Press Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Operating Engineers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Operating Engineers and Other Construction Equipment Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Operations Research Analysts---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ophthalmic Laboratory Technicians---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Optical Instrument Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Opticians, Dispensing---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Optometrists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Oral and Maxillofacial Surgeons---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Order Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Order Fillers, Wholesale and Retail Sales---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ordinary Seamen and Marine Oilers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Orthodontists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Orthotists and Prosthetists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Outdoor Power Equipment and Other Small Engine Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Packaging and Filling Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Packers and Packagers, Hand---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Painters and Illustrators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Painters, Construction and Maintenance---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Painters, Transportation Equipment---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Painting, Coating, and Decorating Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pantograph Engravers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Paper Goods Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Paperhangers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Paralegals and Legal Assistants---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Park Naturalists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Parking Enforcement Workers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Parking Lot Attendants---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Parts Salespersons---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Paste-Up Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Patternmakers, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Patternmakers, Wood---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Paving, Surfacing, and Tamping Equipment Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Payroll and Timekeeping Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pediatricians, General---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Percussion Instrument Repairers and Tuners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Personal and Home Care Aides---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Personal Financial Advisors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Personnel Recruiters---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pest Control Workers---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pesticide Handlers, Sprayers, and Applicators, Vegetation---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Petroleum Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Petroleum Pump System Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Petroleum Pump System Operators, Refinery Operators, and Gaugers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Petroleum Refinery and Control Panel Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pewter Casters and Finishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pharmacists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pharmacy Aides---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pharmacy Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Philosophy and Religion Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photoengravers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photoengraving and Lithographing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographers, Scientific---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographic Hand Developers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographic Process Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographic Processing Machine Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographic Reproduction Technicians---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Photographic Retouchers and Restorers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physical Therapist Aides---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physical Therapist Assistants---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physical Therapists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physician Assistants---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physicists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Physics Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pile-Driver Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pilots, Ship---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pipe Fitters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pipelayers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pipelaying Fitters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plant Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plasterers and Stucco Masons---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plastic Molding and Casting Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plastic Molding and Casting Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plate Finishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Platemakers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plating and Coating Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plumbers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Plumbers, Pipefitters, and Steamfitters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Podiatrists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Poets and Lyricists---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Police and Sheriff''s Patrol Officers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Police Detectives---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Police Identification and Records Officers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Police Patrol Officers---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Police, Fire, and Ambulance Dispatchers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Political Science Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Political Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Postal Service Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Postal Service Mail Carriers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Postal Service Mail Sorters, Processors, and Processing Machine Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Postmasters and Mail Superintendents---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Potters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pourers and Casters, Metal---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Power Distributors and Dispatchers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Power Generating Plant Operators, Except Auxiliary Equipment Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Power Plant Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Devices Inspectors and Testers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Dyers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Etchers and Engravers, Hand or Machine---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Lens Grinders and Polishers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Mold and Pattern Casters, except Nonferrous Metals---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Pattern and Die Casters, Nonferrous Metals---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Precision Printing Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Prepress Technicians and Workers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Preschool Teachers, Except Special Education---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Press and Press Brake Machine Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pressers, Delicate Fabrics---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pressers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pressers, Textile, Garment, and Related Materials---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pressing Machine Operators and Tenders- Textile, Garment, and Related Materials---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pressure Vessel Inspectors---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Printing Machine Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Printing Press Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Private Detectives and Investigators---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Private Sector Executives---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Probation Officers and Correctional Treatment Specialists---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Procurement Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Producers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Producers and Directors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Product Safety Engineers---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Production Helpers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Production Inspectors, Testers, Graders, Sorters, Samplers, Weighers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Production Laborers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Production, Planning, and Expediting Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Professional Photographers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Program Directors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Proofreaders and Copy Markers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Property, Real Estate, and Community Association Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Prosthodontists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Psychiatric Aides---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Psychiatric Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Psychiatrists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Psychology Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Public Address System and Other Announcers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Public Relations Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Public Relations Specialists---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Public Transportation Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Pump Operators, Except Wellhead Pumpers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Punching Machine Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Purchasing Agents and Buyers, Farm Products---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Purchasing Agents, Except Wholesale, Retail, and Farm Products---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Purchasing Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radar and Sonar Technicians---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radiation Therapists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radio and Television Announcers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radio Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radio Operators---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radiologic Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radiologic Technologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Radiologic Technologists and Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rail Car Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rail Yard Engineers, Dinkey Operators, and Hostlers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Railroad Brake, Signal, and Switch Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Railroad Conductors and Yardmasters---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Railroad Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Railroad Yard Workers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rail-Track Laying and Maintenance Equipment Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Range Managers---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Real Estate Brokers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Real Estate Sales Agents---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Receptionists and Information Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Recreation and Fitness Studies Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Recreation Workers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Recreational Therapists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Recreational Vehicle Service Technicians---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Reed or Wind Instrument Repairers and Tuners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Refractory Materials Repairers, Except Brickmasons---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Refrigeration Mechanics---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Refuse and Recyclable Material Collectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Registered Nurses---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rehabilitation Counselors---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Reinforcing Iron and Rebar Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Reporters and Correspondents---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Reservation and Transportation Ticket Agents---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Reservation and Transportation Ticket Agents and Travel Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Residential Advisors---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Respiratory Therapists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Respiratory Therapy Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Retail Salespersons---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Riggers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rock Splitters, Quarry---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rolling Machine Setters, Operators, and Tenders, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Roof Bolters, Mining---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Roofers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rotary Drill Operators, Oil and Gas---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Rough Carpenters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Roustabouts, Oil and Gas---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sailors and Marine Oilers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Agents, Financial Services---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Agents, Securities and Commodities---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Engineers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Agricultural---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Chemical and Pharmaceutical---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Electrical/Electronic---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Instruments---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Mechanical Equipment and Supplies---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Medical---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Wholesale and Manufacturing, Except Technical and Scientific Products---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sales Representatives, Wholesale and Manufacturing, Technical and Scientific Products---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sawing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sawing Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sawing Machine Setters, Operators, and Tenders, Wood---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sawing Machine Tool Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Scanner Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Screen Printing Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sculptors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Secondary School Teachers, Except Special and Vocational Education---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Secretaries, Except Legal, Medical, and Executive---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Securities, Commodities, and Financial Services Sales Agents---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Security and Fire Alarm Systems Installers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Security Guards---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Segmental Pavers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Self-Enrichment Education Teachers---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Semiconductor Processors---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Separating, Filtering, Clarifying, Precipitating, and Still Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Septic Tank Servicers and Sewer Pipe Cleaners---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Service Station Attendants---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Service Unit Operators, Oil, Gas, and Mining---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Set and Exhibit Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Set Designers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sewers, Hand---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sewing Machine Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sewing Machine Operators, Garment---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sewing Machine Operators, Non-Garment---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shampooers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shear and Slitter Machine Setters and Set-Up Operators, Metal and Plastic---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sheet Metal Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sheriffs and Deputy Sheriffs---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ship and Boat Captains---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ship Carpenters and Joiners---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ship Engineers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shipping, Receiving, and Traffic Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shoe and Leather Workers and Repairers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shoe Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shop and Alteration Tailors---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Shuttle Car Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Signal and Track Switch Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Silversmiths---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Singers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sketch Artists---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Skin Care Specialists---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Slaughterers and Meat Packers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Slot Key Persons---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Social and Community Service Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Social and Human Service Assistants---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Social Science Research Assistants---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Social Work Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sociologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sociology Teachers, Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Soil and Plant Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Soil Conservationists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Soil Scientists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Solderers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Soldering and Brazing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Soldering and Brazing Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Sound Engineering Technicians---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Special Education Teachers, Middle School---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Special Education Teachers, Preschool, Kindergarten, and Elementary School---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Special Education Teachers, Secondary School---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Special Forces---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Special Forces Officers---Military Specific Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Speech-Language Pathologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Spotters, Dry Cleaning---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Statement Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Station Installers and Repairers, Telephone---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stationary Engineers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stationary Engineers and Boiler Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Statistical Assistants---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Statisticians---Computer and Mathematical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stevedores, Except Equipment Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stock Clerks and Order Fillers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stock Clerks- Stockroom, Warehouse, or Storage Yard---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stock Clerks, Sales Floor---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stone Cutters and Carvers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stone Sawyers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stonemasons---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Storage and Distribution Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Stringed Instrument Repairers and Tuners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Strippers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Structural Iron and Steel Workers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Structural Metal Fabricators and Fitters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Substance Abuse and Behavioral Disorder Counselors---Community and Social Services Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Subway and Streetcar Operators---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Surgeons---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Surgical Technologists---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Survey Researchers---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Surveying and Mapping Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Surveying Technicians---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Surveyors---Architecture and Engineering Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Switchboard Operators, Including Answering Service---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tailors, Dressmakers, and Custom Sewers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Talent Directors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tank Car, Truck, and Ship Loaders---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tapers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tax Examiners, Collectors, and Revenue Agents---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tax Preparers---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Taxi Drivers and Chauffeurs---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Teacher Assistants---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Team Assemblers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Technical Directors/Managers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Technical Writers---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Telecommunications Equipment Installers and Repairers, Except Line Installers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Telecommunications Facility Examiners---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Telecommunications Line Installers and Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Telemarketers---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Telephone Operators---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tellers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Terrazzo Workers and Finishers---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Textile Bleaching and Dyeing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Textile Cutting Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Textile Knitting and Weaving Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Textile Winding, Twisting, and Drawing Out Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tile and Marble Setters---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Timing Device Assemblers, Adjusters, and Calibrators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tire Builders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tire Repairers and Changers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Title Examiners and Abstractors---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Title Examiners, Abstractors, and Searchers---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Title Searchers---Legal Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tool and Die Makers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tool Grinders, Filers, and Sharpeners---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tour Guides and Escorts---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tractor-Trailer Truck Drivers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Traffic Technicians---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Train Crew Members---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Training and Development Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Training and Development Specialists---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transformer Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transit and Railroad Police---Protective Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transportation Attendants, Except Flight Attendants and Baggage Porters---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transportation Inspectors---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transportation Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Transportation, Storage, and Distribution Managers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Travel Agents---Sales and Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Travel Clerks---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Travel Guides---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Treasurers, Controllers, and Chief Financial Officers---Management Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Tree Trimmers and Pruners---Building and Grounds Cleaning and Maintenance Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Truck Drivers, Heavy---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Truck Drivers, Heavy and Tractor-Trailer---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Truck Drivers, Light or Delivery Services---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Typesetting and Composing Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Umpires, Referees, and Other Sports Officials---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Upholsterers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Urban and Regional Planners---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Ushers, Lobby Attendants, and Ticket Takers---Personal Care and Service Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Valve and Regulator Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Veterinarians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Veterinary Assistants and Laboratory Animal Caretakers---Healthcare Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Veterinary Technologists and Technicians---Healthcare Practitioner and Technical Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Vocational Education Teachers Postsecondary---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Vocational Education Teachers, Middle School---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Vocational Education Teachers, Secondary School---Education, Training, and Library Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Waiters and Waitresses---Food Preparation and Serving Related Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Watch Repairers---Installation, Maintenance, and Repair Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Water and Liquid Waste Treatment Plant and System Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Weighers, Measurers, Checkers, and Samplers, Recordkeeping---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welder-Fitters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welders and Cutters---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welders, Cutters, Solderers, and Brazers---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welders, Production---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welding Machine Operators and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welding Machine Setters and Set-Up Operators---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welding, Soldering, and Brazing Machine Setters, Operators, and Tenders---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Welfare Eligibility Workers and Interviewers---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Well and Core Drill Operators---Construction and Extraction Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Wellhead Pumpers---Transportation and Material Moving Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Wholesale and Retail Buyers, Except Farm Products---Business and Financial Operations Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Woodworking Machine Operators and Tenders, Except Sawing---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Woodworking Machine Setters and Set-Up Operators, Except Sawing---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Woodworking Machine Setters, Operators, and Tenders, Except Sawing---Production Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Word Processors and Typists---Office and Administrative Support Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Writers and Authors---Arts, Design, Entertainment, Sports, and Media Occupations', 99, getdate(), 'system', getdate(), 'system'
union select 'Zoologists and Wildlife Biologists---Life, Physical, and Social Science Occupations', 99, getdate(), 'system', getdate(), 'system'

UPDATE p1
SET p1.Parent = (SELECT p2.Id
               FROM Profession p2
               WHERE p2.Name like '%' + ltrim(rtrim(REPLACE(RIGHT(p1.name, len(p1.name)-charindex('---', p1.name)-2), 'occupations', ''))) + '%'
               and p2.Parent = 0),
    p1.Name = rtrim(ltrim(replace(LEFT(p1.Name, charindex('---', p1.name)), '-', '')))
FROM Profession p1
WHERE p1.Parent = 99
go

print '*** Table: Account ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Account')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Job_Account_PostedBy')
	begin
		alter table Job drop constraint fk_Job_Account_PostedBy
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountContacts_Account_Account')
	begin
		alter table AccountContacts drop constraint fk_AccountContacts_Account_Account
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountContacts_Account_Contact')
	begin
		alter table AccountContacts drop constraint fk_AccountContacts_Account_Contact
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_Account_From')
	begin
		alter table Communication drop constraint fk_Communication_Account_From
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_Account_To')
	begin
		alter table Communication drop constraint fk_Communication_Account_To
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_Account_Referred')
	begin
		alter table Communication drop constraint fk_Communication_Account_Referred
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountProfessions_Account')
	begin
		alter table AccountProfessions drop constraint fk_AccountProfessions_Account
	end
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_AccountLocations_Account')
	begin
		alter table AccountLocations drop constraint fk_AccountLocations_Account
	end
	
	drop table dbo.[Account]
end
create table dbo.Account
(
	Id int identity(1,1) not null primary key,
	Email nvarchar(100) not null,
	[Password] nvarchar(50) not null,
	Firstname nvarchar(50) not null,
	Middlename nvarchar(50) null,
	Lastname nvarchar(50) not null,
	Address1 nvarchar(100) null,
	Address2 nvarchar(100) null,
	City nvarchar(50) null,
	StateId int null constraint fk_Account_State foreign key references [State](Id),
	Zipcode nvarchar(15) null,
	CountryId int null constraint fk_Account_Country foreign key references [Country](Id),
	Phone nvarchar(100) not null,
	ProfilePic nvarchar(100) null,
	ProfileUrl nvarchar(100) null,
    SendHubId nvarchar(50) null,
    Paypal nvarchar(100) null,
    Rating int null,
	StatusId int not null constraint fk_Account_Status foreign key references [Status](Id),
	IGetReferralSendMeTxtMsg bit not null default 0,
	IGetReferralSendMeEmail bit not null default 0,
	IAmReferralSendMeTxtMsg bit not null default 0,
	IAmReferralSendMeEmail bit not null default 0,
	IGetRolodexInviteSendMeTxtMsg bit not null default 0,
	IGetRolodexInviteSendMeEmail bit not null default 0,
	IGetRewardSendMeTxtMsg bit not null default 0,
	IGetRewardSendMeEmail bit not null default 0,
	IGetNudgeSendMeTxtMsg bit not null default 0,
	IGetNudgeSendMeEmail bit not null default 0,
	IGetMessageSendMeTxtMsg bit not null default 0,
	IGetMessageSendMeEmail bit not null default 0,
	IGetJobQuestionSendMeTxtMsg bit not null default 0,
	IGetJobQuestionSendMeEmail bit not null default 0,
	HidePhoneNumber bit not null default 0,
	HideEmailAddress bit not null default 0,
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)

insert into Account
select 'gilbert.sauceda@gmail.com', 'referrals', 'Gilbert', null, 'Sauceda', '3506 Cornerstone St.', null, 'Round Rock', 44, '78681', 1, '512-579-1355', 'profilepic_gilbert_sauceda.jpg', 'gilsau', '10960030', null, 47, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'
union select 'mcriado@criadolawgroup.com', 'mcriado', 'Manuel', null, 'Criado', '123 private st.', null, 'Austin', 44, '78681', 1, '512-784-9614', 'profilepic_manuel_criado.jpg', 'mcriado', '11182074', null, 37, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'
union select 'gargoyo@hotmail.com', 'referrals', 'Gargoyo', null, 'King', '3506 Cornerstone St.', null, 'Round Rock', 44, '78681', 1, '650-600-3357', 'profilepic_gargoyle_king.jpg', 'gargoyo', '10960096', null, 37, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'
union select 'admin@chaoshardwear.com', 'referrals', 'Chaos', null, 'Hardwear', '3506 Cornerstone St.', null, 'Round Rock', 44, '78681', 1, '512-430-4048', 'profilepic_chaos_hardwear.jpg', 'chaoshardwear', '11085962', null, 70, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'
union select 'Ali@webdeventerprises.com', 'test', 'Ali', null, 'Chang', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Ali', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Anarchy@webdeventerprises.com', 'test', 'Anarchy', null, 'Bill', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Anarchy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Bell@webdeventerprises.com', 'test', 'Bell', null, 'Spell', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Bell', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Bill@webdeventerprises.com', 'test', 'Bill', null, 'Gates', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Bill', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Bill@webdeventerprises.com', 'test', 'Bill', null, 'Spill', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Bill', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Blair@webdeventerprises.com', 'test', 'Blair', null, 'Brown', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Blair', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Brad@webdeventerprises.com', 'test', 'Brad', null, 'Garret', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Brad', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Brandy@webdeventerprises.com', 'test', 'Brandy', null, 'Trike', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Brandy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Brian@webdeventerprises.com', 'test', 'Brian', null, 'Trek', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Brian', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Bubbly@webdeventerprises.com', 'test', 'Bubbly', null, 'Sarah', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Bubbly', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Carl@webdeventerprises.com', 'test', 'Carl', null, 'Meadows', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Carl', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Carrie@webdeventerprises.com', 'test', 'Carrie', null, 'Heffernan', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Carrie', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Cathy@webdeventerprises.com', 'test', 'Cathy', null, 'Simpson', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Cathy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Charlie@webdeventerprises.com', 'test', 'Charlie', null, 'Wong', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Charlie', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Chatty@webdeventerprises.com', 'test', 'Chatty', null, 'Kathy', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Chatty', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Cindy@webdeventerprises.com', 'test', 'Cindy', null, 'Lauper', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Cindy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Claudia@webdeventerprises.com', 'test', 'Claudia', null, 'Sac', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Claudia', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Cool@webdeventerprises.com', 'test', 'Cool', null, 'Blue', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Cool', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Courtney@webdeventerprises.com', 'test', 'Courtney', null, 'Weaver', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Courtney', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Dedra@webdeventerprises.com', 'test', 'Dedra', null, 'Price', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Dedra', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Doug@webdeventerprises.com', 'test', 'Doug', null, 'Harris', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Doug', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Farrah@webdeventerprises.com', 'test', 'Farrah', null, 'Faucet', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Farrah', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Fun@webdeventerprises.com', 'test', 'Fun', null, 'Sun', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Fun', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Funny@webdeventerprises.com', 'test', 'Funny', null, 'Bob', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Funny', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Geeky@webdeventerprises.com', 'test', 'Geeky', null, 'Tye', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Geeky', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'George@webdeventerprises.com', 'test', 'George', null, 'Thomas', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'George', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'John@webdeventerprises.com', 'test', 'John', null, 'Adams', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'John', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'John@webdeventerprises.com', 'test', 'John', null, 'Bond', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'John', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Johnny@webdeventerprises.com', 'test', 'Johnny', null, 'Klein', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Johnny', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Kenny@webdeventerprises.com', 'test', 'Kenny', null, 'Rogers', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Kenny', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Liono@webdeventerprises.com', 'test', 'Liono', null, 'Milano', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Liono', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Manuel@webdeventerprises.com', 'test', 'Manuel', null, 'Gonzalez', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Manuel', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Mary@webdeventerprises.com', 'test', 'Mary', null, 'Johnson', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Mary', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Melinda@webdeventerprises.com', 'test', 'Melinda', null, 'Faust', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Melinda', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Michelle@webdeventerprises.com', 'test', 'Michelle', null, 'Bell', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Michelle', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Mina@webdeventerprises.com', 'test', 'Mina', null, 'Fine', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Mina', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Nerdy@webdeventerprises.com', 'test', 'Nerdy', null, 'Kerdy', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Nerdy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Phil@webdeventerprises.com', 'test', 'Phil', null, 'Zie', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Phil', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Professor@webdeventerprises.com', 'test', 'Professor', null, 'Ian', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Professor', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Professor@webdeventerprises.com', 'test', 'Professor', null, 'Tom', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Professor', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Sally@webdeventerprises.com', 'test', 'Sally', null, 'Fally', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Sally', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Sara@webdeventerprises.com', 'test', 'Sara', null, 'Farah', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Sara', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Scary@webdeventerprises.com', 'test', 'Scary', null, 'Terry', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Scary', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Seven@webdeventerprises.com', 'test', 'Seven', null, 'Swanson', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Seven', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Tom@webdeventerprises.com', 'test', 'Tom', null, 'Zornes', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Tom', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Tony@webdeventerprises.com', 'test', 'Tony', null, 'Pony', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Tony', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Tori@webdeventerprises.com', 'test', 'Tori', null, 'Sorry', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Tori', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Trey@webdeventerprises.com', 'test', 'Trey', null, 'Frey', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Trey', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Trish@webdeventerprises.com', 'test', 'Trish', null, 'Fish', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Trish', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Tyrone@webdeventerprises.com', 'test', 'Tyrone', null, 'Biggins', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Tyrone', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Vick@webdeventerprises.com', 'test', 'Vick', null, 'Slick', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Vick', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Wendy@webdeventerprises.com', 'test', 'Wendy', null, 'Sykes', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Wendy', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Zack@webdeventerprises.com', 'test', 'Zack', null, 'Flack', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Zack', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  
union select 'Zeke@webdeventerprises.com', 'test', 'Zeke', null, 'Freak', '123 private street', 'apt. 123', 'Austin', (select top 1 id from state where Id < 100 order by NEWID()), '78681', 1, '555-555-5555', 'person.jpg', 'Zeke', '10960030', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), 'system', GETDATE(), 'system'  

update Account set ProfilePic = 'profilepic_' + Firstname + '_' + Lastname + '.jpg' where Firstname not in ('gilbert','gargoyo','chaos')

/*
declare @tblPerson table
(
	pic nvarchar(50),
	firstname nvarchar(50) null,
	lastname nvarchar(50) null
)
insert into @tblPerson(pic)
select 'profilepic_Ali_Chang.jpg'
union
select 'profilepic_Anarchy_Bill.jpg'
union
select 'profilepic_Bell_Spell.jpg'
union
select 'profilepic_Bill_Gates.jpg'        
union
select 'profilepic_Bill_Spill.jpg'
union
select 'profilepic_Blair_Brown.jpg'        
union
select 'profilepic_Brad_Garret.jpg'
union
select 'profilepic_Brandy_Trike.jpg'       
union
select 'profilepic_Brian_Trek.jpg'
union
select 'profilepic_Bubbly_Sarah.jpg'
union
select 'profilepic_Carl_Meadows.jpg'
union
select 'profilepic_Carrie_Heffernan.jpg'
union
select 'profilepic_Cathy_Simpson.jpg'
union
select 'profilepic_Charlie_Wong.jpg'     
union
select 'profilepic_Chatty_Kathy.jpg'
union
select 'profilepic_Cindy_Lauper.jpg'       
union
select 'profilepic_Claudia_Sac.jpg'
union
select 'profilepic_Cool_Blue.jpg'          
union
select 'profilepic_Courtney_Weaver.jpg'
union
select 'profilepic_Dedra_Price.jpg'        
union
select 'profilepic_Doug_Harris.jpg'
union
select 'profilepic_Farrah_Faucet.jpg'      
union
select 'profilepic_Funny_Bob.jpg'
union
select 'profilepic_Fun_Sun.jpg'            
union
select 'profilepic_Geeky_Tye.jpg'
union
select 'profilepic_George_Thomas.jpg'      
union
select 'profilepic_Johnny_Klein.jpg'
union
select 'profilepic_John_Adams.jpg'         
union
select 'profilepic_John_Bond.jpg'
union
select 'profilepic_Kenny_Rogers.jpg'       
union
select 'profilepic_Liono_Milano.jpg'
union
select 'profilepic_Manuel_Gonzalez.jpg'    
union
select 'profilepic_Mary_Johnson.jpg'
union
select 'profilepic_Melinda_Faust.jpg'      
union
select 'profilepic_Michelle_Bell.jpg'
union
select 'profilepic_Mina_Fine.jpg'          
union
select 'profilepic_Nerdy_Kerdy.jpg'
union
select 'profilepic_Phil_Zie.jpg'           
union
select 'profilepic_Professor_Ian.jpg'
union
select 'profilepic_Professor_Tom.jpg'      
union
select 'profilepic_Sally_Fally.jpg'
union
select 'profilepic_Sara_Farah.jpg'         
union
select 'profilepic_Scary_Terry.jpg'
union
select 'profilepic_Seven_Swanson.jpg'      
union
select 'profilepic_Tom_Zornes.jpg'
union
select 'profilepic_Tony_Pony.jpg'          
union
select 'profilepic_Tori_Sorry.jpg'
union
select 'profilepic_Trey_Frey.jpg'          
union
select 'profilepic_Trish_Fish.jpg'
union
select 'profilepic_Tyrone_Biggins.jpg'     
union
select 'profilepic_Vick_Slick.jpg'
union
select 'profilepic_Wendy_Sykes.jpg'        
union
select 'profilepic_Zack_Flack.jpg'
union
select 'profilepic_Zeke_Freak.jpg'

update @tblPerson set
firstname = rtrim(ltrim(replace(replace(SUBSTRING(pic, charindex('_', pic)+1, LEN(pic)-charindex('_', pic)+1), '.jpg', ''), '_', ' ')))

update @tblPerson set
lastname = SUBSTRING(firstname, charindex(' ', firstname), len(firstname)-charindex(' ', firstname)+1)

update @tblPerson set
firstname = SUBSTRING(firstname, 1, charindex(' ', firstname))

select '  select ''' + rtrim(ltrim(firstname)) + '@webdeventerprises.com'', ''test'', ''' + rtrim(ltrim(firstname)) + ''', null, ''' + rtrim(ltrim(lastname)) + ''', ''123 private street'', ''apt. 123'', ''Austin'', 44, ''78681'', 1, ''555-555-5555'', ''person.jpg'', ''' + rtrim(ltrim(firstname)) + ''', ''10960030'', null, (select top 1 id from state where Id < 100 order by NEWID()), 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, GETDATE(), ''system'', GETDATE(), ''system''  '
from @tblPerson
*/

go

print '*** Table: Job ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Job')
begin
	if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = N'fk_Communication_Job')
	begin
		alter table Communication drop constraint fk_Communication_Job
	end
	
	drop table dbo.[Job]
end
create table dbo.Job
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(100) not null,
	[Description] text not null,
	PostedByAcctId int constraint fk_Job_Account_PostedBy foreign key references [Account](Id),
	ReferralFee money null,
	StatusId int not null constraint fk_Job_Status foreign key references [Status](Id),
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)

declare @accountid int
set @accountid = 1
while @accountid < 58
begin
	insert into Job
	select 'Need website for cross browser compatibility for website', 'Create a website that will work on phone, tablet and desktop. This app will be downloadable and can be have many users.', @accountid, (select top 1 id*10 from state where Id < 100 order by NEWID()), 3, GETDATE(), 'system', GETDATE(), 'system'
	union
	select 'Need a carpenter to fix my house.', 'Build a rock pond that holds Koi fish. The fish have to be able to swim. I want them to live forever. I want a green one and orange one. I want them to be able to sing and dance too.', @accountid, (select top 1 id*10 from state where Id < 100 order by NEWID()), 3, GETDATE(), 'system', GETDATE(), 'system'
	union
	select 'Need graphic designer.', 'Need logos, icons, borders, whole branding package. I want my brand to be the best in the world and to beat all the competition.', @accountid, (select top 1 id*100 from state where Id < 10 order by NEWID()), 3, GETDATE(), 'system', GETDATE(), 'system'
	
	set @accountid = @accountid + 1
end
go

print '*** Table: AccountContacts ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'AccountContacts')
begin
	drop table dbo.AccountContacts
end
create table dbo.AccountContacts
(
	Id int identity(1,1) not null primary key,
	AccountId int not null constraint fk_AccountContacts_Account_Account foreign key references [Account](Id),
	ContactId int not null constraint fk_AccountContacts_Account_Contact foreign key references [Account](Id),
	StatusId int not null constraint fk_AccountContact_Status foreign key references [Status](Id),
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)
declare @accountid1 int, @accountid2 int

set @accountid1 = 1
while(@accountid1 < 58)
begin
	set @accountid2 = 1
	while @accountid2 < 58
	begin
		if(@accountid2 <> @accountid1)
		begin
			insert into AccountContacts
			select @accountid1, @accountid2, 2, GETDATE(), 'system', GETDATE(), 'system'
		end
		
		set @accountid2 = @accountid2 + 1
	end
	
	set @accountid1 = @accountid1 + 1
end
go

print '*** Table: AccountProfessions ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'AccountProfessions')
begin
	drop table dbo.AccountProfessions
end
create table dbo.AccountProfessions
(
	Id int identity(1,1) not null primary key,
	AccountId int constraint fk_AccountProfessions_Account foreign key references [Account](Id),
	ProfessionId int constraint fk_AccountProfessions_Profession foreign key references Profession(Id)
)
declare @accountid int
set @accountid = 1
while @accountid < 55
begin
	insert into AccountProfessions
	SELECT TOP 1 @accountid, Id FROM Profession where Id > 1 and Id < 200 and Parent > 0 ORDER BY NEWID()
	
	insert into AccountProfessions
	SELECT TOP 1 @accountid, Id FROM Profession where Id > 200 and Id < 400 and Parent > 0 ORDER BY NEWID()
	
	insert into AccountProfessions
	SELECT TOP 1 @accountid, Id FROM Profession where Id between 400 and 600 and Parent > 0 ORDER BY NEWID()
	
	set @accountid = @accountid + 1
end
go

print '*** Table: AccountLocations ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'AccountLocations')
begin
	drop table dbo.AccountLocations
end
create table dbo.AccountLocations
(
	Id int identity(1,1) not null primary key,
	Name nvarchar(50) not null,
	StateId int null constraint fk_AccountLocations_State foreign key references [State](Id),
	CountryId int null constraint fk_AccountLocations_Country foreign key references [Country](Id),
	AccountId int constraint fk_AccountLocations_Account foreign key references [Account](Id),
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)

declare @accountid int
set @accountid = 1
while @accountid < 55
begin
	insert into AccountLocations
	select 'City ' + cast(@accountid as nvarchar(5)), (SELECT TOP 1 Id FROM [State] ORDER BY NEWID()), (SELECT TOP 1 Id FROM Country ORDER BY NEWID()), (SELECT TOP 1 Id FROM Account ORDER BY NEWID()), GETDATE(), 'system', GETDATE(), 'system'
	union
	select 'City ' + cast(@accountid as nvarchar(5)), (SELECT TOP 1 Id FROM [State] ORDER BY NEWID()), (SELECT TOP 1 Id FROM Country ORDER BY NEWID()), (SELECT TOP 1 Id FROM Account ORDER BY NEWID()), GETDATE(), 'system', GETDATE(), 'system'
	
	set @accountid = @accountid + 1
end
go

print '*** Table: Communication ******************************************************'
if exists(select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = N'Communication')
begin
	drop table dbo.Communication
end
create table dbo.Communication
(
	Id int identity(1,1) not null primary key,
	CommMethodId int null constraint fk_Communication_CommMethod foreign key references CommMethod(Id),
	ActionId int not null constraint fk_Communication_Action foreign key references [Action](Id),
	FromAcctId int not null constraint fk_Communication_Account_From foreign key references [Account](Id),
	ToAcctId int not null constraint fk_Communication_Account_To foreign key references [Account](Id),
	ReferredAcctId int null constraint fk_Communication_Account_Referred foreign key references [Account](Id),
	JobId int null constraint fk_Communication_Job foreign key references Job(Id),
	StatusToId int not null constraint fk_Communication_StatusTo foreign key references [Status](Id),
	StatusReferredId int null constraint fk_Communication_StatusReferred foreign key references [Status](Id),
	ReferralId uniqueidentifier null,
	ConversationId uniqueidentifier null,
	SubjectTo nvarchar(250) null,
	MessageTo text null,
	MessageToEmail text null,
	MessageToTxtMsg text null,
	SubjectReferred nvarchar(250) null,
	MessageReferred text null,
	MessageReferredEmail text null,
	MessageReferredTxtMsg text null,
	MessageToEmailSent bit null default 0,
	MessageToTxtMsgSent bit null default 0,
	MessageRefEmailSent bit null default 0,
	MessageRefTxtMsgSent bit null default 0,
	Archived bit null default 0,
	Created datetime not null default getdate(),
	CreatedBy nvarchar(100) not null default 'system',
	LastUpdated datetime not null default getdate(),
	LastUpdatedBy nvarchar(100) not null default 'system'
)
go

/*

select * from Communication where conversationid='f3754eb3-363f-4d9e-ba17-df0966d7b520'

select * from status

select * from Account where firstname like '%gilbert%'
select * from Account where firstname like '%chaos%'
select * from Account where firstname like '%gargoyo%'

*/