<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thêm Category</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-primary">Thêm mới Category</h5>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty alert}"><div class="alert alert-danger py-2 small">${alert}</div></c:if>
                    <form action="<c:url value='/admin/category/insert' />" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="categoryname" class="form-label fw-semibold">Tên Category</label>
                            <input type="text" class="form-control" id="categoryname" name="categoryname" required>
                        </div>

                        <div class="mb-3">
                            <label for="images" class="form-label fw-semibold">Link hình ảnh (URL)</label>
                            <input type="text" class="form-control" id="images" name="images" placeholder="https://...">
                        </div>

                        <div class="mb-3">
                            <label for="images1" class="form-label fw-semibold">Hoặc tải ảnh từ máy</label>
                            <input type="file" class="form-control" id="images1" name="images1" accept="image/*">
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold d-block">Trạng thái</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                                <label class="form-check-label" for="ston">Hoạt động</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                                <label class="form-check-label" for="stoff">Khóa</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<c:url value='/admin/categories' />" class="btn btn-secondary">Hủy</a>
                            <button type="submit" class="btn btn-primary px-4">Lưu lại</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>