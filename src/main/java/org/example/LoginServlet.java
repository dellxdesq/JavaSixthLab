package org.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.AuthService;
import service.Utility;
import java.sql.SQLException;

import java.io.IOException;
@WebServlet(urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        try {
            if(AuthService.GetUser(login, password) == null) {
                response.getWriter().println("Имя или пароль неверны");
                return;
            }
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            response.getWriter().println("error");
        }

        request.getSession().setAttribute("login", login);
        request.getSession().setAttribute("password", password);
        response.sendRedirect(Utility.RedirectOn(request.getRequestURL().toString(), "/Manager?path=C:/forjava/users/"+login+"/"));
    }
}