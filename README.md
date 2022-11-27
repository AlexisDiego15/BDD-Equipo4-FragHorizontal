# Fragmetación Horizontal - Equipo No. 4

En la carpeta de BD se encuentra la clase **BDConexión.java** donde encontraremos lo necesario para ejecutar el proyecto: debemos cambiar parámetros, como _usuario_ (user), _contraseña_ (pass), _servidor_ (server) y _nombre de la base de datos_ (database), como se muestra en la figura 1:

![Cuadro de texto: Parámetros para cambiar](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image001.png)![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image002.png)![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image004.png)

 																Figura 1. Estructura de la base de datos 

En la misma carpeta, en la clase **BDServers.java,** declaramos el nombre de los servidores que usamos para cada esquema, así como el mismo nombre de la base de datos que restauramos, solo hay que cambiarlos por los respectivos servidores y nombre de la base de datos en la _Instancia1_, _Instancia2_ , y _Instancia3_,   mostrados en la figura 2:

![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente con confianza media](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image007.png)

​																Figura 2. Instancias de la base de datos original.

Para la parte del archivo SQL, no encontramos una solución para crear variables con el nombre de los servidores vinculados y ponerlos en los SP's (stored procedures), por lo que para utilizarlos, se debe de cambiar manualmente en cada uno de ellos, al igual que en las vistas. Véase la figura 3 y 4: 

![Captura de Pantalla 2022-11-26 a la(s) 22.21.23](/Users/jenniffercervantes/Library/Application Support/typora-user-images/Captura de Pantalla 2022-11-26 a la(s) 22.21.23.png)

 																			Figura 3. Edición de cada variable.

![Una captura de pantalla de una computadora  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image009.png)

​																 			Figura 4. Edición de cada variable.



## Funcionamiento de las consultas:

Primero tenemos un menú para escoger la consulta:

**1. Determinar el total de las ventas de los productos con la categoría que se provea de argumento de entrada en la consulta, para cada uno de los territorios registrados en la base de datos.** 

Al escoger esta opción 1 nos despliega las categorías para que nosotros escojamos la que deseamos consultar, los resultados se muestran en la figura 5:

![Interfaz de usuario gráfica, Texto, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image010.png)

​																			Figura 5. Menú con las múltiples consultas. 

**2. Determinar el producto más solicitado para la región (atributo group de salesterritory) “Noth America” y en que territorio de la región tiene mayor demanda.** 

Al escoger la opción 2 nos muestra en la figura 6 con los siguientes detalles:

![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image012.png)

​			 													Figura 6. Resultado de la segunda consulta.

**3. Actualizar el stock disponible en un 5% de los productos de la categoría que se provea como argumento de entrada en una localidad que se provea como entrada en la instrucción de actualización.**

Al seleccionar nos despliega un submenú de la figura 7:

![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image014.png)

​																Figura 7. Opciones del submenú.

La opción A nos muestra en la figura 8 todo el stock:

![Interfaz de usuario gráfica, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image015.png)

​																	Figura 8. Stock completo de productos.

La opción B, en la figura 9, nos muestra las categorías existentes para que muestre el stock que existe de esa categoría;

![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image016.png)

​																	Figura 9. Categorías con respectivo stock.

La opción C nos devuelve las localidades que vemos en la figura 10 para conocer el stock que hay dentro de esa localidad:

![Interfaz de usuario gráfica, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image017.png)

​																	Figura 10. Stock de la localidad elegida.

La opción D de la figura 11 nos muestra el stock filtrado por categoría y localidad

![Interfaz de usuario gráfica, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image018.png)

Figura 11. Stock por categoría y localidad.

Finalmente, la opción E nos pide ingresar la categoría y la localidad para aumentar el stock un 5% y nos muestra el inventario de la figura 12:

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image019.png)

Figura 12. Aumento de stock por categoría y localidad. 

**4. Determinar si hay clientes que realizan ordenes en territorios diferentes al que se encuentran.** 

La figura 13 nos muestra el mensaje y el número de clientes; además los muestra en caso de que existan.

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image021.png)

Figura 13. Clientes con órdenes fuera del territorio.

**5. Actualizar la cantidad de productos de una orden que se provea como argumento en la instrucción de actualización.** 

La opción A nos muestra todos los productos, vea la figura 14:

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image022.png)

Figura 14. Total de productos.

La opción B, mostrada en la figura 15, nos pide un ID de orden y nos muestra todos los productos que se han pedido de esa orden :

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image023.png)

 Figura 15. Productos según el ID.

La opción C nos pide ingresar una orden y nos despliega los productos que existen para ésta, después nos pide el ID del producto y la cantidad nueva que deseamos ingresar, observe la figura 16:

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image024.png)

Figura 16. Actualización de productos en la orden.

Una vez ingresado nos vuelve a mostrar los productos que existen para esa orden y la cantidad actualizada, también nos pregunta si queremos cambiar otro producto de esa misma orden, tal como se muestra en la figura 17:

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image025.png)

 Figura 17.  Confirmación de productos en la orden.

**6. Actualizar el método de envío de una orden que se reciba como argumento en la instrucción de actualización.** 

La opción A se muestra en la figura 18 y nos devuelve todas las ordenes con su respectivo método de envío:

![img](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image026.png)

Figura 18. Total de ordenes con método de envío.

La opción B, en la figura 19, nos permite buscar la información de una orden en especifico:

![Interfaz de usuario gráfica, Texto, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image027.png)

Figura 19. Búsqueda de una orden.

La opción C nos permite actualizar el método de envío, de modo que buscamos la orden, nos da la información y luego nos muestra los métodos de envío para escoger uno. Finalmente nos volverá a mostrar la información de esa orden, observe la figura 20:

![Interfaz de usuario gráfica, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image028.png)

 Figura 20. Actualización del método de envío.

7. **Actualizar el correo electrónico de un cliente que se reciba como argumento en la instrucción de actualización. **

La opción A, en la figura 21, nos muestra todos los correo que le pertenecen a los clientes, así como su nombre y apellido:

![Interfaz de usuario gráfica, Texto, Aplicación  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image029.png)

 Figura 21. Datos personales de los clientes.

La opción B nos permite ingresar un correo y visualizar la información relacionada a ese correo, vea la figura 22:

![Interfaz de usuario gráfica, Texto, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image030.png)

 Figura 22. Información respecto al correo ingresado.

La opción C nos permite actualizar el correo de alguien, escribiendo el correo actual, para que nos despliegue la información y nos pida el nuevo correo, en caso de éxito nos desplegará que se actualizó el correo, junto a la nueva información como se muestra en la figura 23:

![Interfaz de usuario gráfica, Aplicación, Word  Descripción generada automáticamente](file:////Users/jenniffercervantes/Library/Group%20Containers/UBF8T346G9.Office/TemporaryItems/msohtmlclip/clip_image032.png) 

Figura 23. Actualización del correo.
