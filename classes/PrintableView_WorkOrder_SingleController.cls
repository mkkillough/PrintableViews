public class PrintableView_WorkOrder_SingleController {
    @auraEnabled
    public static string getAssetId(Id workOrderId){
        string assetId = '';
        assetId = [select AssetId from WorkOrder where Id =: workOrderId limit 1].AssetId;
        return assetId;
    }
    @auraEnabled
    public static string getMaintenancePlanId(Id workOrderId){
        string maintenancePlanId = '';
        maintenancePlanId = [select MaintenancePlanId from WorkOrder where Id =: workOrderId limit 1].MaintenancePlanId;
        return maintenancePlanId;
    }
    @auraEnabled
    public static string getPreviousWorkOrderId(Id workOrderId){
        system.debug('##workOrderId: '+workOrderId);
        
        string previousWorkOrderId = '';
        WorkOrder thisWorkOrder = [select SuggestedMaintenanceDate,MaintenancePlanId from WorkOrder where Id =: workOrderId];
        Date thisWorkOrderSuggestedMaintenanceDate = thisWorkOrder.SuggestedMaintenanceDate;
        Id maintenancePlanId = thisWorkOrder.MaintenancePlanId;
        system.debug('##maintenancePlanId: '+maintenancePlanId);
        system.debug('##:thisWorkOrderSuggestedMaintenanceDate: '+ thisWorkOrderSuggestedMaintenanceDate);
        previousWorkOrderId = [select Id from WorkOrder where MaintenancePlanId =: maintenancePlanId and SuggestedMaintenanceDate <=: thisWorkOrderSuggestedMaintenanceDate and Id !=: workOrderId Order By SuggestedMaintenanceDate desc limit 1].Id;
        system.debug('##:previousWorkOrderId'+ previousWorkOrderId);
        return previousWorkOrderId;
    }
    
}