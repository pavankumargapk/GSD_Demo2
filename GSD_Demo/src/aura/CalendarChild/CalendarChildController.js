({
    save : function(component, event, helper) {
        console.log('record'+component.get("v.Apprecordid"));
        
        component.find("editer").get("e.recordSave").fire();
        //  $A.get("e.force:closeQuickAction").fire();
        $A.util.removeClass(component.find("Recmodal"), "slds-show");
        $A.util.addClass(component.find("Recmodal"), "slds-hide");
        // helper.fetchCalenderEvents(component);
        // $A.get('e.force:refreshView').fire();
        // window.location.reload();
        
        
        //$A.get("e.force:closeQuickAction").fire();
        
    },
    Cancel: function(component, event, helper) {
        $A.util.removeClass(component.find("Recmodal"), "slds-show");
        $A.util.addClass(component.find("Recmodal"), "slds-hide");
    },
    itemsChange:function(component, event, helper) {
        //  component.set("v.apprecordid",component.get("v.apprecordid"));
        /*  component.find("editer").get("e.recordSave").fire();
        //  $A.get("e.force:closeQuickAction").fire();*/
        $A.util.removeClass(component.find("Recmodal"), "slds-hide");
        $A.util.addClass(component.find("Recmodal"), "slds-show");
    },
    handleSubmit :function(component, event, helper) {
        $A.util.removeClass(component.find("Recmodal"), "slds-show");
        $A.util.addClass(component.find("Recmodal"), "slds-hide");
    }
})