package com.example.controller;

import com.example.model.LoginRequest;
import com.example.model.LoginResponse;
import com.example.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class AuthController {

    private final AuthService authService;

    @Autowired
    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest request) {
        LoginResponse response = new LoginResponse();
        
        // 验证账号密码
        if (authService.validateCredentials(request.getUsername(), request.getPassword())) {
            // 生成令牌并更新最后登录时间
            String token = authService.login(request.getUsername());
            
            response.setSuccess(true);
            response.setMessage("登录成功");
            response.setToken(token); 
        } else {
            response.setSuccess(false);
            response.setMessage("账号或密码错误");
        }
        
        return ResponseEntity.ok(response);
    }
}