delimiter //
-- Trigger to add a new donor's organ to the available organ list
create trigger ADD_DONOR
after insert
on Donor
for each row
begin
insert into Organ_available(Organ_name, Donor_ID)
values (new.organ_donated, new.Donor_ID);
end//
delimiter ;

delimiter //
-- Trigger to remove an organ from the available list after a transaction
create trigger REMOVE_ORGAN
after insert
on Transaction
for each row
begin
delete from Organ_available
where Organ_ID = new.Organ_ID;
end//
delimiter ;

delimiter //
-- Trigger to log the addition of a new donor
create trigger ADD_DONOR_LOG
after insert
on Donor
for each row
begin
insert into log values
(now(), concat("Inserted new Donor", cast(new.Donor_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log the update of a donor's details
create trigger UPD_DONOR_LOG
after update
on Donor
for each row
begin
insert into log values
(now(), concat("Updated Donor Details", cast(new.Donor_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log the deletion of a donor
create trigger DEL_DONOR_LOG
after delete
on Donor
for each row
begin
insert into log values
(now(), concat("Deleted Donor ", cast(old.Donor_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log the addition of a new patient
create trigger ADD_PATIENT_LOG
after insert
on Patient
for each row
begin
insert into log values
(now(), concat("Inserted new Patient ", cast(new.Patient_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log the update of a patient's details
create trigger UPD_PATIENT_LOG
after update
on Patient
for each row
begin
insert into log values
(now(), concat("Updated Patient Details ", cast(new.Patient_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log the deletion of a patient
create trigger DEL_PATIENT_LOG
after delete
on Patient
for each row
begin
insert into log values
(now(), concat("Deleted Patient ", cast(old.Patient_Id as char)));
end //
delimiter ;

delimiter //
-- Trigger to log a new transaction
create trigger ADD_TRASACTION_LOG
after insert
on Transaction
for each row
begin
insert into log values
(now(), concat("Added Transaction :: Patient ID : ", cast(new.Patient_ID as char), "; Donor ID : " ,cast(new.Donor_ID as char)));
end //
delimiter ;