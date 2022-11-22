package BD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BDConexion {
    private String connectionString = null;
    private String consultaSQL = null;
    
    //Objetos de la librería java.sql
    private Connection conexion = null;
    private Statement statement = null;

    //Bloque de Setters y Getters
    public Statement getStatement() {
        return statement;
    }

    public void setStatement(Statement statement) {
        this.statement = statement;
    }

    public String getConsultaSQL() {
        return consultaSQL;
    }

    public void setConsultaSQL(String consultaSQL) {
        this.consultaSQL = consultaSQL;
    }
    
    public Connection getConexion() {
        return conexion;
    }

    public void setConexion(Connection conexion) {
        this.conexion = conexion;
    }

    public String getConnectionString() {
        return connectionString;
    }

    public void setConnectionString(String connectionString) {
        this.connectionString = connectionString;
    }
    
    public void estableceConnectionString(){
        String user="Alexis";
        String pass="alexobd";
        String database="AdventureWorks2019";
        String server="DESKTOP-A5SBAIV";
        connectionString = "jdbc:sqlserver://"+server+";database="+database+";user="+user+";password="+pass+";"
                + "encrypt=true;trustServerCertificate=true";
        //connectionString = "jdbc:sqlserver://"+server+";database="+database+";integratedSecurity=true;";
        
    }
    
    //Inicia una conexion a la DB
    public void conectar() {
        try {
            setConexion(DriverManager.getConnection(getConnectionString()));
        }
        catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
           
            System.exit(-1);
        }
    }
    
    public void cierraConexion() throws SQLException {
        conexion.close();
    }
    public ResultSet consulta(String consulta) throws SQLException {
        this.statement = (Statement) conexion.createStatement();
        return this.statement.executeQuery(consulta);
    } 
    public void actualizar(String actualiza) throws SQLException {
        this.statement = (Statement) conexion.createStatement();
        statement.executeUpdate(actualiza);
    } 
    public ResultSet borrar(String borra) throws SQLException {
        Statement st = (Statement) this.conexion.createStatement();
        return (ResultSet) st.executeQuery(borra);
    } 
    public int insertar(String inserta) throws SQLException {
        Statement st = (Statement) this.conexion.createStatement();
        return st.executeUpdate(inserta);
    }
}
