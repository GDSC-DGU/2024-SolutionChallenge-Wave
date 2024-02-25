package com.wave.dto.response;

import com.wave.domain.Country;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record CountrySearchInfoDto(

        @NotNull(message = "id는 필수값입니다.")
        int id,

        @NotNull(message = "country는 필수값입니다.")
        String country,

        @NotNull(message = "category은 필수값입니다.")
        String category,

        @NotNull(message = "mainTitle은 필수값입니다.")
        String mainTitle,

        @NotNull(message = "subTitle은 필수값입니다.")
        String subTitle,

        @NotNull(message = "image은 필수값입니다.")
        String image,

        @NotNull(message = "views은 필수값입니다.")
        int views
) {

    public static CountrySearchInfoDto of(Country country) {
        return CountrySearchInfoDto.builder()
                .id(country.getId().intValue())
                .country(country.getName())
                .category(country.getCategory().name())
                .mainTitle(country.getMainTitle())
                .subTitle(country.getSubTitle())
                .image(country.getImageUrl())
                .views(country.getViews())
                .build();
    }
}
