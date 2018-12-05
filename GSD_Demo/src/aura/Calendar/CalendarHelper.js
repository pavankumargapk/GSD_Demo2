({
	loadDataToCalendar :function(component,data){  
        //Find Current date for default date
        var contactid=component.get("v.recordId");
       
        var d = new Date();
        var month = d.getMonth()+1;
        var day = d.getDate();
        var currentDate = d.getFullYear() + '/' +
            (month<10 ? '0' : '') + month + '/' +
            (day<10 ? '0' : '') + day;
         
        var self = this;
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,basicWeek,basicDay'
            },
            selectable : true,
            defaultDate: currentDate,
            editable: false,
            eventLimit: true,
            events:data,
            dragScroll : true,
             droppable: true,
            weekNumbers : true,
            eventDrop: false,
            eventClick: function(event, jsEvent, view) {
                 component.set("v.ShowCalendar",false);
           
           /*   var editRecordEvent = $A.get("e.force:editRecord");
              editRecordEvent.setParams({
              "recordId": event.id
           });
           editRecordEvent.fire();*/
               // component.set("v.isOpen", true);
                
                component.set("v.edit",true);
                component.set("v.Apprecordid",event.id);
              /*  $A.createComponents([
           [ "force:recordEdit",
            {
                "aura:id":"editer",
                
                "recordId": component.get("v.Apprecordid")
            }],
                    [
                        "ui:button",
                        
                        {
                            "label":"Save",
                            " press":component.getReference("c.save1")
                        }
                    ]
               
                    ],function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newButton[0]);
                    body.push(newButton[1]);
                    component.set("v.body", body);
                }
                    else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
                }
                    );*/
            
          },
            dayClick :function(date, jsEvent, view) {
                    

                var datelist = date.format().toString().split('-');
             alert(datelist+'datelist')
            //  var datetime = new Date(datelist[0]+4,parseInt(datelist[1]),parseInt(datelist[2]));
           // alert('date'+datetime);
                component.set("v.datetime",datelist);
            /* var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Appointment__c",
        "defaultFieldValues": {
        'StartDate_Time__c' :  datetime,
            'Contact__c'    : component.get("v.recordId")
           
        
    }
    });
    createRecordEvent.fire();*/
             
                var loadchecker=component.get("v.createloader");
                if(loadchecker==true)
                component.set("v.createloader",false);
                else
                component.set("v.createloader",true);
                component.set("v.create",true);
//             $A.util.removeClass(component.find("calendar"), "slds-hide");
       
          },
            
            eventMouseover : function(event, jsEvent, view) {
            
          }
    });
    },
       
    
    formatFullCalendarData : function(component,events) {
        var josnDataArray = [];
        for(var i = 0;i < events.length;i++){
            var startdate = $A.localizationService.formatDate(events[i].StartDate_Time__c);
            var enddate = $A.localizationService.formatDate(events[i].End_Date_Time__c);
            josnDataArray.push({
                'title':events[i].Subject__c,
                'start':startdate,
                'end':enddate,
                'id':events[i].Id
            });
        }
      
        return josnDataArray;
    },
     
    fetchCalenderEvents : function(component) {
        
         var action=component.get("c.getAllEvents");
         action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var data= response.getReturnValue();
                var jsona=[];
              
                 var josnArr = this.formatFullCalendarData(component,response.getReturnValue());
                this.loadDataToCalendar(component,josnArr);
                component.set("v.Objectlist",josnArr);
           
            } else if (state === "ERROR") {
                                 
            }
        });
        
        $A.enqueueAction(action);
       
    }, 
    
    editEvent : function(component,eventid,eventdate){
      
        var action=component.get("c.updateEvent");

         action.setParams({ eventid : eventid ,
                           eventdate : eventdate});

         action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
           /*  var data= response.getReturnValue();
               alert('res'+data);
                 var josnArr = this.formatFullCalendarData(component,response.getReturnValue());
                this.loadDataToCalendar(component,josnArr);
                component.set("v.Objectlist",josnArr);
           */
            } else if (state === "ERROR") {
                                 
            }
        });
        
        $A.enqueueAction(action);

    }
    
})