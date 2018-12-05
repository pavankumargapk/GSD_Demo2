/*
Author  :  G.Pavan Kumar
Purpose :  Trigger Handler for Appointment object
CreatedDate    :  30-10-2018

*/

public class AppointmentHandler {
    //this method will send the event email to contact 
    @AuraEnabled
    public static void SendtoContact(list<Appointment__c> Appoits){
        //iterate on list of appointments
        for(Appointment__c app :Appoits){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            // Who you are sending the email to
            
            mail.setTargetObjectId(app.Contact__c);
            
            // The email template ID used for the email
            
            mail.setTemplateId('00X6F000002BfDr');
           
            mail.setWhatId(app.Id);   
            
            mail.setSenderDisplayName('Joe');
            
            mail.setSaveAsActivity(false); 
            
            mail.setReplyTo(Label.AppointmentEmailServiceReply); //reply emailId used from email service
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); //send email to the contact with event
        }
    }
    //this method will check the availability of timings
    @AuraEnabled
    public static void CheckAppointmentTImings(list<Appointment__c> Appoits){
        DateTime currentTime = System.now(); //current datetime
        
        //this map of map has key as startdatetime and the innermap has key as enddatetime and value as appointment
        Map<DateTime,Map<DateTime,Appointment__c>> StartTimeRecord=new  Map<DateTime,Map<DateTime,Appointment__c>>();
        
        //this map has endtime as key and appointment as value
        Map<DateTime,Appointment__c> EndTimeRecord=new  Map<DateTime,Appointment__c>();
        
       
        //list of all the existing appointments which are in future
        //iterate on all appointments and put the values to StartTimeRecord and  EndTimeRecord maps
        for(Appointment__c app:[Select id,Name, Contact__c,End_Date_Time__c,StartDate_Time__c,Subject__c,Appointment_Description__c from Appointment__c where StartDate_Time__c>= :System.now() ]){
            StartTimeRecord.put(app.StartDate_Time__c,new Map<DateTime,Appointment__c>{app.End_Date_Time__c => app});
            EndTimeRecord.put(app.StartDate_Time__c,app);
        }
        
        for(Appointment__c apt:Appoits){
            //check if startdatetime of new appointment already exists for the existing appointments. If so, display the error message
            if(StartTimeRecord.get(apt.StartDate_Time__c)!=null){
                apt.StartDate_Time__c.addError('This time slot is already occupied.Please choose another start time');
            }
            system.debug('now'+System.now());
            //check if startdatetime of new appointment is in past date. iIf so, display the error message
            if(apt.StartDate_Time__c<System.now()){
                system.debug('now');
                apt.StartDate_Time__c.addError('You cannot book appointments in past');                
            }
            //check if the enddatetime  and startdate of new appointment heads between somewhere in middle of any existing appointments timeframe
            // If so, display the error message
            for(DateTime st:StartTimeRecord.keySet()){
                list<DateTime> EndTimeRec=new list<DateTime>();
                EndTimeRec.addAll(StartTimeRecord.get(st).keyset());
                if((st<apt.StartDate_Time__c) && (apt.StartDate_Time__c<=EndTimeRec[0])){
                    
                    
                    apt.StartDate_Time__c.addError('This time slot is already occupied.Please choose another start time with the appointment'+(EndTimeRecord.get(st)).Name);
                }
                if((st<apt.End_Date_Time__c) && (apt.End_Date_Time__c<=EndTimeRec[0])){
                    apt.End_Date_Time__c.addError('This time slot is already occupied.Please choose another start time with the appointment'+(EndTimeRecord.get(st)).Name);
                    
                }
            }
            
        }
        
    }
}