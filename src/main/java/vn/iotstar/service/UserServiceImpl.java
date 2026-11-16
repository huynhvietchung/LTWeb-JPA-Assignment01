package vn.iotstar.service;

import java.util.Date;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDaoImpl;
import vn.iotstar.entity.User;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.PasswordUtil;

public class UserServiceImpl implements IUserService {
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.findByUsername(username);
        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User findByUsername(String username) { return userDao.findByUsername(username); }

    @Override
    public User findByEmail(String email) { return userDao.findByEmail(email); }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        String otp = EmailUtil.getRandomOTP();
        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtil.hashPassword(password)); // Hash mật khẩu
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setRoleid(1);
        user.setStatus(0); // Chưa kích hoạt
        user.setCode(otp);
        user.setCreatedDate(new Date());

        userDao.insert(user);
        EmailUtil.sendEmail(email, "Mã kích hoạt tài khoản LTWeb",
                "Xin chào " + fullname + ",\nMã OTP kích hoạt tài khoản của bạn là: " + otp);
        return true;
    }

    @Override
    public boolean verifyAccount(String email, String otpCode) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otpCode)) {
            user.setStatus(1); // Đã kích hoạt
            user.setCode(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean sendResetPasswordOTP(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) return false;
        String otp = EmailUtil.getRandomOTP();
        user.setCode(otp);
        userDao.update(user);
        return EmailUtil.sendEmail(email, "Mã OTP khôi phục mật khẩu",
                "Mã xác nhận đặt lại mật khẩu của bạn là: " + otp);
    }

    @Override
    public boolean resetPassword(String email, String otpCode, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getCode() != null && user.getCode().equals(otpCode)) {
            user.setPassword(PasswordUtil.hashPassword(newPassword));
            user.setCode(null);
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public boolean checkExistUsername(String username) { return userDao.checkExistUsername(username); }

    @Override
    public boolean checkExistEmail(String email) { return userDao.checkExistEmail(email); }
}