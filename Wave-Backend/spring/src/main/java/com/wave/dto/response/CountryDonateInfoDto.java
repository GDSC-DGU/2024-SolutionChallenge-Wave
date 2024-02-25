package com.wave.dto.response;

import com.wave.domain.Country;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record CountryDonateInfoDto(

        @NotNull(message = "id는 필수값입니다.")
        int id,

        @NotNull(message = "country은 필수값입니다.")
        String country,

        @NotNull(message = "category은 필수값입니다.")
        String category,

        @NotNull(message = "mainTitle은 필수값입니다.")
        String mainTitle,

        @NotNull(message = "subTitle은 필수값입니다.")
        String subTitle,

        @NotNull(message = "image은 필수값입니다.")
        String image,

        @NotNull(message = "allWave은 필수값입니다.")
        int allWave,

        @NotNull(message = "lastWave은 필수값입니다.")
        int lastWave,

        @NotNull(message = "casualties은 필수값입니다.")
        int casualties
) {

    public static CountryDonateInfoDto of(Country country) {
        return CountryDonateInfoDto.builder()
                .id(country.getId().intValue())
                .country(country.getName())
                .category(country.getCategory().name())
                .mainTitle(country.getMainTitle())
                .subTitle(country.getSubTitle())
                .image(country.getImageUrl())
                .allWave(country.getTotalWave())
                .lastWave(country.getLastWave())
                .casualties(country.getCasualties())
                .build();
    }
}
