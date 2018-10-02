<aura:application access="GLOBAL" extends="ltng:outApp"> 
    <aura:dependency resource="c:PrintableView_WorkOrder_Bulk"/>
    <aura:dependency resource="c:RMA_Fields"/>
    <aura:dependency resource="c:RMA_FieldSet"/>
    <aura:dependency resource="c:RMA_RelatedList"/>
    <aura:dependency resource="c:RMA_FieldChangeEvent"/>
    <aura:dependency resource="c:RMA_FieldSetSaveEvent"/>
    <aura:dependency resource="c:RMA_FieldSetCancelEvent"/>
    <aura:dependency resource="c:RMA_CallbackErrorEvent"/>
    <aura:dependency resource="c:RMA_ErrorHandler"/>
    <aura:dependency resource="c:RMA_DataTable"/>
    <aura:dependency resource="c:RMA_SingleFieldDisplayer"/>
    <aura:dependency resource="c:RMA_SingleFieldDisplayerReadOnly"/>
</aura:application>