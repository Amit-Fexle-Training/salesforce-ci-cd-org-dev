/**
*
*  Purpose          :	Helper Class for Trigger on School object.
*
*  Created Date     :  	04/06/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class SchoolTriggerHelper 
{
    
    public static void performValidationLogics(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        for(School__c sch : schools)
        {
            if(String.isBlank(sch.About_US__c))
            {
                sch.addError('ABOUT US FIELD IS MISSING');
            }
        }
    }
    
    public static void updateNoOfStudentsDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        //Map that will hold the school record Id as a key and recalculated no of students counts as value
        Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCounts = new Map<Id, Integer>();
        
        for(School__c sch : schools)
        {
            if(sch.No_of_Students__c != mapOfOldSchools.get(sch.Id).No_of_Students__c)
            {
                mapOfSchoolIdWithNoOfStudentsCounts.put(sch.Id, 0);
            }
        }
        if(mapOfSchoolIdWithNoOfStudentsCounts.values().size() > 0)
        {
            for(Student__c student : [SELECT Id, Class__r.School__c
                                     FROM Student__c
                                     WHERE Class__c != null AND Class__r.School__c != null
                                     AND Class__r.School__c IN : mapOfSchoolIdWithNoOfStudentsCounts.keySet()
                                     ])
            {
                if(mapOfSchoolIdWithNoOfStudentsCounts.containsKey(student.Class__r.School__c))
                {
                    mapOfSchoolIdWithNoOfStudentsCounts.put(student.Class__r.School__c, (mapOfSchoolIdWithNoOfStudentsCounts.get(student.Class__r.School__c) + 1));
                }
                else
                {
                    mapOfSchoolIdWithNoOfStudentsCounts.put(student.Class__r.School__c, 1);
                }
            }
            for(School__c sch : schools)
            {
                if(mapOfSchoolIdWithNoOfStudentsCounts.get(sch.Id) != null)
                {
                    sch.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCounts.get(sch.Id);
                }
            }
        }
    }
    
    public static void updateNoOfClassesDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        Map<Id, Integer> mapOfSchoolIdWithNoOfClassesCounts = new Map<Id, Integer>();
        for(School__c sch : schools)
        {
            if(mapOfOldSchools != null && sch.No_of_Classes__c != mapOfOldSchools.get(sch.Id).No_of_Classes__c)
            {
                mapOfSchoolIdWithNoOfClassesCounts.put(sch.Id, 0);
            }
        }
        
        if(mapOfSchoolIdWithNoOfClassesCounts.values().size()>0)
        {
            for(Class__c cls : [SELECT Id, School__c 
                               FROM Class__c
                               WHERE School__c != null
                               AND School__c IN :mapOfSchoolIdWithNoOfClassesCounts.keyset()
                               ])
            {
                if(mapOfSchoolIdWithNoOfClassesCounts.containsKey(cls.School__c))
                {
                    mapOfSchoolIdWithNoOfClassesCounts.put(cls.School__c, (mapOfSchoolIdWithNoOfClassesCounts.get(cls.School__c) + 1));
                }
                else
                {
                    mapOfSchoolIdWithNoOfClassesCounts.put(cls.School__c, 1);
                }
            }
            for(School__c sch : schools)
            {
                if(mapOfSchoolIdWithNoOfClassesCounts.get(sch.Id) != null)
                {
                    sch.No_of_Classes__c = mapOfSchoolIdWithNoOfClassesCounts.get(sch.Id);
                }
            }
        }
    }
    
    /*
    public static void updateNoOfStudentsDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            if(mapOfOldSchools != null && sc.No_of_Students__c != mapOfOldSchools.get(sc.Id).No_of_Students__c)
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }
        if(setOfEligibleSchools.size() > 0)
        {
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT ID, No_of_Students__c 
                                 FROM School__c
                                 WHERE ID IN : setOfEligibleSchools
                                ])
            {
                mapOfSchools.put(sch.Id, sch);
            }
            if(mapOfSchools.values().size() > 0)
            {
                CountsManager.doCalculationForNoOfStudents(mapOfSchools);
            }
        }
    }
    
    public static void updateNoOfClassesDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            if(mapOfOldSchools != null && sc.No_of_Classes__c  != mapOfOldSchools.get(sc.Id).No_of_Classes__c )
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }
        if(setOfEligibleSchools.size() > 0)
        {
            List<School__c> listOfSchoolsToBeUpdated = [SELECT ID, No_of_Classes__c,
                                                        (SELECT ID FROM Classes__r) 
                                                        FROM School__c
                                                        WHERE ID IN : setOfEligibleSchools
                                                       ];
            if(listOfSchoolsToBeUpdated.size() > 0) 
            {
                for(School__c sch : listOfSchoolsToBeUpdated) 
                {
                    sch.No_of_Classes__c = sch.Classes__r.size();
                }
                Utilities.BypassAllTriggers = true;
                update listOfSchoolsToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
            
        }
    } 
      */
    
    public static void doApexSharingCalculations(List<School__c> schools, Map<Id, School__c> mapOfOldSchools)
    {
        Set<Id> setOfEligibleSchoolsForSharingAddition = new Set<Id>();
        Set<Id> setOfEligibleSchoolsForSharingDeletion = new Set<Id>();
        Boolean isAnyRelaventChangesHappens = false;
        
        for(School__c sch : schools)
        {
            if(mapOfOldSchools != null)
            {
                if(System.isBAtch() || 	(sch.No_of_Teacher__c != mapOfOldSchools.get(sch.Id).No_of_Teacher__c))
                {
                    if(sch.No_of_Teacher__c != null)
                    {
                        if(sch.No_of_Teacher__c > Integer.valueOf(System.label.NO_OF_TEACHERS_THRESHOLD_FOR_SHARING_RECALCULATION))
                        {
                            setOfEligibleSchoolsForSharingAddition.add(sch.Id);
                        }
                        else
                        {
                         setOfEligibleSchoolsForSharingDeletion.add(sch.Id);   
                        }
                    }
                    else
                    {
                        setOfEligibleSchoolsForSharingDeletion.add(sch.Id);
                    }
                    isAnyRelaventChangesHappens = true;
                }
            }
        }
        
        List<User> integerationUserDetails = new List<User>();
        if(isAnyRelaventChangesHappens)
        {
            if(setOfEligibleSchoolsForSharingAddition.size() > 0 || setOfEligibleSchoolsForSharingDeletion.size() > 0)
            {
                integerationUserDetails = [SELECT Id FROM User WHERE Id = : System.Label.INTEGRATION_USER_RECORD_ID AND isActive = true];
            }
            
            if(integerationUserDetails.size()>0)
            {
                List<School__Share> listOfManagedSharingRecordsToBeInserted = new List<School__Share>();
                if(setOfEligibleSchoolsForSharingAddition.size()>0)
                {
                    for(Id schId : setOfEligibleSchoolsForSharingAddition)
                    {
                        School__Share schoolShare = new School__Share();
                        schoolShare.ParentId = schId;
                        schoolShare.UserOrGroupId = integerationUserDetails[0].Id;
                        schoolShare.AccessLevel = Constants.SHARING_ACCESS_TYPE_READ;
                        schoolShare.RowCause = Schema.School__Share.RowCause.Apex_Sharing__c;
                        listOfManagedSharingRecordsToBeInserted.add(schoolShare);
                    }
                    if(listOfManagedSharingRecordsToBeInserted.size() > 0)
                    {
                        Utilities.BypassAllTriggers = true;
                        insert listOfManagedSharingRecordsToBeInserted;   
                        Utilities.BypassAllTriggers = false;
                        
                        //HerokuAppIntegration Via future method
                        //HerokuAppIntegrationManager.makeCalloutToHerokuAndUpdateUsers(setOfEligibleSchoolsForSharingAddition);
                        
                        //HerokuAppIntegration Via Batch Apex
                        //BatchHerokuAppIntegrationManager bc = new BatchHerokuAppIntegrationManager(setOfEligibleSchoolsForSharingAddition);
                        //Database.executeBatch(bc, 200);
                        
                        //enqueue the Queueable job for processing
                    	Queueable_UpdateUserWithHerokuAppDetails queueableJob = new Queueable_UpdateUserWithHerokuAppDetails(setOfEligibleSchoolsForSharingAddition);
                        ID jobID = System.enqueueJob(queueableJob);
                    }
                }
                
                 if(setOfEligibleSchoolsForSharingDeletion.size() > 0)
                 {
                     List<School__Share> listOfManagedSharingRecordsToBeDeleted = [SELECT Id, ParentId, RowCause, UserOrGroupId 
                                                                                  FROM School__share 
                                                                                  WHERE ParentId IN: setOfEligibleSchoolsForSharingDeletion 
                                                                                  AND RowCause =: Constants.SHARING_REASON_APEX_SHARING];
                     if(listOfManagedSharingRecordsToBeDeleted.size() > 0)
                     {
                         Utilities.BypassAllTriggers = true;
                         delete listOfManagedSharingRecordsToBeDeleted;
                         Utilities.BypassAllTriggers = false;
                     }
                     
                     List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c 
                                                         FROM User 
                                                         WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                                         AND IsActive = true
                                                        ];
                     if(integrationUserDetails.size() > 0)
                     {
                         integrationUserDetails[0].Heroku_App_Response__c = null;
                         
                          Utilities.BypassAllTriggers = true;
                          update integrationUserDetails;   
                          Utilities.BypassAllTriggers = false;
                     }
                 }
            }
            else
            {
                schools[0].addError(System.Label.ERROR_INTEGRATION_USER_IS_DEACTIVATED);
            }
        }
    }
}