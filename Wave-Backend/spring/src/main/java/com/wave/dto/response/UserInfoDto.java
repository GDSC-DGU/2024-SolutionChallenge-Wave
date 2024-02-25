package com.wave.dto.response;

import com.wave.domain.User;
import com.wave.dto.type.EAmountBadge;
import com.wave.dto.type.ECountBadge;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.util.List;

@Builder
public record UserInfoDto(

        @NotNull(message = "id는 필수값입니다.")
        int id,

        @NotNull(message = "nickname은 필수값입니다.")
        String nickname,

        @NotNull(message = "totalWave은 필수값입니다.")
        int totalWave,

        @NotNull(message = "donationCountryCnt은 필수값입니다.")
        int donationCountryCnt,

        List<Boolean> countBadges,

        List<Boolean> amountBadges

) {
    public static UserInfoDto of(User user) {
        return UserInfoDto.builder()
                .id(Math.toIntExact(user.getId()))
                .nickname(user.getNickname())
                .totalWave(user.getTotalDonation())
                .donationCountryCnt(user.getDonations().size())
                .countBadges(List.of(
                        user.getCountBadges().contains(ECountBadge.FIRST_COUNT_BADGE),
                        user.getCountBadges().contains(ECountBadge.SECOND_COUNT_BADGE),
                        user.getCountBadges().contains(ECountBadge.THIRD_COUNT_BADGE),
                        user.getCountBadges().contains(ECountBadge.FOURTH_COUNT_BADGE),
                        user.getCountBadges().contains(ECountBadge.FIFTH_COUNT_BADGE)
                ))
                .amountBadges(List.of(
                        user.getAmountBadges().contains(EAmountBadge.FIRST_AMOUNT_BADGE),
                        user.getAmountBadges().contains(EAmountBadge.SECOND_AMOUNT_BADGE),
                        user.getAmountBadges().contains(EAmountBadge.THIRD_AMOUNT_BADGE)
                ))
                .build();
    }
}
