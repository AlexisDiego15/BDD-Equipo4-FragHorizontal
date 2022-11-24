package com.mycompany.fragmentacionhor_aw;

import java.util.Scanner;

public class FragmentacionHor_AW {

    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
        int opc=1;
        
        do{
            System.out.println("\n\nIngresa una opcion");
            System.out.println("1. Total de ventas por categoria por territorio");
            System.out.println("2. Producto mas solicitado en North America");
            System.out.println("3. Actualizar stock de categoria en localidad");
            System.out.println("4. Ver clientes que ordenan en territorio diferente");
            System.out.println("5. Actualizar cantidad de productos en orden");
            System.out.println("6. Actualizar metodo de envio de orden ");
            System.out.println("7. Actualizar correo electronico de cliente");
            System.out.println("0. Salir");
            opc=Integer.parseInt(leer.nextLine());
            switch(opc){
                case 1:
                    Consultas.con1 c1= new Consultas.con1();
                    c1.consulta();
                    break;
                case 2:                    
                    Consultas.con2 c2= new Consultas.con2();
                    c2.consulta();
                    break;
                case 3:
                    Consultas.con3 c3= new Consultas.con3();
                    c3.consulta();
                    break;
                case 4:
                    Consultas.con4 c4= new Consultas.con4();
                    c4.consulta();
                    break;
                case 5:                    
                    Consultas.con5 c5= new Consultas.con5();
                    c5.consulta();
                    break;
                case 6:
                    Consultas.con6 c6= new Consultas.con6();
                    c6.consulta();
                    break;
                case 7:
                    Consultas.con7 c7= new Consultas.con7();
                    c7.consulta();
                    break;
            }
        }while(opc!=0);
    }
}
