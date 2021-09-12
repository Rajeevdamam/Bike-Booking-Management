CREATE PROCEDURE insert_order(in p_inventory_id int(2),in p_u_id int(2),in p_ord_price int(12))
BEGIN
INSERT INTO orders(inventory_id, u_id, ord_price) VALUES(p_inventory_id ,p_u_id, p_ord_price)
END;
