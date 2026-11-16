package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;

@WebServlet(urlPatterns = { "/forgot-password", "/reset-password" })
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/forgot-password")) {
            String email = req.getParameter("email");
            if (userService.sendResetPasswordOTP(email)) {
                req.setAttribute("email", email);
                req.setAttribute("step", "reset");
                req.setAttribute("message", "Mã OTP đã được gửi tới email của bạn.");
            } else {
                req.setAttribute("alert", "Email không tồn tại trong hệ thống!");
            }
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        } else if (url.contains("/reset-password")) {
            String email = req.getParameter("email");
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");

            if (userService.resetPassword(email, otp, newPassword)) {
                req.setAttribute("message", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("email", email);
                req.setAttribute("step", "reset");
                req.setAttribute("alert", "Mã OTP không hợp lệ!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        }
    }
}