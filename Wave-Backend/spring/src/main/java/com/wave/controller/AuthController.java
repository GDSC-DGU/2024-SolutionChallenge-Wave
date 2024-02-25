package com.wave.controller;



import com.wave.annotation.UserId;
import com.wave.dto.common.ResponseDto;
import com.wave.dto.request.AuthSignInDto;
import com.wave.dto.type.ESocialType;
import com.wave.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/auth")
public class AuthController {

    private final AuthService authService;


    //0.0 구글 로그인
    @PostMapping("/google")
    public ResponseDto<?> loginUsingGoogle(
            @RequestBody AuthSignInDto authSignInDto
    ) {
        return ResponseDto.created(authService.login(authSignInDto, ESocialType.GOOGLE));
    }

    //3.4 회원 탈퇴
    @DeleteMapping("/sign-out")
    public ResponseDto<?> deleteUser(@UserId Long userId) {
        authService.deleteUser(userId);
        return ResponseDto.ok(null);
    }

    //3.5 토큰 재요청
    @PostMapping("/refresh")
    public ResponseDto<?> refresh(@UserId Long userId) {
        return ResponseDto.ok(authService.refresh(userId));
    }
}
