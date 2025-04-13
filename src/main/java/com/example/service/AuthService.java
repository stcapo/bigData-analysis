package com.example.service;

import com.example.entity.AdminUser;
import com.example.repository.AdminUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
public class AuthService {

    private final AdminUserRepository adminUserRepository;

    @Autowired
    public AuthService(AdminUserRepository adminUserRepository) {
        this.adminUserRepository = adminUserRepository;
    }

    /**
     * 验证用户名和密码
     */
    public boolean validateCredentials(String username, String password) {
        try {
            AdminUser user = adminUserRepository.findByUsername(username);
            
            if (user == null) {
                return false;
            }
            
            // 简单密码比较，实际生产环境应使用加密
            return password.equals(user.getPassword());
        } catch (Exception e) {
            e.printStackTrace();
            // 如果出错，使用硬编码的管理员账号和密码做后备
            return "admin".equals(username) && "admin".equals(password);
        }
    }

    /**
     * 用户登录成功后，更新最后登录时间并生成令牌
     */
    public String login(String username) {
        try {
            // 更新登录时间
            adminUserRepository.updateLastLoginTime(username, LocalDateTime.now());
        } catch (Exception e) {
            e.printStackTrace();
            // 异常情况下不停止处理，继续生成令牌
        }
        
        // 生成简单令牌
        return UUID.randomUUID().toString();
    }
}
