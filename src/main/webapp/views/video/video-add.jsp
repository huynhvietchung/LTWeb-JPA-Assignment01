<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Video mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-4">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-primary">Đăng tải Video mới</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty alert}"><div class="alert alert-danger py-2 small">${alert}</div></c:if>
                    <form action="<c:url value='/video/insert' />" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tiêu đề Video</label>
                            <input type="text" name="title" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Danh mục (Category)</label>
                            <select name="categoryid" class="form-select">
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach items="${categories}" var="c">
                                    <option value="${c.categoryid}">${c.categoryname}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Link ảnh Poster (URL)</label>
                                <input type="text" name="poster" class="form-control" placeholder="https://...">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Hoặc Upload ảnh Poster</label>
                                <input type="file" name="posterFile" class="form-control" accept="image/*">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Link Video (YouTube / URL)</label>
                                <input type="text" name="videoUrl" class="form-control" placeholder="https://www.youtube.com/watch?v=...">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Hoặc Upload file Video (.mp4)</label>
                                <input type="file" name="videoFile" class="form-control" accept="video/mp4,video/*">
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mô tả chi tiết</label>
                            <textarea name="description" rows="3" class="form-control"></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái hiển thị</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="active" id="act1" value="1" checked>
                                <label class="form-check-label" for="act1">Công khai</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="active" id="act0" value="0">
                                <label class="form-check-label" for="act0">Ẩn</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/video' />" class="btn btn-secondary">Hủy</a>
                            <button type="submit" class="btn btn-primary px-4">Lưu Video</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
