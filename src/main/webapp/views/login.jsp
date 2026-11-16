<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>
<body>
    <h2>Đăng nhập hệ thống (JPA)</h2>
    <c:if test="${not empty alert}">
        <p style="color:red;">${alert}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Tên đăng nhập:</label><br>
        <input type="text" name="username" required><br><br>
        <label>Mật khẩu:</label><br>
        <input type="password" name="password" required><br><br>
        <input type="checkbox" name="remember" id="remember">
        <label for="remember">Ghi nhớ đăng nhập (Cookie)</label><br><br>
        <button type="submit">Đăng nhập</button>
    </form>
    <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>
</body>
</html>