<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 30.03.2024
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>Вход</title>
    <form action="LoginServlet" method="POST">
        <label for="login">Логин:</label>
        <input type="text" id="login" name="login"><br><br>
        <label for="password">Пароль:</label>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Войти">
    </form>
</head>
<a href=<%="Register"%>> Зарегистрироваться </a>
</html>
