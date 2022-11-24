package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class con7 {
    BD.BDConexion sq = new BD.BDConexion();
    Scanner leer = new Scanner(System.in);
    char opc;

    String Correo_ant;
    String Correo_nue;
    String Nombre;
    String Apellido;
    
    public void consulta() {
        System.out.println("A. Ver todos los correos");
        System.out.println("B. Buscar informacion relacionada al correo");
        System.out.println("C. Actualizar correo de clientes");
        opc=leer.nextLine().charAt(0);
        
        switch(opc){
            case 'A': 
                vertodos();
            break;
            case 'B': 
                System.out.println("Ingresa correo del cliente");
                Correo_ant=leer.nextLine();
                verporcorreo(Correo_ant);
            break;
            case 'C':
                System.out.println("Ingresa el ANTERIOR correo del cliente");
                Correo_ant=leer.nextLine();
                verporcorreo(Correo_ant);
                System.out.println("Ingresa el NUEVO correo del cliente");
                Correo_nue=leer.nextLine();
                actualizar(Correo_ant, Correo_nue);
            break;
        }
    }

    private void vertodos() {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("Nombre\t\t   Apellido\t\t   Correo");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_siete");
            while (rsUsr.next()) {
                Nombre = rsUsr.getString("Nombre");
                Apellido = rsUsr.getString("Apellido");
                Correo_ant = rsUsr.getString("Correo");
                
                System.out.println(Nombre +" \t\t"+Apellido+"  \t\t  "+Correo_ant);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void verporcorreo(String Correo_ant) {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_siete where Correo='"+Correo_ant+"'");
            while (rsUsr.next()) {
                Nombre = rsUsr.getString("Nombre");
                Apellido = rsUsr.getString("Apellido");
                Correo_ant = rsUsr.getString("Correo");
                    
                System.out.println("Correo: "+Correo_ant);    
                System.out.println("Nombre: "+Nombre +" "+Apellido);          
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
    }

    private void actualizar(String Correo_ant, String Correo_nue) {
        int correoc;
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            
            rsUsr = sq.consulta("exec sp_siete '"+Correo_nue+"', '"+Correo_ant+"'");
            if (rsUsr.next()) {
                correoc = rsUsr.getInt("EmailCambiado");
                System.out.println("Se cambio "+correoc+" correo(s)");
            }
            rsUsr.close();
            sq.cierraConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
        System.out.println("La informacion quedo asi");
        verporcorreo(Correo_nue);   
    }
}
