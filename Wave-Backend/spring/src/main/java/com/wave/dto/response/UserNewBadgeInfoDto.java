package com.wave.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

@Builder
public record UserNewBadgeInfoDto(

        @JsonProperty("amountBadge")
        String amountBadge,

        @JsonProperty("countBadge")
        String countBadge

) {
    public static UserNewBadgeInfoDto of(String amountBadge, String countBadge) {
        return UserNewBadgeInfoDto.builder()
                .amountBadge(amountBadge)
                .countBadge(countBadge)
                .build();
    }
}
