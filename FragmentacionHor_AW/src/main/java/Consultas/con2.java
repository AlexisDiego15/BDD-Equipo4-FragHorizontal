package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;

public class con2 {
        BD.BDConexion sq = new BD.BDConexion();
        int id;
        String nombre;
        int cantidad_total;
        int id_territorio;
        String nom_territorio;
        int cantidad_territorio;

    public void consulta() {
        try {
            sq.estableceConnectionString();
            sq.conectar();

            ResultSet rsUsr;
            
            rsUsr = sq.consulta("exec sp_dos");
            if (rsUsr.next()) {
                id = rsUsr.getInt("ID");
                nombre = rsUsr.getString("Nombre");
                cantidad_total = rsUsr.getInt("CantidadTotal");
                id_territorio = rsUsr.getInt("IDTerritorio");
                nom_territorio = rsUsr.getString("NTerritorio");
                cantidad_territorio = rsUsr.getInt("CantidadTerritorio");
            }
            System.out.println("El producto más vendido fue: "+nombre +" con ID "+id);
            System.out.println("Se vendieron "+cantidad_total+" unidades");
            System.out.println("La región donde más se vendio fue "+nom_territorio+ " con ID "+id_territorio);
            System.out.println("Ahi se vendieron "+cantidad_territorio + " unidades");

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
 }
    
}
