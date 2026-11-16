package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User findByUsername(String username);
    User findByEmail(String email);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean verifyAccount(String email, String otpCode);
    boolean sendResetPasswordOTP(String email);
    boolean resetPassword(String email, String otpCode, String newPassword);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}