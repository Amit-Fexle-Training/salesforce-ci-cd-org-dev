/**
*
*  Purpose          :   Class to have the logic to update the key counts fields on a school record.
*
*  Created Date     :   03/30/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class CountsManager
{
    public static void updateNoOfStudentsDetails(String schoolName)
    {
        if(String.isNotBlank(schoolName))
        {
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT Id, No_of_Students__c
                                FROM School__c
                                WHERE Name = : schoolName.trim()
                                ])
            {
                mapOfSchools.put(sch.Id, sch);
            }
            if(mapOfSchools.values() != null && mapOfSchools.values().size() > 0)
            {
                CountsManager.doCalculationForNoOfStudents(mapOfSchools);
            }
            else
            {
                System.debug('UNABLE TO FIND SCHOOL BY NAME');
            }
        }
        else
        {
            System.debug('SCHOOL NAME DETAILS IS MISSING');
        }
    }
    
    public static void doCalculationForNoOfStudents(Map<Id, School__c> mapOfSchools)
    {
        if(mapOfSchools.values() != null && mapOfSchools.values().size() > 0)
        {
            Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCount = new Map<Id, Integer>();
            for(Id schoolId : mapOfSchools.keySet())
            {
                mapOfSchoolIdWithNoOfStudentsCount.put(schoolId, 0);
            }
            
            for(Student__c student : [SELECT ID, Class__r.School__c
                                      FROM Student__c
                                      WHERE Class__c != null
                                      AND Class__r.School__c != null
                                      AND Class__r.School__c IN : mapOfSchools.keySet()
                                     ]) 
            {
                if(mapOfSchoolIdWithNoOfStudentsCount.containsKey(student.Class__r.School__c))
                {
                     mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, (mapOfSchoolIdWithNoOfStudentsCount.get(student.Class__r.School__c) + 1));
                }
                else
                {
                    mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, 1);
                }
            }
            
            if(mapOfSchoolIdWithNoOfStudentsCount.values() != null && mapOfSchoolIdWithNoOfStudentsCount.values().size() > 0)
            {
                List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
                for(School__c school : mapOfSchools.values())
                {
                    School__c sch = mapOfSchools.get(school.Id);
                    
                    if(mapOfSchoolIdWithNoOfStudentsCount.containsKey(school.Id))
                    {
                        school.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCount.get(school.Id);
                    }
                    else
                    {
                        school.No_of_Students__c = 0;
                    }
                    listOfSchoolsToBeUpated.add(school);
                }
                if(listOfSchoolsToBeUpated.size()>0)
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfSchoolsToBeUpated;
                    Utilities.BypassAllTriggers = false;
                }
            }
        }
    }
    
    public static void updateNoOfClassesDetails(Id schoolId) 
    {
        if(schoolId != null) 
        {
            CountsManager.updateNoOfClassesDetails(new Set<Id> {schoolId});
        }
        else 
        {
            System.debug('SCHOOL ID DETAILS MISSING');    
        }        
    }
    
    public static void updateNoOfClassesDetails(Set<Id> schoolIds) 
    {
        if(schoolIds.size() > 0) 
        {
            List<School__c> schools = [SELECT Id, Name, 
                                       (SELECT ID FROM Classes__r) 
                                       FROM School__c
                                       WHERE Id IN : schoolIds
                                      ];
            
            if(schools.size() > 0) 
            {
                for (School__c sch : schools) 
                {
                    sch.No_of_Classes__c = sch.Classes__r.size();
                }
                Utilities.BypassAllTriggers = true;
                update schools;
                Utilities.BypassAllTriggers = false;
            }
            else
            {
                System.debug('UNABLE TO FIND SCHOOL BY ID');        
            }    
        }
    }
    
    public static void updateNoOfClassesDetails2(Id schoolId)
    {
       if(schoolId != null) 
        {
            List<School__c> schools = [SELECT Id
                                       FROM School__c
                                       WHERE Id =: schoolId
                                      ];
            if(schools.size() > 0) 
            {
                CountsManager.updateNoOfClassesDetails2(new Set<Id>{schoolId});    
            }
            else 
            {
                System.debug('UNABLE TO FIND SCHOOL BY ID');        
            }
        }
        else 
        {
            System.debug('SCHOOL ID DETAILS MISSING');    
        } 
    }
    
    public static void updateNoOfClassesDetails2(Set<Id> schoolIds)
    {
        Map<Id, Integer> mapOfSchoolIdWithClassesCount = new Map<Id, Integer>();
        for (AggregateResult aggRes : [SELECT COUNT(ID) numOfClasses, School__c schoolId
                                           FROM Class__c
                                           WHERE School__c IN : schoolIds
                                           GROUP BY School__c
                                          ]
                )
        {
            Id schoolRecordId = (Id) aggRes.get('schoolId');
            Integer numberOfAssociatedClasses = (Integer) aggRes.get('numOfClasses');
            mapOfSchoolIdWithClassesCount.put(schoolRecordId, numberOfAssociatedClasses);
        }
        if(mapOfSchoolIdWithClassesCount.values() != null && mapOfSchoolIdWithClassesCount.values().size() > 0)
        {
            List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
            for(Id scId : mapOfSchoolIdWithClassesCount.keySet())
            {
                School__c scRec = new School__c();
                scRec.Id = scId;
                scRec.No_of_Classes__c = mapOfSchoolIdWithClassesCount.get(scId);
                listOfSchoolsToBeUpated.add(scRec);
            }
            if(listOfSchoolsToBeUpated.size() > 0) 
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfSchoolsToBeUpated;
                    Utilities.BypassAllTriggers = false;
                }
        }
        else
        {
            Integer i=0;
            List<Id> listOfRecordsIds = new List<Id>();
            listOfRecordsIds.addAll(schoolIds);
            
            School__c scRecord = new School__c();
            scRecord.Id = listOfRecordsIds[i]; 
            scRecord.No_of_Classes__c = 0;
            
            Utilities.BypassAllTriggers = true;
            update scRecord;
            Utilities.BypassAllTriggers = false;
        }
    }
}