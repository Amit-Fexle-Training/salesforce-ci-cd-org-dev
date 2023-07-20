public without sharing class PracticeClass {
    /**
    Map<String, Map<String, List<String>>> CountriesWithSatesandCities;
    
    public PracticeClass(){
        Map<String, Map<String, List<String>>> CountriesWithSatesandCities = new Map<String, Map<String, List<String>>>{
            'India' => new Map<String, list<String>>{
                'UP' => new List<String>{'Varanasi', 'Lucknow', 'PrayagRaj'},
                    'MP' => new List<String>{'Bhopal', 'Indor', 'Katni'},
                        'Maharastra' => new List<String>{'Nagpur', 'Mumbai', 'Nasik'} 
            },
                'USA' => new Map<String, List<String>>{
                    'NY' => new List<String>{'ABCD', 'EFGH'},
                        'Ohio' => new List<String>{'XYZ', 'RTII'}
                }
        };
    }
    
    public Void print(){
        System.debug(CountriesWithSatesandCities);
    } **/
    
    /** 
        PracticeClass A = new PracticeClass();
        A.print();
     * */
    
    List<List<List<String>>> L = new List<list<List<String>>>{
        new List<List<String>>{
            new List<String>{'A', 'B', 'C'},
                new List<String>{'D', 'E', 'F'}
        },
            new List<List<String>>{
                new List<String>{'X', 'Y', 'Z'},
                    new List<String>{'P', 'Q', 'R'}
            },
              new List<List<String>>{
                new List<String>{'X1', 'Y1', 'Z1'},
                    new List<String>{'P1', 'Q1', 'R1'}
            }  
    };
        
        public Void print(){
            String z = L.tostring();
        System.debug(z);
    }
       

}