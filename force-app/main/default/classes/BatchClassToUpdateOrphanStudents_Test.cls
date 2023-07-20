/*
* Purpose : Test Class For BatchClassToUpdateOrphanStudents Apex Class.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/10/2023
* 
* Version : v_0.1 - created 
* 
*/ 
@isTest(seeAllData=false)
public without sharing class BatchClassToUpdateOrphanStudents_Test 
{
    @testSetup
    public static void setup()
    {
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer i = 1; i<=5; i++)
        {
            Student__c std = new Student__c(Name = 'Student '+i);
            listOfStudents.add(std);
        }
        insert listOfStudents;
    }
    
    @isTest(seeAllData=false)
    public static void testBatchClassToUpdateOrphanStudents()
    {         
        Test.startTest();
        
        BatchClassToUpdateOrphanStudents bc = new BatchClassToUpdateOrphanStudents('SELECT Name, Id, Class__c, Test_T_D__c FROM Student__c WHERE Class__c = null');
        Database.executeBatch(bc, 5);
        
        Test.stopTest();
        
        List<Student__c> listOfStudentsWithPopulatedTest_T_DField = [SELECT Name, Id, Class__c, Test_T_D__c FROM Student__c WHERE Test_T_D__c != null];
        System.assertEquals(3, listOfStudentsWithPopulatedTest_T_DField.size());
        
        List<Student__c> listOfStudentsWithNullTest_T_DField = [SELECT Name, Id, Class__c, Test_T_D__c FROM Student__c WHERE Test_T_D__c = null];
        System.assertEquals(2, listOfStudentsWithNullTest_T_DField.size());
    }
}