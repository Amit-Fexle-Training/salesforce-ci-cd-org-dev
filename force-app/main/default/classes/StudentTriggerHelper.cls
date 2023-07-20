/**
*
*  Purpose          :	Helper Class for Trigger on Student object.
*
*  Created Date     :  	04/07/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class StudentTriggerHelper 
{
    public static void updateNoOfStudentsDetails(List<Student__c> students, Map<Id, Student__c> mapOfOldStudents) 
    {
        Set<Id> setOfParentClasses = new Set<Id>();
        for(Student__c std : students != null ? students : mapOfOldStudents.values()) 
        {
            if(students != null && mapOfOldStudents != null && mapOfOldStudents.values().size() > 0) 
            {
                if(mapOfOldStudents.get(std.Id) != null && std.Class__c != mapOfOldStudents.get(std.Id).Class__c) 
                {
                    if(std.Class__c != null) 
                    {
                        setOfParentClasses.add(std.Class__c);
                    }
                    
                    if(mapOfOldStudents.get(std.Id) != null) 
                    {
                        if(mapOfOldStudents.get(std.Id).Class__c != null) 
                        {
                            setOfParentClasses.add(mapOfOldStudents.get(std.Id).Class__c);    
                        }
                    }        
                }
            }
            else 
            {
                if(std.Class__c != null) 
            	{
                	setOfParentClasses.add(std.Class__c);
                }    
            }
        }
        if(setOfParentClasses.size() > 0) 
        {
            Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCount = new Map<Id, Integer>();
            for(Class__c cls : [SELECT ID, School__c 
                                FROM Class__c
                                WHERE ID IN : setOfParentClasses
                                AND School__c != null
                               ]) 
            {
                mapOfSchoolIdWithNoOfStudentsCount.put(cls.School__c, 0);
            }
            if(mapOfSchoolIdWithNoOfStudentsCount.values().size() > 0) 
            {
                for(Student__c student : [SELECT ID, Class__r.School__c
                                          FROM Student__c
                                          WHERE Class__c != null
                                          AND Class__r.School__c != null
                                          AND Class__r.School__c IN : mapOfSchoolIdWithNoOfStudentsCount.keySet()
                                         ]) 
                {
                    if(mapOfSchoolIdWithNoOfStudentsCount.containsKey(student.Class__r.School__c)) 
                    {
                        mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, 
                                                               (mapOfSchoolIdWithNoOfStudentsCount.get(student.Class__r.School__c) + 1));
                    }
                    else 
                    {
                             mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, 1);                   
                    }
                }
                List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
                for(Id schId : mapOfSchoolIdWithNoOfStudentsCount.keyset()) 
                {
                    School__c sc = new School__c(Id = schId);
                    sc.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCount.get(schId);
                    listOfSchoolsToBeUpated.add(sc);
                }
                if(listOfSchoolsToBeUpated.size() > 0) 
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfSchoolsToBeUpated;
                    Utilities.BypassAllTriggers = false;
                }
            }    
        }
    }
}