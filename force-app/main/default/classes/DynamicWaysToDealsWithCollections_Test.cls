/*
* Purpose : Test Class For DynamicWaysToDealsWithCollections Apex Class.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/07/2023
* 
* Version : v_0.1 - created 
* 
*/ 
@isTest(seeAllData = False)
public without sharing class DynamicWaysToDealsWithCollections_Test
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
        
        class__c testClass1 = new class__c(Name = 'Test Class 1',Board__c = 'CBSE',school__c = testSchool1.Id);
        listOfClass.add(testClass1);
        
        class__c testClass2 = new class__c(Name = 'Test Class 2',Board__c = 'CBSE',school__c = testSchool2.Id);
        listOfClass.add(testClass2);
        
        insert listOfClass;
        
        student__c stu1 = new student__c(Name='Student 1', Type__c = 'Full Time', Class__c = testClass1.id);
        listOfStudent.add(stu1);
        
        student__c stu2 = new student__c(Name='Student 2', Type__c = 'Full Time', Class__c = testClass2.id);
        listOfStudent.add(stu2);
        
        student__c stu3 = new student__c(Name='Student 3', Type__c = 'Full Time', Class__c = testClass2.id);
        listOfStudent.add(stu3);

        insert listOfStudent;
    }
    
    @isTest(seeAllData = False)
    private static void testDynamicCollection()
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        
        DynamicWaysToDealsWithCollections dyn = new DynamicWaysToDealsWithCollections();
        System.assert(dyn != null);
    }
}