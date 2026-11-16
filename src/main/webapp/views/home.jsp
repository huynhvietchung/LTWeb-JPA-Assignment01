<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">LTWeb JPA</a>
        <div class="ms-auto d-flex align-items-center gap-3">
            <c:if test="${not empty sessionScope.account}">
                <span class="text-white small">Xin chào, <strong>${sessionScope.account.fullname}</strong></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
            </c:if>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4 text-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <h3 class="fw-bold mb-2">Chào mừng trở lại, ${sessionScope.account.fullname}!</h3>
                            <p class="text-muted mb-4">Tài khoản: <code>${sessionScope.account.username}</code> | Email: ${sessionScope.account.email}</p>
                            <div class="d-flex justify-content-center gap-3">
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-primary px-4">
                                    Quản lý Category (CRUD JPA)
                                </a>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger px-4">
                                    Đăng xuất
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <h4 class="fw-bold text-danger mb-3">Bạn chưa đăng nhập!</h4>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary px-4">Đi tới trang Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>