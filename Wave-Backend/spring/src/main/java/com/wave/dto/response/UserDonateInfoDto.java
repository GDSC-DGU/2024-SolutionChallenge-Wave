package com.wave.dto.response;

import com.wave.domain.DonationCountry;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import org.springframework.cglib.core.Local;

import java.sql.Time;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Builder
public record UserDonateInfoDto(

        @NotNull(message = "totalWave은 필수값입니다.")
        int totalWave,

        List<Donation> donateList
) {

    @Builder
    public record Donation(
            int id,
            int wave,
            String date,
            String time,
            String country

    ) {

        public static Donation of(DonationCountry donationCountry) {
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM.dd");

            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            String formattedDate = donationCountry.getCreatedAt().format(dateFormatter);
            String formattedTime = donationCountry.getCreatedAt().format(timeFormatter);

            return Donation.builder()
                    .id(donationCountry.getCountry().getId().intValue())
                    .wave(donationCountry.getDonation())
                    .date(formattedDate)
                    .time(formattedTime)
                    .country(donationCountry.getCountry().getName())
                    .build();
        }
    }

    public static UserDonateInfoDto of(List<DonationCountry> donationCountry, int totalWave) {
        return UserDonateInfoDto.builder()
                .totalWave(totalWave)
                .donateList(donationCountry.stream()
                        .map(Donation::of)
                        .toList())
                .build();
    }
}
