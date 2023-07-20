/*
    Purpose         :   Test Class for "StaticWaysToDealsWithCollections" apex class
    Created By      :   Abhinav Sharma
    Created Date    :   04/07/2023
    Revision Log    :   V_1.0 
*/
@isTest(seeAllData=false)
public class StaticWaysToDealsWithCollection_Test
{
    @isTest(seeAllData=false)
    private static void testCases()
    {
        StaticWaysToDealsWithCollection_Test staticCollection = new StaticWaysToDealsWithCollection_Test();
        System.assert(staticCollection != null);
        //System.assert(staticCollection.mapOfCountriesWithStatesAndCitiesDetail.values().size() > 0);
    }
}