<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title"/> - LTWeb JPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body class="bg-light d-flex flex-column min-vh-100">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-play-btn-fill me-1"></i> LTWeb JPA
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-1">
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/video">
                        <i class="bi bi-collection-play me-1"></i>Video của tôi
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="bi bi-folder2-open me-1"></i>Quản lý Category
                    </a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-3">
                <c:if test="${not empty sessionScope.account}">
                    <a href="${pageContext.request.contextPath}/profile" class="d-flex align-items-center text-white text-decoration-none gap-2" title="Hồ sơ cá nhân">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account.avatar and fn:startsWith(sessionScope.account.avatar, 'http')}">
                                <img src="${sessionScope.account.avatar}" class="rounded-circle border border-white object-fit-cover" width="32" height="32" alt="Avatar">
                            </c:when>
                            <c:when test="${not empty sessionScope.account.avatar}">
                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" class="rounded-circle border border-white object-fit-cover" width="32" height="32" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-person-circle fs-4"></i>
                            </c:otherwise>
                        </c:choose>
                        <span class="small fw-semibold">${sessionScope.account.fullname}</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow-1">
    <sitemesh:write property="body"/>
</main>

<footer class="bg-white border-top py-3 mt-auto">
    <div class="container text-center text-muted small">
        &copy; 2026 LTWeb JPA/Hibernate Assignment - SiteMesh Decorator 3 &amp; Bootstrap 5
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
