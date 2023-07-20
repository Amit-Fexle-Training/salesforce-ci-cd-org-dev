/**
 * 
 * Purpose           : Class to Demostrate Dynamic Ways to deal with or populate Collections in Apex.
 * 
 * Created Date      :     03/16/2023
 * 
 * Created By        :     Amit Kumar
 * 
 * Revision Logs     :     V_1.0 - Created
 * 
**/
public without sharing class DynamicWaysToDealsWithCollections
{
    Map<String, Map<String, List<Student__c>>> mapOfSchoolNameWithClassNameAndRelatedStudentsDetails;
    
    public DynamicWaysToDealsWithCollections() 
    {
        mapOfSchoolNameWithClassNameAndRelatedStudentsDetails = new Map<String, Map<String, List<Student__c>>>();
        
        for(Student__c student : [SELECT ID, Name, Class__c, Class__r.Name, Class__r.School__c, 
                                  Class__r.School__r.Name 
                                  FROM Student__c
                                  WHERE Class__c != null 
                                  	AND Class__r.School__c != null
                                 ]) 
        {
            if(mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.containsKey(student.Class__r.School__r.Name))
            {
                if(mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                   															.containsKey(student.Class__r.Name))
                {
                    mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                        													.get(student.Class__r.Name)
                        														.add(student);
                }
                else
                {
                    mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                        														.put(student.Class__r.Name, new List<Student__c>{ student });
                }
            }
            else
            {
                Map<String, List<Student__c>> mapOfClassNameWithStudents = new Map<String, List<Student__c>>();
                if (mapOfClassNameWithStudents.get(student.Class__r.Name) == null)
                {
                    mapOfClassNameWithStudents.put(student.Class__r.Name, new List <Student__c> ());
                }
                mapOfClassNameWithStudents.get(student.Class__r.Name).add(student);
                
                mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.put(student.Class__r.School__r.Name, mapOfClassNameWithStudents);
            }
        }
        
    }
}