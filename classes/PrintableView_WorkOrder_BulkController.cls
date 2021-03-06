public class PrintableView_WorkOrder_BulkController {
    private ApexPages.StandardSetController standardSetController;
    public string woIdStr{get;set;}
    public string[] woIds{get;set;}
    
    public PrintableView_WorkOrder_BulkController(ApexPages.StandardSetController standardSetController)
    {
        this.standardSetController = standardSetController;
        List<WorkOrder> selectedListViewRecords = (List<WorkOrder>) standardSetController.getSelected();
        
        woIds = new list<string>();
        for(WorkOrder wo : selectedListViewRecords){
             woIds.add(wo.Id);
        }
        woIdStr= woIds.size()>0 ? String.join(woIds, ',') : '';
        
    }
    
    @auraEnabled 
    public static map<String,map<String,String>>doInit(list<Id> workOrderIds){
      
        list<WorkOrder> theseWorkOrders = [select AssetId, MaintenancePlanId, SuggestedMaintenanceDate, Work_Order_Name__c,WorkOrderNumber from WorkOrder where Id =: workOrderIds];
        
        Date latestSuggestedMaintenanceDate = system.today().addDays(-3560);
        set<Id> maintenancePlanIds = new set<Id>();
        for (WorkOrder wo : theseWorkOrders){
            if (wo.SuggestedMaintenanceDate > latestSuggestedMaintenanceDate){
                latestSuggestedMaintenanceDate = wo.SuggestedMaintenanceDate;
            }
            maintenancePlanIds.add(wo.MaintenancePlanId);
        }
        
        list<WorkOrder> previousWorkOrders = [select Id, SuggestedMaintenanceDate, MaintenancePlanId from WorkOrder where MaintenancePlanId in: maintenancePlanIds and SuggestedMaintenanceDate <=: latestSuggestedMaintenanceDate and Id !=: workOrderIds Order By SuggestedMaintenanceDate asc];
        
        map<String,map<String,String>> workOrderIdsToLabelToValueMap = new map<String,map<String,String>>();
        
        map<String,String> labelToValueMap = new map<String,String>();
        for (WorkOrder thisWorkOrder : theseWorkOrders){
            labelToValueMap = new map<String,String>();
            if(thisWorkOrder.Work_Order_Name__c != null){
                labelToValueMap.put('workOrderName',thisWorkOrder.Work_Order_Name__c);
            }
            if (thisWorkOrder.AssetId != null){
                labelToValueMap.put('assetId',thisWorkOrder.AssetId);
            }
            if(thisWorkOrder.MaintenancePlanId != null){
                labelToValueMap.put('maintenancePlanId',thisWorkOrder.MaintenancePlanId);
            }
            if(thisWorkOrder.SuggestedMaintenanceDate != null){
                labelToValueMap.put('thisWorkOrderSuggestedMaintenanceDate',String.valueOf(thisWorkOrder.SuggestedMaintenanceDate));
            }
            if (thisWorkOrder.WorkOrderNumber != null){
                labelToValueMap.put('workOrderNumber',thisWorkOrder.WorkOrderNumber);
            }
            for (WorkOrder previousWorkOrder : previousWorkOrders){
                if (previousWorkOrder.MaintenancePlanId == thisWorkOrder.MaintenancePlanId && previousWorkOrder.SuggestedMaintenanceDate < thisWorkOrder.SuggestedMaintenanceDate){
                    labelToValueMap.put('previousWorkOrderId',previousWorkOrder.Id);
                }
            }
            
            workOrderIdsToLabelToValueMap.put(thisWorkOrder.Id,labelToValueMap);
            
        }
        return workOrderIdsToLabelToValueMap;
        
    }
}