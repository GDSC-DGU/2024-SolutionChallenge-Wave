package com.wave.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.io.Serializable;

@Builder
public record JwtTokenDto(
        @JsonProperty("accessToken")
        @NotNull(message = "access_token은 필수값입니다.")
        String accessToken,

        @JsonProperty("refreshToken")
        String refreshToken

) implements Serializable {
    public static JwtTokenDto of(String accessToken, String refreshToken) {
        return JwtTokenDto.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }
}

