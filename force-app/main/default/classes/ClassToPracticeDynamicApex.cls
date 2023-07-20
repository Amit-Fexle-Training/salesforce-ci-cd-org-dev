/**
*
*  Purpose          :   Apex Class to have the utilities methods.
*
*  Created Date     :   04/27/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class ClassToPracticeDynamicApex 
{
    //Method To Return Map Of Object API Name Related TO Object Label
    public static Map<String, String> mapOfAllObjectApiNameToObjectLabel()
    {
        List<EntityDefinition> listOfAllObject = [SELECT DeveloperName, QualifiedApiName FROM EntityDefinition
                                                  WHERE IsCustomizable = true 
                                                  AND IsRetrieveable = true 
                                                  AND IsCustomSetting = false ORDER BY DeveloperName ASC];
        Map<String, String> mapOFObectApiNameToObjectLabel = new map<String, String>();
        for(EntityDefinition ed : listOfAllObject)
        {
            mapOFObectApiNameToObjectLabel.put(ed.QualifiedApiName, ed.DeveloperName);
        }
        return mapOFObectApiNameToObjectLabel;
    }
    
    //Method To Return List Of Fields Of Using Object Name
    public static List<String> listOfAllFieldsOfObject(String objectName)
    {
        if(objectName != null && String.isNotEmpty(objectName)
          && Type.forName(objectName) != null 
          && ((sObject) Type.forName(objectName).newInstance()) != null)
        {
            Schema.DescribeSObjectResult objDescribe = ((sObject) Type.ForName(ObjectName).newInstance()).getSObjectType().getDescribe();
            if(objDescribe != null)
            {
                Map<String, Schema.SObjectField> mapOfobjectFieldWithFielddetail =  objDescribe.fields.getMap();
                List<String> listOfFields = new List<String>();
                for(String fieldName : mapOfobjectFieldWithFielddetail.keySet())
                {
                    listOfFields.add(fieldName);
                }
                
                return listOfFields;
            }
            else
            {
                return null;
            }
        }
        
            return null; 
    }
    
    public static String queryToGetAllAccessibleFieldOfObject(String objectName)
    {
        if(String.isNotBlank(objectName))
        {
            String query='SELECT ';
            List<String> listOfAllFieldsOfObject = ClassToPracticeDynamicApex.listOfAllFieldsOfObject(objectName);
            if(listOfAllFieldsOfObject.size() > 0)
            {
                for(String fieldName : listOfAllFieldsOfObject)
                {
                    if(Utilities.getFieldIsAccessible(objectName, fieldName))
                    {
                        query += fieldName+',';
                    }
                }
            }
            else
            {
                return null;
            }
            
            query = query.removeEnd(',') + 'FROM ' + objectName;
            
            return query;
        }
        else
        {
            return null;
        }
    }
    
    //Method To Get Map Of Picklist Values Related With PickList Label 
    public static Map<String, String> getValuesOfPickListField(String objectName, String fieldName)
    {
        if(String.isNotBlank(objectName) && String.isNotBlank(fieldName) && Utilities.getObjectIsAccessible(objectName) && Utilities.getFieldIsAccessible(objectName, fieldName))
            {
                Map<String, String> mapOFPickListfieldNameWithItsValue = new Map<String, String>();
                Schema.DescribeFieldResult fieldResult = Utilities.getFieldsMap(objectName).get(fieldName).getDescribe();
                
                if((fieldResult!=null) && (fieldResult.getType() == Schema.DisplayType.Picklist)) 
                {
                    List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
                    for(Schema.PicklistEntry picklistEntry : picklistEntries)
                    {
                        if(picklistEntry.isActive())
                        {
                            mapOFPickListfieldNameWithItsValue.put(picklistEntry.getLabel(), picklistEntry.getValue());
                        }
                    }
                    return mapOFPickListfieldNameWithItsValue;
                }
                else
                {
                    return null;
                }
            }
        
            return null; 
    }
    
    public static Map<Id, String> mapOfRecordTypeIdWithRecordTypeNameOfGivenObject(String objectName)
    {
        if(String.isNotBlank(objectName) && Utilities.getObjectIsAccessible(objectName))
        {
            Map<Id, String> mapOfRecordTypeIdWithRecordTypeName = new Map<Id, String>();
            String objectApiName = Utilities.getSobjectAPIName(Utilities.getObjectTypeOnBasisOfObjectName(objectName));
                if(String.isNotBlank(objectApiName))
                {
                    Schema.DescribeSObjectResult objectResult = Utilities.getObjectDescribeOnBasisOfObjectName(objectApiName);
                    
                    if(objectResult != null)
                    {
                        List<Schema.RecordTypeInfo> recordTypeInfos = objectResult.getRecordTypeInfos();
                        
                        for(Schema.RecordTypeInfo recordTypeInfo : recordTypeInfos)
                        {
                            if(recordTypeInfo.isActive() && recordTypeInfo.isAvailable())
                            {
                                mapOfRecordTypeIdWithRecordTypeName.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo.getName());
                            }
                        }
                        return mapOfRecordTypeIdWithRecordTypeName;
                    }
                    else
                    {
                        return null;
                    }
                }
        }
        return null;
    }
}