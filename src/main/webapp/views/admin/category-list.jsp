<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">LTWeb JPA</a>
        <div class="ms-auto d-flex gap-2">
            <a href="<c:url value='/home' />" class="btn btn-outline-light btn-sm">Trang chủ</a>
            <a href="<c:url value='/logout' />" class="btn btn-light btn-sm text-primary fw-semibold">Đăng xuất</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card shadow-sm border-0 rounded-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-primary">Danh sách Category</h5>
            <a href="<c:url value='/admin/category/add' />" class="btn btn-success btn-sm fw-semibold">+ Thêm Category</a>
        </div>
        <div class="card-body border-bottom bg-light py-2">
            <form action="<c:url value='/admin/categories' />" method="get" class="row g-2 align-items-center">
                <div class="col-sm-8 col-md-5">
                    <input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm" placeholder="Tìm kiếm theo tên Category...">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary btn-sm">Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/categories' />" class="btn btn-outline-secondary btn-sm">Xóa lọc</a>
                    </c:if>
                </div>
            </form>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">STT</th>
                            <th>Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-4">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listcate}" var="cate" varStatus="STT">
                            <tr>
                                <td class="ps-4 fw-semibold">${STT.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${fn:startsWith(cate.images, 'http')}">
                                            <c:url value="${cate.images}" var="imgUrl" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                                        </c:otherwise>
                                    </c:choose>
                                    <img class="rounded border object-fit-cover" height="70" width="100" src="${imgUrl}" alt="${cate.categoryname}" />
                                </td>
                                <td class="fw-semibold">${cate.categoryname}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cate.status == 1}">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-outline-primary btn-sm">Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listcate}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">Chưa có dữ liệu Category nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>