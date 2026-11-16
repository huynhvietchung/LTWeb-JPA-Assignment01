<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập hệ thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4">
                    <h3 class="text-center fw-bold text-primary mb-1">Đăng nhập</h3>
                    <p class="text-center text-muted small mb-4">Hệ thống quản lý JPA / Hibernate</p>

                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger py-2 small" role="alert">${alert}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control" placeholder="Nhập username..." required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu</label>
                            <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" name="remember" id="remember">
                            <label class="form-check-label small text-secondary" for="remember">
                                Ghi nhớ đăng nhập (Cookie)
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-semibold py-2">Đăng nhập</button>
                    </form>

                    <hr class="my-4">
                    <p class="text-center small mb-0">
                        Chưa có tài khoản?
                        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-semibold">Đăng ký ngay</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>