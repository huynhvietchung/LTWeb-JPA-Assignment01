package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "username", unique = true, nullable = false, columnDefinition = "nvarchar(50)")
    private String username;

    @Column(name = "password", nullable = false, columnDefinition = "nvarchar(255)")
    private String password;

    @Column(name = "email", unique = true, columnDefinition = "nvarchar(100)")
    private String email;

    @Column(name = "status")
    private Integer status; // 0: Chưa kích hoạt, 1: Đã kích hoạt

    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }

    @Column(name = "code", columnDefinition = "nvarchar(10)")
    private String code;

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    @Column(name = "fullname", columnDefinition = "nvarchar(100)")
    private String fullname;

    @Column(name = "avatar", columnDefinition = "nvarchar(255)")
    private String avatar;

    @Column(name = "roleid")
    private int roleid; // 1: User, 2: Manager, 3: Admin

    @Column(name = "phone", columnDefinition = "nvarchar(20)")
    private String phone;

    @Temporal(TemporalType.DATE)
    @Column(name = "createdDate")
    private Date createdDate;

    public User() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}
