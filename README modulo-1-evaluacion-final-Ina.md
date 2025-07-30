# Sistema de Gestión de Ventas para Pastelería O Pazo

Este proyecto implementa un sistema para gestionar las ventas de la Pastelería O Pazo, con funcionalidades para la gestión de inventario, compras y clientes.

## Funcionalidades

El sistema ofrece las siguientes funcionalidades:

* **Gestión de Inventario:**

    * Añadir productos.
    * Mostrar inventario.
    * Buscar productos.
    * Actualizar stock.
    * Eliminar productos.
    * Calcular valor del inventario.

* **Gestión de Compras:**
    * Realizar compras.

* **Gestión de Clientes:**

    * Registrar clientes.
    * Mostrar lista de clientes.
    * Registrar compra para cliente.

* **Gestión de Pagos:**

    * Procesar pago.

## Estructura del Código

El código se organiza en la siguiente clase:

* `Shop_online`: La clase principal que gestiona la tienda online de la Pastelería O Pazo.

## Uso

1.  Define la clase `Shop_online`.
2.  Crea una instancia de la clase `Shop_online` para representar la Pastelería O Pazo.
3.  Utiliza los métodos de la instancia de la tienda para gestionar productos, clientes y ventas.

## Consideraciones

* En el apartado de "cobrar la venta" no se ha tenido en cuenta que si el cliente ingresa 0 y paga 0 la venta se finaliza.
* El código contiene algún error en la última variable y en ocasiones no devuelve la suma, está por resolver.
