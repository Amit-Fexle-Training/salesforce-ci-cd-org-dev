/**
 * 
 * Purpose           : Class to Demostrate Static Ways to deal with or populate Collections in Apex.
 * 
 * Created Date      :     03/13/2023
 * 
 * Created By        :     Amit Kumar
 * 
 * Revision Logs     :     V_1.0 - Created
 * 
**/
public without sharing class StaticWaysToDealsWithCollection {
    
    // Map to have States and their Cities Details With Respect to respective Countries.
    Map<String, Map<String, List<String>>> mapOfCountriesWithStatesAndCitiesDetail;
    
    // Constructor 
    public StaticWaysToDealsWithCollection()
    {
        mapOfCountriesWithStatesAndCitiesDetail = new Map<String, Map<String, List<String>>>
        {
            'India' => 
                new Map<String, List<String>>
            {
                'Uttar Pradesh' => new List<String> {'Lucknow', 'Varanasi', 'PrayagRaj'},
                'Madhya Pradesh' => new List<String> {'Bhopal', 'Indor', 'Jabalpur'},
                'Tamil Nadu' => new List<String> {'Chenni', 'Rameshwaram', 'Koyambatur'}
            },
              'USA' =>
                new Map<String, List<String>>
            {
                'Taxas' => new List<String> {'Dallas', 'Austin'},
                    'NC' => new List<String> {'Charlotte', 'Rayleigh'}
            }
        };
   
    }

}