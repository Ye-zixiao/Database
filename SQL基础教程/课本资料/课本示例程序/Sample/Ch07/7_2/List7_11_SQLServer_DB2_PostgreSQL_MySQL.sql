SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
  FROM ShopProduct AS SP RIGHT OUTER JOIN Product AS P
    ON SP.product_id = P.product_id;

    --一个疑问：在以这个select子句创建视图后，会发现视图中并没有像直接使用这个select语句一样的问题。。。？
    --同时，将外联结中的right关键字改成left之后也并没有这个问题