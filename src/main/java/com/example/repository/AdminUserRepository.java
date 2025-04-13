package com.example.repository;

import com.example.entity.AdminUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public class AdminUserRepository {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public AdminUserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * 根据用户名查找管理员
     */
    public AdminUser findByUsername(String username) {
        try {
            String sql = "SELECT * FROM admin_user WHERE username = ?";
            List<AdminUser> users = jdbcTemplate.query(
                sql, 
                new BeanPropertyRowMapper<>(AdminUser.class),
                username
            );
            return users.isEmpty() ? null : users.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 更新管理员最后登录时间
     */
    public void updateLastLoginTime(String username, LocalDateTime loginTime) {
        try {
            String sql = "UPDATE admin_user SET last_login_time = ? WHERE username = ?";
            jdbcTemplate.update(sql, java.sql.Timestamp.valueOf(loginTime), username);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

