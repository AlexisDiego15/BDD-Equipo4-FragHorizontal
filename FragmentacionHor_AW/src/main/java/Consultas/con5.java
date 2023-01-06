package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLOutput;
import java.util.Scanner;

public class con5 {
    BD.BDConexion sq = new BD.BDConexion();
    Scanner leer = new Scanner(System.in);
    char opc;
    char res='S';
    
    int Orden;
    int IDProd;
    int Cantidad;
    String Nombre;
    
    public void consulta() {
        int ordenid;
        int productoid;
        int nueva_can;
        int contad=0;
        
        System.out.println("A. Ver todos los productos");
        System.out.println("B. Ver productos por orden");
        System.out.println("C. Actualizar productos por orden");
        opc=leer.nextLine().charAt(0);
        
        switch(opc){
            case 'A': 
                vertodos();
            break;
            case 'B': 
                System.out.println("Ingresa el ID de la orden");
                ordenid=Integer.parseInt(leer.nextLine());
                verpororden(ordenid);
            break;
            case 'C':
                System.out.println("Ingresa el ID de la orden");
                ordenid=Integer.parseInt(leer.nextLine());
                contad=verpororden(ordenid);
                
                if(contad>0){
                    do{
                        System.out.println("Ingresa el ID del producto que desea modificar");
                        productoid=Integer.parseInt(leer.nextLine());
                        System.out.println("Ingresa la cantidad");
                        nueva_can=Integer.parseInt(leer.nextLine());

                        actualizar(ordenid, productoid, nueva_can);

                        System.out.println("Desea actualizar otro producto de esta orden? (S/N)");
                        res=leer.nextLine().charAt(0);
                    }while(res=='S');
                }else{
                    System.out.println("Orden no encontrada");
                }
                
                
            break;
        }    
    }    

    private void vertodos() {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDOrden\t   IDProducto\t   Nombre\t\t\t\t   Cantidad");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_cinco");
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                Orden = rsUsr.getInt("Orden");
                Cantidad = rsUsr.getInt("Cantidad");
                Nombre = rsUsr.getString("Nombre");
                
                System.out.println(Orden +" \t\t"+IDProd+"  \t\t  "+Nombre+"  \t\t\t  "+Cantidad);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private int verpororden(int ordenid) {
        int cont=0;
         try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDProducto\t   Nombre\t\t\t\t   Cantidad");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_cinco where Orden="+ordenid);
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                Cantidad = rsUsr.getInt("Cantidad");
                Nombre = rsUsr.getString("Nombre");
                
                System.out.println(IDProd+"  \t\t  "+Nombre+"  \t\t\t  "+Cantidad); 
                cont++;
            }
            

            rsUsr.close();
            sq.cierraConexion();

            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
         return cont;
    }

    private void actualizar(int ordenid, int productoid, int nueva_can) {
        String prodc;
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            
            rsUsr = sq.consulta("exec sp_cinco '"+nueva_can+"', '"+productoid+"', '"+ordenid+"'");
            if (rsUsr.next()) {
                prodc = rsUsr.getString("ProductosAumentados");
                System.out.println("Se cambio el stock de "+prodc+" producto(s)");
            }
            rsUsr.close();
            sq.cierraConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
        System.out.println("El stock quedo asi");
        verpororden(ordenid);
    }
}
