<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kích hoạt tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4">
                    <h4 class="text-center fw-bold text-primary mb-2">Kích hoạt tài khoản</h4>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small">${message}</div>
                    </c:if>
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger py-2 small">${alert}</div>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/verify" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email đăng ký</label>
                            <input type="email" name="email" value="${email}" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mã OTP (6 chữ số)</label>
                            <input type="text" name="otp" class="form-control text-center fw-bold" maxlength="6" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-semibold">Xác nhận kích hoạt</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>