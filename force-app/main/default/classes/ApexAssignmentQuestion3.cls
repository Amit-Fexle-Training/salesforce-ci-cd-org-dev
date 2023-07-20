/**
*
*  Purpose          :   Class Containg Solution Code For Apex Assignment Question 3

                        =>Write a code snippet / script / class having method returning 
                        =>Map<String, Map<String, Map<String, String>>> across the system.

                        =>Map 1 Key - Object API Name
                        =>Map 2 Key - Field Label
                        =>Map 3 Key - Field API Name 
                        =>Map 3 Value - Field Data Type

*
*  Created Date     :   04/28/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class ApexAssignmentQuestion3 
{
    public static Map<String, Map<String, Map<String, String>>> getMapOfObjectApiNameRelatedToFieldLabelRelatedToFieldAPINameRelatedToFieldDataType()
    {
        //Defining Map
        Map<String, Map<String, Map<String, String>>> mapOfObjectApiNameRelatedToFieldLabelRelatedToFieldAPINameRelatedToFieldDataType = new Map<String, Map<String, Map<String, String>>>();
        //Query To Get All Standard And Custom Object in Org
        List<EntityDefinition> listOfAllObject = [SELECT DeveloperName, QualifiedApiName FROM EntityDefinition
                                                  WHERE IsCustomizable = true 
                                                  AND IsRetrieveable = true 
                                                  AND IsCustomSetting = false ORDER BY DeveloperName ASC];
        
        //Iterating On Each Object
        for(EntityDefinition ed : listOfAllObject)
        {
            String ObjectApiName = 'Class__c'; //ed.QualifiedApiName;
            //First temprory Map
            Map<String, Map<String, String>> mapOfFieldLabelRelatedToFieldAPINameRelatedToFieldDataType = new Map<String, Map<String, String>>();
            
            //Getting Description Of Object
            Schema.DescribeSObjectResult objDescribe = Utilities.getObjectDescribeOnBasisOfObjectName(ObjectApiName);
            //Checking Object is Custom Or Not
                if(objDescribe.isCustom())
                {
                    //Map To Get fields Detail
                    Map<String, Schema.SObjectField> mapOfFieldApiNameWithFieldDetails = Utilities.getFieldsMap(ObjectApiName);
                    for(String fieldName : mapOfFieldApiNameWithFieldDetails.keyset())
                    {
                        //Seccond temprory Map
                        Map<String, String> mapOfFieldAPINameRelatedToFieldDataType = new Map<String, String>();
                        Schema.DescribeFieldResult fieldDescription = mapOfFieldApiNameWithFieldDetails.get(fieldName).getDescribe();
                        if(fieldDescription.isCustom())
                        {
                            mapOfFieldAPINameRelatedToFieldDataType.put(fieldDescription.getLabel(), String.valueOf(fieldDescription.getType()));
                            mapOfFieldLabelRelatedToFieldAPINameRelatedToFieldDataType.put(fieldDescription.getName(), mapOfFieldAPINameRelatedToFieldDataType);
                        }
                        
                        
                    }
                }
            
            mapOfObjectApiNameRelatedToFieldLabelRelatedToFieldAPINameRelatedToFieldDataType.put(ObjectApiName, mapOfFieldLabelRelatedToFieldAPINameRelatedToFieldDataType);
        }
        
        System.debug(mapOfObjectApiNameRelatedToFieldLabelRelatedToFieldAPINameRelatedToFieldDataType);
        return mapOfObjectApiNameRelatedToFieldLabelRelatedToFieldAPINameRelatedToFieldDataType;
    }
    
}