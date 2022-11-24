package Consultas;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class con3 {
    BD.BDConexion sq = new BD.BDConexion();
    Scanner leer = new Scanner(System.in);
    char opc;

    int IDProd;
    String NProd;
    int IDCat;
    String Categoria;
    int Cantidad;
    int IDLoc;
    String NLoc;
            
    public void consulta() {
        System.out.println("A. Ver todo el stock de productos");
        System.out.println("B. Ver stock por categoria");
        System.out.println("C. Ver stock por localidad");
        System.out.println("D. Ver stock por categoria y localidad");
        System.out.println("E. Actualizar stock por categoria y localidad");
        opc=leer.nextLine().charAt(0);
        
        switch(opc){
            case 'A': 
                vertodo();
                break;
            case 'B': 
                verporcategoria();
                break;
            case 'C':
                verporlocalidad();
                break;
            case 'D': 
                int cat;
                System.out.println("Ingresa el ID de la categoria");
                categorias();
                cat=Integer.parseInt(leer.nextLine());
                int loc;
                System.out.println("Ingresa el ID de la Locacion");
                localidades();
                loc=Integer.parseInt(leer.nextLine());
                verloccat(cat, loc);
                break;
            case 'E': 
                actualizastock();
                break;
        }
    }

    private void vertodo() {
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDProducto   Nombre   IDCategoria   Categoria   Cantidad   IDLocacion   Locacion");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_tres");
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                NProd = rsUsr.getString("NProd");
                IDCat = rsUsr.getInt("IDCat");
                Categoria = rsUsr.getString("Categoria");
                Cantidad = rsUsr.getInt("Cantidad");
                IDLoc = rsUsr.getInt("IDLoc");
                NLoc = rsUsr.getString("NLoc");
                System.out.println(IDProd +"    "+NProd+"    "+IDCat+"    "+Categoria+"    "+Cantidad+"    "+IDLoc+"    "+NLoc);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void verporcategoria() {
        int cat;
        System.out.println("Ingresa el ID de la categoria");
        categorias();
        cat=Integer.parseInt(leer.nextLine());
    
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDProducto   Nombre       Cantidad   IDLocacion   Locacion");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_tres where IDCat="+cat);
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                NProd = rsUsr.getString("NProd");
                Cantidad = rsUsr.getInt("Cantidad");
                IDLoc = rsUsr.getInt("IDLoc");
                NLoc = rsUsr.getString("NLoc");
                System.out.println(IDProd +"    "+NProd+"     "+Cantidad+"    "+IDLoc+"    "+NLoc);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        
    }

    private void verporlocalidad() {
        int loc;
        System.out.println("Ingresa el ID de la Locacion");
        localidades();
        loc=Integer.parseInt(leer.nextLine());
    
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDProducto   Nombre       Cantidad   IDCategoria   Categoria");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_tres where IDLoc="+loc);
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                NProd = rsUsr.getString("NProd");
                Cantidad = rsUsr.getInt("Cantidad");
                IDCat = rsUsr.getInt("IDCat");
                Categoria = rsUsr.getString("Categoria");
                System.out.println(IDProd +"    "+NProd+"     "+Cantidad+"    "+IDCat+"    "+Categoria);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void verloccat(int cat, int loc) {
        
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            System.out.println("IDProducto   Nombre   \t\t\t    Cantidad  ");
            ResultSet rsUsr;
            rsUsr = sq.consulta("select * from vw_tres where IDCat="+cat+" and IDLoc="+loc);
            while (rsUsr.next()) {
                IDProd = rsUsr.getInt("IDProd");
                NProd = rsUsr.getString("NProd");
                Cantidad = rsUsr.getInt("Cantidad");
                System.out.println(IDProd +"    "+NProd+"   \t\t  "+Cantidad);           
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    private void actualizastock() {
        int prodau;
        System.out.println("Actualizacion de stock");
        int cat;
        System.out.println("Ingresa el ID de la categoria");
        categorias();
        cat=Integer.parseInt(leer.nextLine());
        int loc;
        System.out.println("Ingresa el ID de la Locacion");
        localidades();
        loc=Integer.parseInt(leer.nextLine());
        
        try {
            sq.estableceConnectionString();
            sq.conectar();
            ResultSet rsUsr;
            
            rsUsr = sq.consulta("exec sp_tres '"+cat+"', '"+loc+"'");
            if (rsUsr.next()) {
                prodau = rsUsr.getInt("ProductosAumentados");
                System.out.println("Se aumento el stock de "+prodau+" productos");
            }
            rsUsr.close();
            sq.cierraConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        verloccat(cat, loc);
    }

    private void categorias() {
        String nombre;
        int id; 
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
    }

    private void localidades() {
    String nombre;
        int id; 
        try {
            sq.estableceConnectionString();
            sq.conectar();

            ResultSet rsUsr;
            rsUsr = sq.consulta("select LocationID, Name from  [DESKTOP-A5SBAIV\\SQLSERVERDOS].productionAW.Production.Location order by LocationID");
            while (rsUsr.next()) {
                nombre = rsUsr.getString("Name");
                id = rsUsr.getInt("LocationID");
                System.out.println(id +".-"+nombre);
            }

            rsUsr.close();
            sq.cierraConexion();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
