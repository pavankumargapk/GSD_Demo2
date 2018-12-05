({
    handleSubmit : function(component, event, helper) {
        var el = component.find("start");
        $A.util.removeClass(el, "slds-has-error"); 
        // remove red border 
        $A.util.addClass(el, "hide-error-message"); 
    },
    handleSuccess: function(component, event, helper) {
        $A.util.removeClass(component.find("Recmodal"), "slds-show");
        $A.util.addClass(component.find("Recmodal"), "slds-hide");
        
        
        $A.get("e.force:closeQuickAction").fire();
    },
    doInit: function(component, event, helper) {
        
        
        var action=component.get("c.changeDateformat");
        
        action.setParams({
            datestring :  component.get("v.datetime") 
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                
                component.set("v.datetimer",response.getReturnValue());
                
            } else if (state === "ERROR") {
                
            }
        });
        
        $A.enqueueAction(action);
        
        
        
    },
    
    Cancel: function(component, event, helper) {
        component.set("v.datetimer",null);
        
        var el = component.find("start");
        
        $A.util.removeClass(el, "slds-has-error"); // remove red border
        $A.util.addClass(el, "hide-error-message");
        $A.util.removeClass(component.find("Recmodal"), "slds-show");
        $A.util.addClass(component.find("Recmodal"), "slds-hide");
        
        
        $A.get("e.force:closeQuickAction").fire();
        
        
    },
    itemsChange: function(component, event, helper) {
        $A.util.removeClass(component.find("Recmodal"), "slds-hide");
        $A.util.addClass(component.find("Recmodal"), "slds-show");
        var action=component.get("c.changeDateformat");
        
        action.setParams({
            datestring :  component.get("v.datetime") 
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.datetimer",response.getReturnValue());
            } else if (state === "ERROR") {
            }
        });
        
        $A.enqueueAction(action);
        
    }
})