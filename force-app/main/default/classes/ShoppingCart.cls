/**
 * 
 * Purpose           : Class to Demostrate Shoping Cart where User can add Items to cart and can View the Items of Cart.
 * 
 * Created Date      :     03/14/2023
 * 
 * Created By        :     Amit Kumar
 * 
 * Revision Logs     :     V_1.0 - Created
 * 
**/
public without sharing class ShoppingCart {
    String ItemName;
    Integer Quantity;
    Decimal Price;
    Decimal TotalAmount=0.0;
    
    public void AddToCart(String ItemName1, Integer Quantity1, Decimal Price1)
    {
        ItemName = ItemName1;
        Quantity = Quantity1;
        Price = Price1;
        TotalAmount += (Price * Quantity);
    }
    
    public void ViewCart()
    {
        System.debug('ItemName ' +ItemName );
        System.debug('Quantity ' +Quantity);
        System.debug('Price '+Price);
        System.debug('TotalAmount '+TotalAmount);
    }

}
/**
ShoppingCart Item1 = new ShoppingCart();
Item1.AddToCart('Potato', 20, 5.00);
ShoppingCart Item2 = new ShoppingCart();
Item2.AddToCart('Potato2', 20, 5.00);
ShoppingCart Item3 = new ShoppingCart();
Item3.AddToCart('Potato3', 20, 5.00);

List <ShoppingCart> Items = new List<ShoppingCart>();
Items.Add(Item1);
Items.Add(Item2);
Items.Add(Item3);

system.debug(Items);

**/