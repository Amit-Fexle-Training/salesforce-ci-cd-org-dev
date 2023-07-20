/*
* Purpose : Test Class 2 For SchoolTriggerHelper Apex Class To Test Sharing Rule Method.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/12/2023
* 
* Version : v_0.1 - created 
* 
*/ 
@isTest(seeAllData=false)
public without sharing class SchoolTriggerHelper_Test2 
{
    @isTest(seeAllData=true)
    static void testDoApexSharingCalculations()
    {
        List<School__c> schools = [SELECT ID, No_of_Teacher__c FROM School__c Where Name = 'The Army School'];
        Test.startTest();
        
        schools[0].No_of_Teacher__c = 12;
        
        Test.setMock(HttpCalloutMock.class, new ApexSharingHttpCalloutMock());
        update schools;
        
        List<User> userList = [SELECT Id, Heroku_App_Response__c FROM User WHERE Id = : System.Label.INTEGRATION_USER_RECORD_ID AND isActive = true];
        System.assert(userList[0].Heroku_App_Response__c != null);
        //Methods defined as TestMethod do not support Web service callouts
        
        //schools[1].No_of_Teacher__c = 8;
        //update schools;
        
        
    }
}