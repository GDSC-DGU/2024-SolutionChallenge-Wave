package com.wave.dto.response;

import com.wave.domain.Country;
import lombok.Builder;

import java.util.List;

@Builder
public record CountryDonateListInfoDto(

        List<CountryDonateInfoDto> countries
) {
    @Builder
    public record CountryDonateInfoDto(
            int id,
            String country,
            String category,
            String mainTitle,
            String subTitle,
            String image,
            int allWave,
            int lastWave,
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

    public static CountryDonateListInfoDto of(List<Country> donateCountries) {
        return CountryDonateListInfoDto.builder()
                .countries(donateCountries.stream()
                        .map(CountryDonateInfoDto::of)
                        .toList())
                .build();
    }

}
