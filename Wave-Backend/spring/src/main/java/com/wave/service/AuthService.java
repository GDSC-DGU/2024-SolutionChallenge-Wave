package com.wave.service;


import com.wave.domain.User;
import com.wave.dto.request.AuthSignInDto;
import com.wave.dto.response.JwtTokenDto;
import com.wave.dto.type.ERole;
import com.wave.dto.type.ESocialType;
import com.wave.dto.type.ErrorCode;
import com.wave.exception.CommonException;
import com.wave.repository.DonationCountryRepository;
import com.wave.repository.UserRepository;
import com.wave.utility.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.EnumSet;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final DonationCountryRepository donationCountryRepository;
    private final JwtUtil jwtUtil;

    //0.0 구글 로그인
    @Transactional
    public JwtTokenDto login(AuthSignInDto authSignInDto, ESocialType socialType) {
        if (!EnumSet.of(ESocialType.GOOGLE).contains(socialType)) {
            throw new CommonException(ErrorCode.INVALID_SOCIAL_TYPE);
        }

        String serialId = authSignInDto.serialId();
        User user = userRepository.findBySerialId(serialId)
                .orElseGet(() -> userRepository.save(User.createUser(authSignInDto.displayName(), serialId, ERole.USER)));

        JwtTokenDto jwtTokenDto = jwtUtil.generateTokens(user.getId(), user.getRole());
        user.updateRefreshTokenAndLoginStatus(jwtTokenDto.refreshToken(), true);

        return jwtTokenDto;
    }


    //3.4 회원 탈퇴
    @Transactional
    public void deleteUser(Long userId) {
        donationCountryRepository.deleteByUserId(userId);
        userRepository.deleteById(userId);
    }


    //3.5 토큰 재요청
    @Transactional
    public JwtTokenDto refresh(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        JwtTokenDto jwtTokenDto = jwtUtil.generateTokens(user.getId(), user.getRole());
        user.updateRefreshToken(jwtTokenDto.refreshToken());

        return jwtTokenDto;
    }
}
