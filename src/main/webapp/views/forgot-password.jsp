<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4">
                    <h4 class="text-center fw-bold text-primary mb-3">Quên mật khẩu</h4>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small">${message}</div>
                    </c:if>
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger py-2 small">${alert}</div>
                    </c:if>

                    <c:choose>
                        <c:when test="${step == 'reset'}">
                            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                                <input type="hidden" name="email" value="${email}">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Mã OTP từ Email</label>
                                    <input type="text" name="otp" class="form-control" maxlength="6" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Mật khẩu mới</label>
                                    <input type="password" name="newPassword" class="form-control" required>
                                </div>
                                <button type="submit" class="btn btn-success w-100 fw-semibold">Đổi mật khẩu</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Nhập Email đã đăng ký</label>
                                    <input type="email" name="email" class="form-control" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 fw-semibold">Gửi mã OTP</button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <hr class="my-3">
                    <p class="text-center small mb-0">
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Quay lại Đăng nhập</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>