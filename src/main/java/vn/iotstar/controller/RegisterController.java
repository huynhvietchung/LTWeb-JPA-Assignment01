package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.ValidationUtil;
import vn.iotstar.service.UserServiceImpl;

@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (!ValidationUtil.isValidUsername(username)) {
            req.setAttribute("alert", "Tên đăng nhập từ 4-30 ký tự, chỉ gồm chữ cái, số và dấu gạch dưới!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidPassword(password)) {
            req.setAttribute("alert", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidEmail(email)) {
            req.setAttribute("alert", "Định dạng Email không hợp lệ!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (ValidationUtil.isBlank(fullname) || !ValidationUtil.isValidLength(fullname, 2, 100)) {
            req.setAttribute("alert", "Họ và tên phải từ 2 đến 100 ký tự!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            req.setAttribute("alert", "Số điện thoại không hợp lệ (VD: 0912345678)!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistUsername(username)) {
            req.setAttribute("alert", "Tên đăng nhập đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (userService.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã được sử dụng!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        boolean isSuccess = userService.register(username, password, email, fullname, phone);
        if (isSuccess) {
            req.setAttribute("email", email);
            req.setAttribute("message", "Đăng ký thành công! Vui lòng nhập mã OTP đã gửi về email.");
            req.getRequestDispatcher("/views/verify.jsp").forward(req, resp);
        } else {
            req.setAttribute("alert", "Đăng ký thất bại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
