<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${video.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">


<div class="container pb-5">
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card shadow-sm border-0 rounded-4 overflow-hidden">
                <div class="ratio ratio-16x9 bg-dark">
                    <c:choose>
                        <c:when test="${fn:startsWith(video.videoUrl, 'http')}">
                            <iframe src="${video.videoUrl}" title="${video.title}" allowfullscreen></iframe>
                        </c:when>
                        <c:otherwise>
                            <video controls autoplay class="w-100 h-100">
                                <source src="<c:url value='/media?fname=${video.videoUrl}' />" type="video/mp4">
                                Trình duyệt không hỗ trợ phát video.
                            </video>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body p-4">
                    <h4 class="fw-bold mb-2">${video.title}</h4>
                    <div class="d-flex flex-wrap gap-3 text-muted small mb-3 pb-3 border-bottom">
                        <span>Người đăng: <strong>${video.user.fullname}</strong></span>
                        <span>Lượt xem: <strong>${video.views}</strong></span>
                        <c:if test="${not empty video.category}">
                            <span>Danh mục: <span class="badge bg-primary-subtle text-primary">${video.category.categoryname}</span></span>
                        </c:if>
                    </div>
                    <h6 class="fw-semibold">Mô tả video:</h6>
                    <p class="text-secondary mb-4" style="white-space: pre-line;">${video.description}</p>
                    <a href="<c:url value='/home' />" class="btn btn-outline-secondary btn-sm">← Quay lại Trang chủ</a>
                    <a href="<c:url value='/video' />" class="btn btn-outline-primary btn-sm">Danh sách Video của tôi</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
