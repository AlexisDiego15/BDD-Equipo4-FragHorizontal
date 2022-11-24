package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;

public class con4 {
        BD.BDConexion sq = new BD.BDConexion();
        int orden;
        int cliente;
        int territorio_orden;
        int territorio_cliente;
    public void consulta() {
        
        int clientes_tot=0;
        try {
            sq.estableceConnectionString();
            sq.conectar();

            ResultSet rsUsr;
            
            System.out.println("Orden\t IDTerritorioOrden \tCliente IDTerritorioCliente");
            rsUsr = sq.consulta("exec sp_cuatro");
            while (rsUsr.next()) {
                orden = rsUsr.getInt("orden");
                cliente = rsUsr.getInt("cliente");
                territorio_orden = rsUsr.getInt("territorio_orden");
                territorio_cliente = rsUsr.getInt("territorio_cliente");
                
                System.out.println(orden +"\t   "+territorio_orden+" \t\t\t"+cliente + "\t\t\t" +territorio_cliente);
                
                clientes_tot=clientes_tot++;
            }
            
            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
        if(clientes_tot==0){
            System.out.println("No se encontraron clientes que realicen pedidos en terriotorios difrentes");
        }else{
            System.out.println("Se encontraron "+clientes_tot+" clientes que realizan pedidos en terriotorios difrentes");
        }
    }    
}
