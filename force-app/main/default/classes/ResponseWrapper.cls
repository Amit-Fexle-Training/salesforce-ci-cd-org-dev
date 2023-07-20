/*
* 
* Purpose : Apex Wrapper Class To Store Object and Error Message to Show on LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/23/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class ResponseWrapper
{
    @AuraEnabled public string msg;
    @AuraEnabled public string message;
    @AuraEnabled public Boolean isSuccess;
    @AuraEnabled public object body;
    @AuraEnabled public List<String> getList;
    @AuraEnabled public List<sObject> recordList;
    //@AuraEnabled public String type;
    public void setError(String errorMsg)
    {
        this.isSuccess = false;
        this.msg = errorMsg;
        this.body = null;
    }
    public void setMessage(String Message)
    {
        this.message = message;
        this.isSuccess = true;
    }
    public void setBody(Object body)
    {
        this.body = body;
        this.isSuccess = true;
    }
    public void setRecordList(List<sObject> recordList)
    {
        this.recordList = recordList;
        this.isSuccess = true;
    }
    public void setList(List<String> getList)
    {
        this.getList = getList;
        this.isSuccess = true;
    }
    public ResponseWrapper()
    {
        this.isSuccess = true;
    }
    
}