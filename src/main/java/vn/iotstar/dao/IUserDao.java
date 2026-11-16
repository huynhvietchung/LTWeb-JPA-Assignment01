package vn.iotstar.dao;

import vn.iotstar.entity.User;

public interface IUserDao {
    User findByUsername(String username);
    User findByEmail(String email);
    void insert(User user);
    void update(User user);
    boolean checkExistUsername(String username);
    boolean checkExistEmail(String email);
}