package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.UserServiceImpl;
import vn.iotstar.util.CloudinaryUtil;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.ValidationUtil;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 15)
@WebServlet(urlPatterns = { "/profile", "/profile/update", "/profile/verify-email" })
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("account");
        String url = req.getRequestURI();

        if (url.contains("/profile/update")) {
            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");
            String newEmail = req.getParameter("email");

            if (!ValidationUtil.isValidLength(fullname, 2, 100)) {
                req.setAttribute("alert", "Họ và tên phải từ 2 đến 100 ký tự!");
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }
            if (!ValidationUtil.isValidPhone(phone)) {
                req.setAttribute("alert", "Số điện thoại không đúng định dạng (VD: 0912345678)!");
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }
            if (!ValidationUtil.isValidEmail(newEmail)) {
                req.setAttribute("alert", "Địa chỉ Email không hợp lệ!");
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }

            Part avatarPart = req.getPart("avatarFile");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String avatarUrl = CloudinaryUtil.uploadImage(avatarPart);
                if (avatarUrl != null) {
                    currentUser.setAvatar(avatarUrl);
                }
            }

            currentUser.setFullname(fullname.trim());
            currentUser.setPhone(phone != null ? phone.trim() : null);
            userDao.update(currentUser);
            session.setAttribute("account", currentUser);

            if (!newEmail.trim().equalsIgnoreCase(currentUser.getEmail())) {
                if (userService.checkExistEmail(newEmail.trim())) {
                    req.setAttribute("alert", "Email mới này đã được sử dụng bởi tài khoản khác!");
                    req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                    return;
                }
                String otp = EmailUtil.getRandomOTP();
                boolean sent = EmailUtil.sendEmail(newEmail.trim(),
                        "Mã OTP xác nhận thay đổi Email - LTWeb",
                        "Xin chào " + currentUser.getFullname() + ",\nMã OTP xác nhận email mới của bạn là: " + otp);

                if (sent) {
                    session.setAttribute("pendingNewEmail", newEmail.trim());
                    session.setAttribute("pendingEmailOtp", otp);
                    req.setAttribute("message", "Đã cập nhật hồ sơ! Vui lòng nhập mã OTP vừa gửi đến " + newEmail.trim() + " để hoàn tất đổi Email.");
                } else {
                    req.setAttribute("alert", "Không thể gửi OTP tới email mới. Vui lòng kiểm tra cấu hình EmailUtil!");
                }
            } else {
                req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
            }

            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);

        } else if (url.contains("/profile/verify-email")) {
            String otpInput = req.getParameter("otp");
            String pendingEmail = (String) session.getAttribute("pendingNewEmail");
            String pendingOtp = (String) session.getAttribute("pendingEmailOtp");

            if (pendingEmail != null && pendingOtp != null && pendingOtp.equals(otpInput != null ? otpInput.trim() : "")) {
                currentUser.setEmail(pendingEmail);
                userDao.update(currentUser);
                session.setAttribute("account", currentUser);
                session.removeAttribute("pendingNewEmail");
                session.removeAttribute("pendingEmailOtp");
                req.setAttribute("message", "Xác nhận OTP thành công! Email của bạn đã được cập nhật sang " + pendingEmail);
            } else {
                req.setAttribute("alert", "Mã OTP xác nhận Email mới không chính xác!");
            }
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        }
    }
}
