package com.wave.dto.response;

import com.wave.domain.Country;
import lombok.Builder;

import java.util.List;

@Builder
public record CountrySearchListInfoDto(
        List<CountrySearchInfoDto> emergency,
        List<CountrySearchInfoDto> alert,
        List<CountrySearchInfoDto> caution
) {
    @Builder
    public record CountrySearchInfoDto(
            int id,
            String country,
            String category,
            String mainTitle,
            String subTitle,
            String image,
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

    public static CountrySearchListInfoDto of(List<Country> emergency, List<Country> alert, List<Country> caution) {
        return CountrySearchListInfoDto.builder()
                .emergency(emergency.stream()
                        .map(CountrySearchInfoDto::of)
                        .toList())
                .alert(alert.stream()
                        .map(CountrySearchInfoDto::of)
                        .toList())
                .caution(caution.stream()
                        .map(CountrySearchInfoDto::of)
                        .toList())
                .build();
    }
}
