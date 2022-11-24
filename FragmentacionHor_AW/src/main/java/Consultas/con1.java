package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class con1 {
        Scanner leer = new Scanner(System.in);
        BD.BDConexion sq = new BD.BDConexion();
        String msj = "";
        String nombre = "";
        int id;
        int cat;
        double total_venta;
    public void consulta() {
        System.out.println("Ingresa el ID de la categoria para consultar el total de ventas "
                + "por territorio"); 
        try {
            sq.estableceConnectionString();
            sq.conectar();

            ResultSet rsUsr;
            rsUsr = sq.consulta("select ProductCategoryID, Name from  [DESKTOP-A5SBAIV\\SQLSERVERDOS].productionAW.Production.ProductCategory order by ProductCategoryID");
            while (rsUsr.next()) {
                nombre = rsUsr.getString("Name");
                id = rsUsr.getInt("ProductCategoryID");
                System.out.println(id +".-"+nombre);
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        cat=Integer.parseInt(leer.nextLine());
        try {
            sq.estableceConnectionString();
            sq.conectar();

            ResultSet rsUsr;
            
            System.out.println("ID Territorio----Total Venta");
            rsUsr = sq.consulta("exec sp_uno '"+cat+"'");
            while (rsUsr.next()) {
                id = rsUsr.getInt("Territorio");
                total_venta= rsUsr.getDouble("Total_Venta");
                System.out.println("    "+id +"----------"+total_venta);
            }
            

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
