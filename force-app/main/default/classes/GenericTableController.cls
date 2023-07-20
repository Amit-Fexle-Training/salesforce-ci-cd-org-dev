/*
* 
* Purpose : Apex Class To Have Business Logics Related To "genericTable" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/20/2023
* 
* Version : v_0.1 - created 
* 
*/ 
public with sharing class GenericTableController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper doQuery(String objectName, String fieldsName, Integer limitValue)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            Map<String, String> returnMap = new Map<String,String>();
            if(String.isNotBlank(objectName)) 
            {
                if(String.isNotBlank(fieldsName)) 
                {
                    if(limitValue != null)
                    {
                        SOQLQueryWrapper sOQLQueryWrap = Utilities.buildSOQLQuery(objectName, fieldsName, limitValue, false, 
                                                                                  false, Constants.CHAR_BLANK,
                                                                                  Constants.CHAR_BLANK, Constants.CHAR_BLANK, Constants.CHAR_BLANK
                                                                                 );
                        if(sOQLQueryWrap != null) 
                        {
                            if(String.isNotBlank(sOQLQueryWrap.sOQLQuery)) 
                            {
                                /*if(sOQLQueryWrap.listOfGenericTableHeaderWrapper != null 
                                   && sOQLQueryWrap.listOfGenericTableHeaderWrapper.size() >0) 
                                {
                                    
                                    //prepare a map which will hold fields list and records List and return it
                                    returnMap.put(Constants.CHAR_FIELD_LIST, JSON.serialize(sOQLQueryWrap.listOfGenericTableHeaderWrapper));
                                    returnMap.put(Constants.CHAR_RECORD_LIST, JSON.serialize(Database.query(sOQLQueryWrap.sOQLQuery)));
                                    System.debug('@@@ sOQLQueryWrap.sOQLQuery : ' + sOQLQueryWrap.sOQLQuery);
                                    System.debug('@@@ JSON.serialize(returnMap) : ' + JSON.serialize(returnMap));
                                    return JSON.serialize(returnMap);    
                                }
                                else 
                                {
                                    //Unable to return table header columns
                                    return null;    
                                }*/
                                
                                List<sObject> sObjects = Database.query(sOQLQueryWrap.sOQLQuery);
                                System.debug('@@@ sOQLQueryWrap.sOQLQuery : ' + sOQLQueryWrap.sOQLQuery);
                                System.debug('@@@ sObjects : ' + sObjects);
                                rw.setBody(sObjects);
                                
                            }
                            else 
                            {
                                //Unable to return SOQL Query String
                                rw.setError('Unable to return SOQL Query String');
                            }
                        }
                        else 
                        {
                            //Invalid SOQL Query Object
                            rw.setError('Invalid SOQL Query Object');
                        }
                    }
                    else 
                    {
                        //Please specify the limit value
                        rw.setError('Please specify the limit value');
                    }
                }
                else 
                {
                    //Please specify the fields Name
                    rw.setError('Please specify the fields Name');
                }
            } 
            else 
            {   
                //Please specify the object Name
                rw.setError('Please specify the object Name');
            }
        }
        catch(Exception ex)
        {
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
}