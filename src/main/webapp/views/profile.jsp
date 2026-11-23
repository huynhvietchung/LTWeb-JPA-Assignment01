<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân</title>
</head>
<body>
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-person-badge me-2"></i>Thông tin tài khoản (Profile)</h5>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty message}">
                        <div class="alert alert-success py-2 small">${message}</div>
                    </c:if>
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger py-2 small">${alert}</div>
                    </c:if>

                    <c:if test="${not empty sessionScope.pendingNewEmail}">
                        <div class="card bg-warning-subtle border-warning mb-4">
                            <div class="card-body">
                                <h6 class="fw-bold text-dark mb-1">Xác nhận Email mới: ${sessionScope.pendingNewEmail}</h6>
                                <p class="small text-muted mb-2">Nhập mã OTP 6 chữ số đã gửi về địa chỉ email mới của bạn:</p>
                                <form action="${pageContext.request.contextPath}/profile/verify-email" method="post" class="d-flex gap-2">
                                    <input type="text" name="otp" class="form-control text-center fw-bold" maxlength="6" placeholder="Nhập 6 số OTP" required>
                                    <button type="submit" class="btn btn-warning fw-semibold text-nowrap">Xác nhận OTP</button>
                                </form>
                            </div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data">
                        <div class="text-center mb-4">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar and fn:startsWith(sessionScope.account.avatar, 'http')}">
                                    <img src="${sessionScope.account.avatar}" class="rounded-circle shadow-sm border object-fit-cover mb-2" width="110" height="110" alt="Avatar">
                                </c:when>
                                <c:when test="${not empty sessionScope.account.avatar}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" class="rounded-circle shadow-sm border object-fit-cover mb-2" width="110" height="110" alt="Avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://placehold.co/110x110?text=Avatar" class="rounded-circle shadow-sm border mb-2" width="110" height="110" alt="Avatar">
                                </c:otherwise>
                            </c:choose>
                            <div class="mt-2">
                                <label class="form-label small fw-semibold text-primary">Đổi ảnh đại diện (Upload lên Cloudinary)</label>
                                <input type="file" name="avatarFile" class="form-control form-control-sm" accept="image/*">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập (Username)</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.account.username}" readonly>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="fullname" value="${sessionScope.account.fullname}" class="form-control" minlength="2" maxlength="100" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" name="phone" value="${sessionScope.account.phone}" class="form-control" pattern="^(0|\+84)[0-9]{9,10}$" placeholder="VD: 0912345678">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                            <input type="email" name="email" value="${sessionScope.account.email}" class="form-control" required>
                            <div class="form-text">Nếu thay đổi sang Email mới, hệ thống sẽ gửi mã OTP xác nhận về Email mới.</div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">Quay lại</a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">Lưu thay đổi</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
