<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Video của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">


<div class="container pb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold text-primary mb-0">Danh sách Video của bạn (${totalVideos} video)</h4>
            <p class="text-muted small mb-0">Hiển thị tối đa 6 video mỗi trang</p>
        </div>
        <a href="<c:url value='/video/add' />" class="btn btn-success fw-semibold">+ Thêm Video mới</a>
    </div>

    <div class="row g-4">
        <c:forEach items="${videos}" var="v">
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
                    <img src="${posterUrl}" class="card-img-top object-fit-cover" style="height: 185px;" alt="${v.title}">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start mb-1">
                            <h6 class="card-title fw-bold mb-0">
                                <a href="<c:url value='/video/detail?id=${v.videoId}' />" class="text-decoration-none text-dark">
                                    ${v.title}
                                </a>
                            </h6>
                            <span class="badge ${v.active ? 'bg-success' : 'bg-secondary'} ms-2">
                                ${v.active ? 'Công khai' : 'Ẩn'}
                            </span>
                        </div>
                        <p class="text-muted small mb-2">${v.views} lượt xem</p>
                        <p class="card-text text-secondary small flex-grow-1">
                            ${fn:length(v.description) > 75 ? fn:substring(v.description, 0, 75).concat('...') : v.description}
                        </p>
                        <div class="d-flex gap-2 pt-3 border-top">
                            <a href="<c:url value='/video/detail?id=${v.videoId}' />" class="btn btn-primary btn-sm flex-fill">Xem</a>
                            <a href="<c:url value='/video/edit?id=${v.videoId}' />" class="btn btn-outline-warning btn-sm flex-fill">Sửa</a>
                            <a href="<c:url value='/video/delete?id=${v.videoId}' />" class="btn btn-outline-danger btn-sm flex-fill"
                               onclick="return confirm('Bạn có chắc muốn xóa video này?')">Xóa</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty videos}">
            <div class="col-12">
                <div class="alert alert-secondary text-center py-4">Bạn chưa đăng tải video nào.</div>
            </div>
        </c:if>
    </div>

    <!-- Thanh phân trang 6 sản phẩm/trang -->
    <c:if test="${totalPages > 1}">
        <nav class="mt-4 d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/video?page=${currentPage - 1}' />">Trước</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/video?page=${i}' />">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/video?page=${currentPage + 1}' />">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>
