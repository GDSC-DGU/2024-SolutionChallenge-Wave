package com.wave.controller;

import com.wave.annotation.UserId;
import com.wave.dto.common.ResponseDto;
import com.wave.dto.request.UserDonateDto;
import com.wave.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/users")
public class UserController {

    private final UserService userService;

    //2.1 기부하기
    @PostMapping("/donate")
    public ResponseDto<?> donate(
            @RequestBody UserDonateDto userDonateDto,
            @UserId Long userId
            ) {
        userService.donate(userDonateDto, userId);
        return ResponseDto.ok(null);
    }

    //3.1 유저 정보
    @GetMapping("/me")
    public ResponseDto<?> getUserInfo(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserInfo(userId));
    }

    //3.2 상세 기부 목록
    @GetMapping("/donate")
    public ResponseDto<?> getUserDonateList(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserDonateList(userId));
    }

    //3.4 기부 gif 상태
    @GetMapping("/light")
    public ResponseDto<?> getUserLightStatus(@UserId Long userId) {
        return ResponseDto.ok(userService.getUserLightStatus(userId));
    }


    //3.7 새로운 배지 획득 판단 api
    @GetMapping("/new-badge")
    public ResponseDto<?> getNewBadge(@UserId Long userId) {
        return ResponseDto.ok(userService.getNewBadge(userId));
    }

}
