import java.math.BigDecimal;

public class Product {
    private int id;
    private String name;
    private BigDecimal price;
    private String imageName;

   
    public Product() {
    }

    
    public Product(int id, String name, BigDecimal price, String imageName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageName = imageName;
    }

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", imageName=" + imageName + "]";
    }
}
