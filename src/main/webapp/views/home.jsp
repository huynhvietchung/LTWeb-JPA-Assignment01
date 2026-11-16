<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
</head>
<body>
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <h2>Xin chào, ${sessionScope.account.fullname} (${sessionScope.account.username})!</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/categories">Quản lý Category (CRUD JPA)</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
            </ul>
        </c:when>
        <c:otherwise>
            <h2>Bạn chưa đăng nhập!</h2>
            <a href="${pageContext.request.contextPath}/login">Đi tới trang Đăng nhập</a>
        </c:otherwise>
    </c:choose>
</body>
</html>