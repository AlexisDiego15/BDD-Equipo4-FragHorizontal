# Fragmetación Horizontal - Equipo No. 4

En la carpeta de BD se encuentra la clase **BDConexión.java** donde encontraremos lo necesario para ejecutar el proyecto: debemos cambiar parámetros, como _usuario_ (user), _contraseña_ (pass), _servidor_ (server) y _nombre de la base de datos_ (database), como se muestra en la figura 1:
![Imagen 1](https://user-images.githubusercontent.com/68259360/204364915-0b6f7995-ced5-4bc2-af71-6c60098edf51.png)

Figura 1. Estructura de la base de datos 

En la misma carpeta, en la clase **BDServers.java,** declaramos el nombre de los servidores que usamos para cada esquema, así como el mismo nombre de la base de datos que restauramos, solo hay que cambiarlos por los respectivos servidores y nombre de la base de datos en la _Instancia1_, _Instancia2_ , y _Instancia3_,   mostrados en la figura 2:
![Imagen 2](https://user-images.githubusercontent.com/68259360/204365262-eb3a0785-0934-47a1-af00-08e56fcc41bd.png)


​																Figura 2. Instancias de la base de datos original.

Para la parte del archivo SQL, no encontramos una solución para crear variables con el nombre de los servidores vinculados y ponerlos en los SP's (stored procedures), por lo que para utilizarlos, se debe de cambiar manualmente en cada uno de ellos, al igual que en las vistas. Véase la figura 3 y 4: 

![Imagen 3](https://user-images.githubusercontent.com/68259360/204365579-18bbd394-ef5d-4fa3-aa7b-a3fe7179a18b.png)

 																			Figura 3. Edición de cada variable.

![Imagen 4](https://user-images.githubusercontent.com/68259360/204365591-2c3fac52-08b5-4b58-802a-2ac3b6b41b32.png)

​																 			Figura 4. Edición de cada variable.



## Funcionamiento de las consultas:

Primero tenemos un menú para escoger la consulta:

**1. Determinar el total de las ventas de los productos con la categoría que se provea de argumento de entrada en la consulta, para cada uno de los territorios registrados en la base de datos.** 

Al escoger esta opción 1 nos despliega las categorías para que nosotros escojamos la que deseamos consultar, los resultados se muestran en la figura 5:

![Imagen 5](https://user-images.githubusercontent.com/68259360/204365637-130bd00b-1908-46ef-996a-a855c1321465.png)

​																			Figura 5. Menú con las múltiples consultas. 

**2. Determinar el producto más solicitado para la región (atributo group de salesterritory) “Noth America” y en que territorio de la región tiene mayor demanda.** 

Al escoger la opción 2 nos muestra en la figura 6 con los siguientes detalles:
![Imagen 6](https://user-images.githubusercontent.com/68259360/204365671-f1616eef-136b-4db2-9ac2-e911b852c404.png)


​			 													Figura 6. Resultado de la segunda consulta.

**3. Actualizar el stock disponible en un 5% de los productos de la categoría que se provea como argumento de entrada en una localidad que se provea como entrada en la instrucción de actualización.**

Al seleccionar nos despliega un submenú de la figura 7:

![Imagen 7](https://user-images.githubusercontent.com/68259360/204365685-ddd9ba91-988a-4178-898b-fbcf7cd85c5e.png)

​																Figura 7. Opciones del submenú.

La opción A nos muestra en la figura 8 todo el stock:

![Imagen 8](https://user-images.githubusercontent.com/68259360/204365703-248f2c41-be4e-4ad4-87d7-0168690538c9.png)

​																	Figura 8. Stock completo de productos.

La opción B, en la figura 9, nos muestra las categorías existentes para que muestre el stock que existe de esa categoría;

![Imagen 9](https://user-images.githubusercontent.com/68259360/204365717-def7c8ae-391b-466a-ac16-bd76a003f119.png)

​																	Figura 9. Categorías con respectivo stock.

La opción C nos devuelve las localidades que vemos en la figura 10 para conocer el stock que hay dentro de esa localidad:
![Imagen 10](https://user-images.githubusercontent.com/68259360/204365726-4c7ef9e1-b9f4-4883-b2a4-ae70544de6ea.png)


​																	Figura 10. Stock de la localidad elegida.

La opción D de la figura 11 nos muestra el stock filtrado por categoría y localidad

![Imagen 11](https://user-images.githubusercontent.com/68259360/204365741-9bf311c4-3378-43af-8428-f1eb2d928f27.png)

Figura 11. Stock por categoría y localidad.

Finalmente, la opción E nos pide ingresar la categoría y la localidad para aumentar el stock un 5% y nos muestra el inventario de la figura 12:

![Imagen 12](https://user-images.githubusercontent.com/68259360/204365762-e24a3ef8-dc5a-40de-a7d3-d105e5bc3a12.png)

Figura 12. Aumento de stock por categoría y localidad. 

**4. Determinar si hay clientes que realizan ordenes en territorios diferentes al que se encuentran.** 

La figura 13 nos muestra el mensaje y el número de clientes; además los muestra en caso de que existan.

![Imagen 13](https://user-images.githubusercontent.com/68259360/204365774-234d32b2-4cdf-4ed0-945a-da7cbb40f762.png)

Figura 13. Clientes con órdenes fuera del territorio.

**5. Actualizar la cantidad de productos de una orden que se provea como argumento en la instrucción de actualización.** 

La opción A nos muestra todos los productos, vea la figura 14:

![Imagen 14](https://user-images.githubusercontent.com/68259360/204365782-0a12d01c-28cc-435c-9897-86bd0b3a3c70.png)

Figura 14. Total de productos.

La opción B, mostrada en la figura 15, nos pide un ID de orden y nos muestra todos los productos que se han pedido de esa orden :

![Imagen 15](https://user-images.githubusercontent.com/68259360/204365791-8cfec139-9a1f-4d13-b683-96cd9a8c201d.png)

 Figura 15. Productos según el ID.

La opción C nos pide ingresar una orden y nos despliega los productos que existen para ésta, después nos pide el ID del producto y la cantidad nueva que deseamos ingresar, observe la figura 16:
![Imagen 16](https://user-images.githubusercontent.com/68259360/204365810-563a593a-e389-4701-bb77-651fc9789aae.png)


Figura 16. Actualización de productos en la orden.

Una vez ingresado nos vuelve a mostrar los productos que existen para esa orden y la cantidad actualizada, también nos pregunta si queremos cambiar otro producto de esa misma orden, tal como se muestra en la figura 17:
![Imagen 17](https://user-images.githubusercontent.com/68259360/204365826-17d809e8-94ac-45dd-8985-7cd330f4e207.png)


 Figura 17.  Confirmación de productos en la orden.

**6. Actualizar el método de envío de una orden que se reciba como argumento en la instrucción de actualización.** 

La opción A se muestra en la figura 18 y nos devuelve todas las ordenes con su respectivo método de envío:
![Imagen 18](https://user-images.githubusercontent.com/68259360/204365841-cf961446-da35-466c-94c1-0fdf21557f2c.png)


Figura 18. Total de ordenes con método de envío.

La opción B, en la figura 19, nos permite buscar la información de una orden en especifico:

![Imagen 19](https://user-images.githubusercontent.com/68259360/204365852-055f7264-6257-4464-913e-f3030a7ce309.png)

Figura 19. Búsqueda de una orden.

La opción C nos permite actualizar el método de envío, de modo que buscamos la orden, nos da la información y luego nos muestra los métodos de envío para escoger uno. Finalmente nos volverá a mostrar la información de esa orden, observe la figura 20:

![Imagen 20](https://user-images.githubusercontent.com/68259360/204365865-32df97b4-cfef-42d1-afbb-06a4195b916d.png)

 Figura 20. Actualización del método de envío.

7. **Actualizar el correo electrónico de un cliente que se reciba como argumento en la instrucción de actualización. **

La opción A, en la figura 21, nos muestra todos los correo que le pertenecen a los clientes, así como su nombre y apellido:

![Imagen 21](https://user-images.githubusercontent.com/68259360/204365872-7e3ad5bb-50e1-4a91-bf97-f54352533694.png)

 Figura 21. Datos personales de los clientes.

La opción B nos permite ingresar un correo y visualizar la información relacionada a ese correo, vea la figura 22:

![Imagen 22](https://user-images.githubusercontent.com/68259360/204365885-26b3abae-71c7-4986-a5d0-1b05ab112911.png)

 Figura 22. Información respecto al correo ingresado.

La opción C nos permite actualizar el correo de alguien, escribiendo el correo actual, para que nos despliegue la información y nos pida el nuevo correo, en caso de éxito nos desplegará que se actualizó el correo, junto a la nueva información como se muestra en la figura 23:

![Imagen 23](https://user-images.githubusercontent.com/68259360/204365902-12291116-d2b4-497e-b32f-afd258a10d84.png)

Figura 23. Actualización del correo.
