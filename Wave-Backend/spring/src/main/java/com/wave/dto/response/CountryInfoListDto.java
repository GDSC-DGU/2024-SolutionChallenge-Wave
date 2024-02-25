package com.wave.dto.response;


import com.wave.domain.Country;
import lombok.Builder;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Builder
public record CountryInfoListDto(
        List<CountryInfoDto> emergency,
        List<CountryInfoDto> alert,
        List<CountryInfoDto> caution,
        List<Integer> important,
        List<Integer> donatePossibleList
) {
    @Builder
    public record CountryInfoDto(
            int id,
            boolean isPossible
    ) {
        public static CountryInfoDto of(int id, boolean isPossible) {
            return CountryInfoDto.builder()
                    .id(id)
                    .isPossible(isPossible)
                    .build();
        }
    }

    public static CountryInfoListDto of(List<Country> emergencyCountries, List<Country> alertCountries, List<Country> cautionCountries, List<Country> donateCountries) {
        List<CountryInfoDto> emergencyList = emergencyCountries.stream()
                .map(country -> CountryInfoDto.of(country.getId().intValue(), country.isDonate()))
                .collect(Collectors.toList());

        List<CountryInfoDto> alertList = alertCountries.stream()
                .map(country -> CountryInfoDto.of(country.getId().intValue(), country.isDonate()))
                .collect(Collectors.toList());

        List<CountryInfoDto> cautionList = cautionCountries.stream()
                .map(country -> CountryInfoDto.of(country.getId().intValue(), country.isDonate()))
                .collect(Collectors.toList());

        List<CountryInfoDto> donateList = donateCountries.stream()
                .map(country -> CountryInfoDto.of(country.getId().intValue(), country.isDonate()))
                .toList();

        List<Integer> important = Stream.of(emergencyList, alertList, cautionList, donateList)
                .flatMap(List::stream)
                .map(CountryInfoDto::id)
                .collect(Collectors.toList());

        return CountryInfoListDto.builder()
                .emergency(emergencyList)
                .alert(alertList)
                .caution(cautionList)
                .important(important)
                .donatePossibleList(donateCountries.stream()
                        .map(country -> country.getId().intValue())
                        .collect(Collectors.toList()))
                .build();
    }
}