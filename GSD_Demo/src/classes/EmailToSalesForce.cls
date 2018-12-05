global class EmailToSalesForce implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, 
                                                         Messaging.Inboundenvelope envelope) {
  
Appointment__c Appointment;
Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

try {
// Look for account whose name is the subject and create it if necessary
string emailSub = email.subject;
    system.debug('subject isssss'+ emailSub);
    string emailreference = emailSub.substring(emailSub.indexOf('Appointment Confirmation for ')+29).trim();
    system.debug('emailreference '+emailreference);
  Appointment = [select Id from Appointment__c where Name =:emailreference];
    system.debug('order id'+Appointment);

Appointment.Confirmed__c=true;

      update Appointment;
      //result.success = true;
      //result.message = (email.subject + ' matched');
    } catch (Exception e) {
      //result.success = false;
      //result.message = 'Oops, I failed.';
    }
   
    return null;
  }
}