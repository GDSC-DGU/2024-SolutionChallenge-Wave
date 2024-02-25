package com.wave.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record UserDonateDto(

        @JsonProperty("id")
        @NotNull(message = "id는 필수값입니다.")
        Long countryId,

        @NotNull(message = "money는 필수값입니다.")
        int money
) {
}
