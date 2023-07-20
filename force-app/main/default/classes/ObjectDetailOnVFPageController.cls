/**
*
*  Purpose          :   Controller class for "ObjectDetailOnVFPage" VF Page.
                        Basically it is going to have server side needed code to build custom detail page for object.
*
*  Created Date     :   04/26/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class ObjectDetailOnVFPageController 
{
    //Variables used on the VF page
    public String enteredObjectName {get; set;}
    public List<String> listOffields { get; set;}
    public List<SelectOption> fieldNameOptions {get; set;}
    
    public ObjectDetailOnVFPageController()
    {
        doInitialization();
    }
    
    public void doInitialization()
    {
        enteredObjectName = Constants.CHAR_BLANK;
        listOffields = new List<String>();
        fieldNameOptions = new List<SelectOption>();
    }
    
    public void getFieldsOfEnteredObject()
    {
        try
        {
            if(String.isNotBlank(enteredObjectName) && Utilities.getObjectIsAccessible(enteredObjectName))
            {
                //System.debug(enteredObjectName);
                Map<String, Schema.SObjectField> mapOfFieldToFieldDetails = Utilities.getFieldsMap(enteredObjectName);
                for (String fieldName : mapOfFieldToFieldDetails.keySet()) 
                {
                    listOffields.add(fieldName);
                    fieldNameOptions.add(new SelectOption(fieldName,fieldName));
                    //System.debug(fieldName);
                }
                //System.debug('listOffields : '+ listOffields + ' ' + 'listOffields : ' + listOffields);
            }
            else
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Object Name Not Found, Please Enter Valid Object Name'));
            }
            
        }
        catch(Exception ex)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
        }
    }
    
}