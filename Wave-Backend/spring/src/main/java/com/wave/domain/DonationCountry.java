package com.wave.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "donation_country")
public class DonationCountry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @JoinColumn(name = "country_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Country country;

    @JoinColumn(name = "user_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @Column(name = "donation")
    private int donation;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Builder
    private DonationCountry(Country country, User user, int donation, LocalDateTime createdAt) {
        this.country = country;
        this.user = user;
        this.donation = donation;
        this.createdAt = createdAt;
    }

    public static DonationCountry createDonationCountry(Country country, User user, int donation) {
        DonationCountry donationCountry = DonationCountry.builder()
                .country(country)
                .user(user)
                .donation(donation)
                .createdAt(LocalDateTime.now())
                .build();
        user.addDonation(donationCountry);

        return donationCountry;
    }

    public void updateDonation(int donation) {
        this.donation += donation;
    }

}
