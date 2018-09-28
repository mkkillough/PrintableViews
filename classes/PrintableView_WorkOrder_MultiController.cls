public class PrintableView_WorkOrder_MultiController{
    
    ApexPages.StandardSetController setCon;
    
    public PrintableView_WorkOrder_MultiController(ApexPages.StandardSetController controller)
    {
        setCon = controller;
    }

    public pageReference doSomething()
    {
        // do something with the selected records
        for ( WorkOrder wo : (WorkOrder[])setCon.getSelected() )
        {
                System.debug('##Work Order name = ' + wo.Work_Order_Name__c);
        }
        return null;
    }
}