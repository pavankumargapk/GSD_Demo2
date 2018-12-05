public class CalenderClass {
    //this method will get all the existing appointments(events)
    @AuraEnabled
    public static list<Appointment__c> getAllEvents(){
        
        list<Appointment__c> eventlist =[Select id, Contact__c,End_Date_Time__c,StartDate_Time__c,Subject__c,Appointment_Description__c from Appointment__c ] ;
        system.debug('evnts are'+eventlist);
        return eventlist;
    }
    //this method will update the event by taking eventid and event date as parameter
   /* @AuraEnabled
    public static void updateEvent(string eventid,string eventdate){
        system.debug(eventid);
        system.debug(eventdate);
        string eventdatelist = eventdate.replace('T',' ');
        
        system.debug(eventdatelist);
        Appointment__c e= new Appointment__c(id = eventid);
        
        e.StartDate_Time__c = DateTime.valueof(eventdatelist);
        update e;
        
    }*/
    //This method will create a new datetime instance that we got from script
    @AuraEnabled
    public static Datetime changeDateformat(list<String> datestring){
        system.debug('date'+datestring);
   //creating a new datetime instance from the date list format that we got from the  full calendar script
        DateTime ClickedDateTime=Datetime.newInstance(Integer.valueOf(datestring[0]), Integer.valueOf(datestring[1]), Integer.valueOf(datestring[2]), 00, 00, 00);
        system.debug('dt'+ClickedDateTime);
   
        return ClickedDateTime;
    }
  /*  @AuraEnabled
    public static list<boolean> ValidateRecord(Datetime Startdate,Datetime Enddate){
        system.debug('n'+Startdate+'p'+Enddate);
        Datetime   StartDateTime=Startdate;
        DateTime EndDateTime=Enddate;
        system.debug('Start'+StartDateTime);
        system.debug('End'+EndDateTime);
        DateTime currentTime = System.now();
        Boolean StartBool=true;
        Boolean EndDateBool=true;
        Map<DateTime,Map<DateTime,Appointment__c>> StartTimeRecord=new  Map<DateTime,Map<DateTime,Appointment__c>>();
        Map<DateTime,Appointment__c> EndTimeRecord=new  Map<DateTime,Appointment__c>();
        
        for(Appointment__c app:[Select id,Name, Contact__c,End_Date_Time__c,StartDate_Time__c,Subject__c,Appointment_Description__c from Appointment__c ]){
            StartTimeRecord.put(app.StartDate_Time__c,new Map<DateTime,Appointment__c>{app.End_Date_Time__c => app});
            EndTimeRecord.put(app.StartDate_Time__c,app);
        }
        
        if(StartTimeRecord.get(StartDateTime)!=null){
            // apt.StartDate_Time__c.addError('This time slot is already occupied.Please choose another start time');
            StartBool=false;
        }
        system.debug('now'+System.now()+'   start'+StartDateTime);
        if(StartDateTime<System.now()){
            system.debug('now');
            StartBool=false;
            system.debug('Startbool'+StartBool);
            //apt.StartDate_Time__c.addError('You cannot book appointments in past');
            
            
        }
        for(DateTime st:StartTimeRecord.keySet()){
            list<DateTime> EndTimeRec=new list<DateTime>();
            EndTimeRec.addAll(StartTimeRecord.get(st).keyset());
            if((st<StartDateTime) && (StartDateTime<=EndTimeRec[0])){
                StartBool=false; 
                
                //apt.StartDate_Time__c.addError('This time slot is already occupied.Please choose another start time with the appointment'+(EndTimeRecord.get(st)).Name);
            }
            if((st<EndDateTime) && (EndDateTime<=EndTimeRec[0])){
                //  apt.End_Date_Time__c.addError('This time slot is already occupied.Please choose another start time with the appointment'+(EndTimeRecord.get(st)).Name);
                EndDateBool=false;
            }
        }
        system.debug('Start'+StartBool);
        system.debug('End'+EndDateBool);
        List<Boolean> Statuses=new list<Boolean>();
        Statuses.add(StartBool);
        Statuses.add(EndDateBool);
        
        return Statuses;
        //  else if()
    }*/
}