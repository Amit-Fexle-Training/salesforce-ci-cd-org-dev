/**
*
*  Purpose          :   Controller class for "GenericObjectDetailsPage" VF Page.
                        Basically it is going to have server side needed code to build custom detail page for object.
*
*  Created Date     :   04/24/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class GenericObjectDetailsPageController 
{
    //Local variables
    Map<String, Schema.SObjectField> mapOfAllFiledsOfSelectedObject;
    
    //Variables used on the VF page
    public List<SelectOption> objectNameOptions {get; set;}
    public String selectedObjectname{get; set;}
    public List<SelectOption> fieldNameOptions {get; set;}
    public String seletedFieldName{ get; set;}
    public List<FieldWrapper> fieldWrappers { get; set; }
    
    public GenericObjectDetailsPageController()
    {
        doInitialization();
        inIt();  
    }
    
    public void doInitialization()
    {
        mapOfAllFiledsOfSelectedObject = new Map<String, Schema.SObjectField>();
        objectNameOptions = new List<SelectOption>();
        selectedObjectname = Constants.CHAR_BLANK;
        fieldNameOptions = new List<SelectOption>();
        seletedFieldName = Constants.CHAR_BLANK;
        fieldWrappers = new List<FieldWrapper>();
    }
    
    public void inIt()
    {
        try
        {
            //Query to get all object from the org
            for(EntityDefinition ed : [SELECT DeveloperName, qualifiedapiname FROM EntityDefinition 
                                       WHERE IsCustomizable = true 
                                       AND IsRetrieveable = true 
                                       AND IsCustomSetting = false ORDER BY DeveloperName ASC])
            {
                objectNameOptions.add(new SelectOption(ed.qualifiedapiname, ed.DeveloperName));
            }
            
        }
        catch(Exception ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
            
        }
    }
    
    public void allFieldsInSelectedObject()
    {
        try
        {
            if(String.isNotBlank(selectedObjectname) && Utilities.getObjectIsAccessible(selectedObjectname))
            {
                //Getting Selected Object Fields on Map
                mapOfAllFiledsOfSelectedObject = Utilities.getFieldsMap(selectedObjectname);
                for(String fieldnames : mapOfAllFiledsOfSelectedObject.keySet())
                {
                    fieldNameOptions.add(new SelectOption(fieldnames,fieldnames));
                }
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Selected Object Is null OR Is Not Accessible'));
            }
        }
        Catch(Exception ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
        }
        
    }
    
    public void selectedFieldDetails()
    {
        try
        {
            if(String.isNotBlank(seletedFieldName) && Utilities.getFieldIsAccessible(selectedObjectname, seletedFieldName))
            {
                Schema.SObjectField fieldDetail = mapOfAllFiledsOfSelectedObject.get(seletedFieldName);
                Schema.DescribeFieldResult fieldResult = fieldDetail.getDescribe();
                
                FieldWrapper fieldWrapper = new FieldWrapper();
                fieldWrapper.Name = fieldResult.getName();
                fieldWrapper.apiName = fieldResult.getName();
                fieldWrapper.label = fieldResult.getLabel();
                //fieldWrapper.required = fieldResult.isRequired() ;
                fieldWrapper.unique = fieldResult.isUnique();
                fieldWrapper.externalId = fieldResult.isExternalId();
                fieldWrapper.dataType = fieldResult.getType().name();
                fieldWrappers.add(fieldWrapper);
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Selected Field Is null OR Is Not Accessible'));
            }
        }
        catch(Exception ex)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    }
    
    public class FieldWrapper {
        public String name { get; set; }
        public String apiName { get; set; }
        public String label { get; set; }
        //public Boolean required { get; set; }
        public Boolean unique { get; set; }
        public Boolean externalId { get; set; }
        public String dataType { get; set; }
    }
}