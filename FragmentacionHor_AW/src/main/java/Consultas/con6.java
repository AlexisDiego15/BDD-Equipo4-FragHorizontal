package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class con6 {

    BD.BDConexion sq = new BD.BDConexion();
    Scanner leer = new Scanner(System.in);
    char opc;
    int ordenid, nuevomet;
    int IDOrden, IDMetodo;
    String Metodo;
    
    public void consulta() {BD.BDConexion sq = new BD.BDConexion();
               
        System.out.println("A. Ver todas las ordenes con envio");
        System.out.println("B. Ver metodo de envio por busqueda de orden");
        System.out.println("C. Actualizar metodo de envio en orden");
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
                verpororden(ordenid);
                metodos();
                System.out.println("Ingresa el nuevo metodo de envio");
                nuevomet=Integer.parseInt(leer.nextLine());
                actualizar(ordenid, nuevomet);
            break;
        }
    }

    private void vertodos() {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDOrden\t   IDMetodo\t\t\t   Metodo");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_seis");
            while (rsUsr.next()) {
                IDOrden = rsUsr.getInt("IDOrden");
                IDMetodo = rsUsr.getInt("IDMetodo");
                Metodo = rsUsr.getString("Metodo");
                
                System.out.println(IDOrden +" \t\t"+IDMetodo+"  \t\t  "+Metodo);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void verpororden(int ordenid) {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_seis where IDOrden="+ordenid);
            while (rsUsr.next()) {
                IDOrden = rsUsr.getInt("IDOrden");
                IDMetodo = rsUsr.getInt("IDMetodo");
                Metodo = rsUsr.getString("Metodo");
                
                System.out.println("IDOrden: "+IDOrden);   
                System.out.println("IDMetodo: "+IDMetodo);   
                System.out.println("Metodo: "+Metodo);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void metodos() {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            rsUsr = sq.consulta("select ShipMethodID, Name from [DESKTOP-A5SBAIV\\SQLSERVERTRES].otrosAW.Purchasing.ShipMethod order by ShipMethodID");
            while (rsUsr.next()) {
                IDMetodo = rsUsr.getInt("ShipMethodID");
                Metodo = rsUsr.getString("Name");
                
                System.out.println(IDMetodo+".-"+Metodo);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
    }

    private void actualizar(int ordenid, int nuevomet) {
        int metc;
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            
            rsUsr = sq.consulta("exec sp_seis '"+nuevomet+"', '"+ordenid+"'");
            if (rsUsr.next()) {
                metc = rsUsr.getInt("MetodosCambiados");
                System.out.println("Se cambio el metodo de "+metc+" orden(es)");
            }
            rsUsr.close();
            sq.cierraConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
        System.out.println("La informacion quedo asi");
        verpororden(ordenid);
    }
}
