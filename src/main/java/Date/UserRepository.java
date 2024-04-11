package Date; //

import Model.User;
import java.sql.*;

public class UserRepository
{
    private static final String dbUrl = "jdbc:postgresql://localhost:5432/javabd";
    private static final String user = "postgres";
    private static final String password = "ybrbnf123";
    private static Connection connection;

    public static void Connect() throws SQLException, ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(dbUrl, user, password);
    }

    public static void Close() throws SQLException {
        if (connection != null) {
            connection.close();
        }
    }

    public static void CreateUser(User user) throws SQLException, ClassNotFoundException {
        if (connection == null) Connect();
//1
        String query = "INSERT INTO public.user(login, email, password) VALUES(?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(query)) {
            st.setString(1, user.getLogin());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPassword());
            int rowsAffected = st.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
        }
    }

    public static User GetUserByLogin(String login) throws SQLException, ClassNotFoundException {
        if (connection == null) Connect();

        String query = "SELECT id, login, email, password FROM public.user WHERE login = ?";
        try (PreparedStatement st = connection.prepareStatement(query)) {
            st.setString(1, login);
            ResultSet resultSet = st.executeQuery();
            if (resultSet.next()) {
                String fromDbLogin = resultSet.getString("login");
                String email = resultSet.getString("email");
                String password = resultSet.getString("password");
                return new User(fromDbLogin, password, email);
            }
        }
        return null;
    }

}

