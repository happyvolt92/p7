-- Create a trigger to update ingredient quantities when an order is placed
DELIMITER //
CREATE TRIGGER update_ingredient_quantity AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  DECLARE shopping_cart_id INT;
  DECLARE pizza_id INT;
  DECLARE ingredient_id INT;
  DECLARE ingredient_quantity INT;
  DECLARE order_quantity INT;

  -- Retrieve the shopping cart ID from the inserted order
  SELECT idCart INTO shopping_cart_id FROM orders WHERE idOrder = NEW.idOrder;

  -- Retrieve the pizza ID from the shopping cart
  SELECT idPizza INTO pizza_id FROM shopping_cart_pizza WHERE idCart = shopping_cart_id;

  -- Retrieve the ingredient ID and order quantity from the pizza's recipe
  SELECT idIngredient, Quantity INTO ingredient_id, order_quantity
  FROM recipe_ingredient
  WHERE idRecipe = (SELECT idRecipe FROM pizza WHERE idPizza = pizza_id);

  -- Calculate the updated ingredient quantity
  SET ingredient_quantity = (SELECT Quantity FROM ingredients WHERE idIngredient = ingredient_id) - order_quantity;

  -- Update the ingredient quantity in the ingredients table
  UPDATE ingredients SET Quantity = ingredient_quantity WHERE idIngredient = ingredient_id;
END//
DELIMITER ;
