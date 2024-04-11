<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 10.03.2024
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String directory = request.getParameter("path").replace("\\","/");
    File file = new File(directory);
    String parentDirectoryPath = "/";


    parentDirectoryPath = file.getParent();
    String login =(String) request.getAttribute("login");
    if (parentDirectoryPath == null || parentDirectoryPath.length() < ("C:\\forjava\\users\\".length() + login.length())) {
        parentDirectoryPath = "C:/forjava/users/"+request.getAttribute("login");
    }
%>
<html>
<head>
    <title>Менеджер файлов</title>

</head>
<body>

<h1>Текущая директория: "<%=(String) request.getAttribute("currentPath")%> "</h1>
<p><a href=<%="?path="+parentDirectoryPath.replace("\\","/").replace(" ", "%20")%>/>Назад</p>
<%
    String generatedAt = (String) request.getAttribute("generationTime");
%>
<p><%=generatedAt%></p>
<table>
    <tr>
        <th>Папка</th>
        <th>Перейти</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] itemList = (File[]) request.getAttribute("folders");
        for (File item : itemList) {
    %>
    <tr>
        <th><%= item.getName()%></th>
        <th><a href=<%="?path="+item.getAbsolutePath().replace("\\", "/").replace(" ", "%20")%>/>Перейти</th>
        <th></th>
        <th><%= new Date(item.lastModified())%></th>
    </tr>
    <% } %>
    <tr>
        <th>Файл</th>
        <th>Ссылка на скачивание</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] list = (File[]) request.getAttribute("files");
        for (File item : list) {
    %>
    <tr>
        <th><%= item.getName()%></th>

        <th><a href=<%="http://localhost:8080/ThirdLabJava_war_exploded/Download?path="+ item.getAbsolutePath().replace("\\","/").replace(" ", "%20")%>> Скачать </a> </th>
        <th><%= item.length()%></th>
        <th><%= new Date(item.lastModified())%></th>
    </tr>
    <% } %>
</table>


<p></p>
<form action="Manager" method="POST">
    <input type="submit" value="Выйти">
</form>
</body>
</html>
