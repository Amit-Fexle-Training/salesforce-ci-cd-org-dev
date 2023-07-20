/**
 * 
 * Purpose           : Class to Demostrate Shoping Cart where User can add Items to cart and can View the Items of Cart.
 * 
 * Created Date      :     03/14/2023
 * 
 * Created By        :     Amit Kumar
 * 
 * Revision Logs     :     V_2.0 - Created
 * 
**/
public without sharing class ShoppingCart2 {
    List <string> ItemName = new list<String>();
    List <Integer> Quantity = new list<Integer>();
    List <Decimal> Price = new list<decimal>();
    
    public void AddToCart(String ItemName1, Integer Quantity1, Decimal Price1)
    {
        ItemName.Add(ItemName1);
        Quantity.Add(Quantity1);
        Price.Add(Price1);
    }
    
    public void ViewCart()
    {
        System.debug('ItemName ' + ItemName + 'Quantity ' + Quantity + 'Price ' + Price );
    }
    

}
/**
ShoppingCart2 Item1 = new ShoppingCart2();
Item1.AddToCart('Potato', 20, 40.00);
Item1.ViewCart();
ShoppingCart2 Item2 = new ShoppingCart2();
Item2.AddToCart('Tomato', 20, 40.00);
Item2.ViewCart();
ShoppingCart2 Item3 = new ShoppingCart2();
Item3.AddToCart('Sugar', 20, 140.00);
Item3.ViewCart();
ShoppingCart2 Item4 = new ShoppingCart2();
Item4.View();
**/

/**
/**
Task : Write an Apex Code To Create a Shopping Cart Using only List and Nested List
*
Created By : Amit Kumar
*
Date : 15/03/2023

List<List<Object>> ShoppingCart = new List<List<Object>>();

// Declaring Items to be added in cart

List<Object> Item1 = new List<Object>{'Apple',65.50,4};
List<Object> Item2 = new List<Object>{'Potato',20.50,3};
List<Object> Item3 = new List<Object>{'Sugar',49.63,10};

// Adding All Items in ShoppingCart List 
    
ShoppingCart.add(Item1);
ShoppingCart.add(Item2);
ShoppingCart.add(Item3);

// Variable to Store Total Amount

Double TotalAmount=0.0;

// Printing All Items Present in Cart

System.debug('Items in Cart are: ');
for(List<Object> s : ShoppingCart){
    System.debug('ItemName ' + s[0] + ' Price ' + s[1] + ' Quantity ' + s[2]);
}

// Calculating Total Amount

for(List<Object> s : ShoppingCart){
    Double Price =(double)s[1];
    Integer Quantity =(integer)s[2];
    TotalAmount += (Price*Quantity);
}

//Printing Total Amount

System.debug('Total Cost of Products in Cart : ' +TotalAmount);
**/