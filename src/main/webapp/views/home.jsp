<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ - LTWeb JPA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">


<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold text-primary mb-0">10 Video Mới Nhất</h4>
            <p class="text-muted small mb-0">Bấm vào tiêu đề video để xem chi tiết và phát video</p>
        </div>
        <a href="${pageContext.request.contextPath}/video/add" class="btn btn-success btn-sm fw-semibold">+ Đăng Video mới</a>
    </div>

    <div class="row g-4">
        <c:forEach items="${newestVideos}" var="v">
            <div class="col-md-6 col-lg-4">
                <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">
                    <c:choose>
                        <c:when test="${fn:startsWith(v.poster, 'http')}">
                            <c:set var="posterUrl" value="${v.poster}" />
                        </c:when>
                        <c:otherwise>
                            <c:url value="/image?fname=${v.poster}" var="posterUrl" />
                        </c:otherwise>
                    </c:choose>
                    <a href="<c:url value='/video/detail?id=${v.videoId}' />">
                        <img src="${posterUrl}" class="card-img-top object-fit-cover" style="height: 190px;" alt="${v.title}">
                    </a>
                    <div class="card-body d-flex flex-column">
                        <h6 class="card-title fw-bold mb-2">
                            <a href="<c:url value='/video/detail?id=${v.videoId}' />" class="text-decoration-none text-dark">
                                ${v.title}
                            </a>
                        </h6>
                        <p class="card-text text-muted small flex-grow-1">
                            ${fn:length(v.description) > 85 ? fn:substring(v.description, 0, 85).concat('...') : v.description}
                        </p>
                        <div class="d-flex justify-content-between align-items-center pt-2 border-top small text-secondary">
                            <span>Đăng bởi: <strong>${v.user.fullname}</strong></span>
                            <span>${v.views} lượt xem</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty newestVideos}">
            <div class="col-12">
                <div class="alert alert-info text-center">Chưa có video nào được đăng tải. Hãy là người đầu tiên đăng video!</div>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
