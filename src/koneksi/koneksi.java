package koneksi;
    import java.sql.Connection;
    import java.sql.DriverManager;
/**
 *
 * @author James Nathanael
 */
public class koneksi {
     private static Connection cn;
    
    public static Connection getKoneksi(){
        if(cn== null){
            try{
                DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                cn = DriverManager.getConnection("jdbc:mysql://localhost/db_gshop"
                        ,"root","");
            }catch(Exception e){
                e.printStackTrace();
            }
        }
        return cn;
    }
}
