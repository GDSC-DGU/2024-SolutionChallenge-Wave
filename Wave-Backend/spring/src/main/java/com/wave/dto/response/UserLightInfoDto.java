package com.wave.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder
public record UserLightInfoDto(

        @JsonProperty("isLightOn")
        Boolean isLightOn
) {

    public static UserLightInfoDto of(boolean isLightOn) {
        return UserLightInfoDto.builder()
                .isLightOn(isLightOn)
                .build();
    }
}
