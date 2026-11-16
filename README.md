# LTWeb - JPA/Hibernate Assignment 01

Dự án lập trình Web Java sử dụng **Jakarta EE 10 (Servlet/JSP)** kết hợp **Hibernate ORM 6.5 (JPA)** và **SQL Server**.

## Công nghệ sử dụng
- **Java:** JDK 17
- **Web Framework:** Jakarta Servlet 6.0, JSP, JSTL 3.0, Bootstrap 5
- **ORM / Persistence:** Hibernate ORM 6.5.2.Final (JPA 3.1)
- **Database:** Microsoft SQL Server (`webst2`)
- **Build Tool:** Apache Maven

## Chức năng chính
1. **Cấu hình JPA & Entity:** Tự động ánh xạ và sinh bảng `users`, `categories`, `Videos` qua `persistence.xml` và `JPAConfig`.
2. **Xác thực người dùng (Authentication):**
    - Đăng nhập (`/login`) hỗ trợ `HttpSession` và `Cookie` (Ghi nhớ đăng nhập).
    - Đăng ký tài khoản (`/register`) kiểm tra trùng lặp username/email.
    - Đăng xuất (`/logout`) hủy session và xóa cookie.
    - Bộ lọc bảo mật `AuthFilter` chặn truy cập trái phép vào `/admin/*`.
3. **Quản lý Category (CRUD JPA):**
    - Hiển thị danh sách, tìm kiếm theo tên (`searchByName`).
    - Thêm mới, cập nhật và xóa Category.
    - Upload hình ảnh từ máy tính vào thư mục cục bộ và hiển thị qua `/image`.