package vn.iotstar.service;

import vn.iotstar.entity.User;

public interface IUserService {
    User login(String username, String password);
    User findByUsername(String username);
    boolean register(String username, String password, String email, String fullname, String phone);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}