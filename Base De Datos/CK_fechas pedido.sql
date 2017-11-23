ALTER TABLE pedidos 
   add CONSTRAINT CK_FechasPedido  
   CHECK (fechaEntrega>=FechaPedido);  
