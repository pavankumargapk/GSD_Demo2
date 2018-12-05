/*
Author         :  G.Pavan Kumar
Purpose        :  Trigger  for Appointment object
CreatedDate    :  30-10-2018

*/

trigger Appointmenttrigger on Appointment__c (after insert,before insert) {
    if(trigger.IsBefore && trigger.IsInsert){
        //Checking Appointment timings before Insert
        AppointmentHandler.CheckAppointmentTImings(trigger.new);
    }
    if(trigger.IsAfter && trigger.IsInsert){
        //Sending Mails after Insert
         AppointmentHandler.SendtoContact(trigger.new);
    }
}