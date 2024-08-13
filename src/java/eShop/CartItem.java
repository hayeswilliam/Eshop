package eShop;
import java.math.BigDecimal;


public class CartItem {
    private final int productId;
    private final String productName;
    private final BigDecimal productPrice;
    private int quantity;

    public CartItem(int productId, String productName, BigDecimal productPrice, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.quantity = quantity;
    }

    // Getters and Setters

    public int getProductId() { return productId; }
    public String getProductName() { return productName; }
    public BigDecimal getProductPrice() { return productPrice; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
