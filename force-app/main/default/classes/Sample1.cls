public without sharing class Sample1 {
    List<List<List<String>>> mapofCountrywithstatesandcitiesdetail;
    
    public Sample1(){
        mapofCountrywithstatesandcitiesdetail = new List<List<List<String>>>
        {
             
            new List<List<String>>
            {
                new List<String>{'India'},
                new List<String>{'UP'},
                new List<String>{'Varanasi', 'Lucknow', 'Prayagraj'}
            },
      
            new List<List<String>>
            {
                new List<String>{'USA'},
                new List<String>{'NY'},
                new List<String>{'Abc', 'oow', 'saj'}
            }
        };
            System.debug(mapofCountrywithstatesandcitiesdetail);
  
    }   
    
    public Void print(){
        System.debug(mapofCountrywithstatesandcitiesdetail);
    }
}