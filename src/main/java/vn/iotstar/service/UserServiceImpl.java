package vn.iotstar.service;

import java.util.Date;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDaoImpl;
import vn.iotstar.entity.User;

public class UserServiceImpl implements IUserService {
    private final IUserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = this.findByUsername(username);
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email)) {
            return false;
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullname(fullname);
        user.setPhone(phone);
        user.setRoleid(1); // Mặc định role User
        user.setCreatedDate(new Date());
        userDao.insert(user);
        return true;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }
}