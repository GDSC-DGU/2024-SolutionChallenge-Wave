package com.wave.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record AuthSignInDto(

        @NotNull(message = "serialId은 필수값입니다.")
        @JsonProperty("id")
        String serialId,

        @NotNull(message = "displayName은 필수값입니다.")
        String displayName
) {
}
