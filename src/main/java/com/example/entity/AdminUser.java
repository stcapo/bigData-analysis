package com.example.entity;

import java.time.LocalDateTime;

public class AdminUser {
    private Long userId;
    private String username;
    private String password;
    private LocalDateTime createTime;
    private LocalDateTime lastLoginTime;

    public AdminUser() {
    }

    public AdminUser(Long userId, String username, String password, LocalDateTime createTime, LocalDateTime lastLoginTime) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.createTime = createTime;
        this.lastLoginTime = lastLoginTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(LocalDateTime lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }
}
