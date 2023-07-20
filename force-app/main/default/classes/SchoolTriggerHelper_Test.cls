/*
* Purpose : Test Class For SchoolTriggerHelper Apex Class.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/07/2023
* 
* Version : v_0.1 - created 
* 
*/ 
@isTest(seeAllData = False)
public without sharing class SchoolTriggerHelper_Test 
{
    @testSetup
    public static void setup()
    {
        list<school__c> listOfSchool = new list<school__c>();
        list<class__c> listOfClass = new list<Class__c>();
        list<student__c> listOfStudent = new list<student__c>();
        
        School__c testSchool1 = new school__c(Name = 'Test School 1', About_Us__c = 'New School');
        listOfSchool.add(testSchool1);
        
        School__c testSchool2 = new school__c(Name = 'Test School 2', About_Us__c = 'New School');
        listOfSchool.add(testSchool2);
        
        insert listOfSchool;
        
        class__c testClass1 = new class__c(Name = 'Test Class 1',Board__c = 'CBSE',school__c = listOfSchool[0].Id);
        listOfClass.add(testClass1);
        
        class__c testClass2 = new class__c(Name = 'Test Class 2',Board__c = 'CBSE',school__c = listOfSchool[1].Id);
        listOfClass.add(testClass2);
        
        insert listOfClass;
        
        student__c stu1 = new student__c(Name='Student 1', Type__c = 'Full Time', Class__c = listOfClass[0].id);
        listOfStudent.add(stu1);
        
        student__c stu2 = new student__c(Name='Student 2', Type__c = 'Full Time', Class__c = listOfClass[1].id);
        listOfStudent.add(stu2);
        
        student__c stu3 = new student__c(Name='Student 3', Type__c = 'Full Time', Class__c = listOfClass[1].id);
        listOfStudent.add(stu3);

        insert listOfStudent;
        /*
        // Creating User for Test Class
        List<User> listOfUser = new List<User>();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Analytics Cloud Integration User']; 
        
        User newUser = new User(Alias = 'standt', Email='iu1234@gmail.com', 
            EmailEncodingKey='UTF-8', LastName='Integration User', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='iu1234@gmail.com');
        
        listOfUser.add(newUser);
        
        insert listOfUser;
*/
    }
    
     @isTest(seeAllData=false)
    private static void testPerformValidationLogics() 
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c, About_US__c 
                                   FROM School__c];
        
        for(School__c sc : schools) 
        {
            sc.About_US__c = null;
        }
        
        
        Test.startTest();
        
        	try 
        {
        	update schools;    
        }
        catch(Exception ex) 
        {
            System.assert(ex.getMessage().contains('ABOUT US FIELD IS MISSING'));
        }    
        
        Test.stopTest();
        
    }    
    
    @isTest(seeAllData=false)
    private static void testNoOfClassesDetails()
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c FROM School__c];
        
        Test.startTest();
        
        schools[0].No_of_Classes__c = 10;
        update schools;
        
        schools = [SELECT ID, No_of_Classes__c FROM School__c];
        System.assertEquals(1, schools[0].No_of_Classes__c);
        Test.stopTest();
    }
    
    @isTest(seeAllData=false)
    static void testNoOfStudentDetails()
    {
         List<School__c> schools = [SELECT ID, No_of_Students__c FROM School__c];
        Test.startTest();
        
        schools[0].No_of_Students__c = 5;
        update schools;
        schools = [SELECT ID, No_of_Students__c FROM School__c];
        System.assertEquals(1, schools[0].No_of_Students__c);
        Test.stopTest();
    }
    /*
    @isTest(seeAllData=False)
    static void testDoApexSharingCalculations()
    {
        List<School__c> schools = [SELECT ID, No_of_Teacher__c FROM School__c];
        Test.startTest();
        
        schools[0].No_of_Teacher__c = 12;
        
        Test.setMock(HttpCalloutMock.class, new ApexSharingHttpCalloutMock());
        update schools;
        
        List<User> userList = [SELECT Id, Heroku_App_Response__c FROM User WHERE Id = : System.Label.INTEGRATION_USER_RECORD_ID AND isActive = true];
        System.assert(userList[0].Heroku_App_Response__c != null);
        
        schools[0].No_of_Teacher__c = 8;
        update schools;
        
        List<User> userList2 = [SELECT Id, Heroku_App_Response__c FROM User WHERE Id = : System.Label.INTEGRATION_USER_RECORD_ID AND isActive = true];
        System.assert(userList2[0].Heroku_App_Response__c == null);
        
        Test.stopTest();
        
    }*/
}