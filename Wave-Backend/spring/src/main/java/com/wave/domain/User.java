package com.wave.domain;

import com.wave.dto.type.EAmountBadge;
import com.wave.dto.type.ECountBadge;
import com.wave.dto.type.ERole;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "nickname", nullable = false)
    private String nickname;

    @Column(name = "total_donation")
    private int totalDonation;

    @Column(name = "total_donation_cnt")
    private int totalDonationCnt;

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column(name = "serial_id", nullable = false, unique = true)
    private String serialId;

    @Column(name = "is_login", columnDefinition = "TINYINT(1)")
    private Boolean isLogin;

    @Column(name = "is_light_on", columnDefinition = "TINYINT(1)")
    private Boolean isLightOn;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private ERole role;

    @Column(name = "recent_amount_badge")
    @Enumerated(EnumType.STRING)
    private EAmountBadge recentAmountBadge;

    @Column(name = "recent_count_badge")
    @Enumerated(EnumType.STRING)
    private ECountBadge recentCountBadge;

    @ElementCollection(targetClass = ECountBadge.class, fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    @CollectionTable(name = "user_count_badges", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "count_badge")
    private Set<ECountBadge> countBadges = new HashSet<>();

    @ElementCollection(targetClass = EAmountBadge.class, fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    @CollectionTable(name = "user_amount_badges", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "amount_badge")
    private Set<EAmountBadge> amountBadges = new HashSet<>();

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DonationCountry> donations = new ArrayList<>();



    @Builder
    private User(String nickname, int totalDonation, int totalDonationCnt, String refreshToken, String serialId, ERole role, LocalDateTime createdAt) {
        this.nickname = nickname;
        this.totalDonation = totalDonation;
        this.refreshToken = refreshToken;
        this.serialId = serialId;
        this.role = role;
        this.isLightOn = false;
        this.totalDonationCnt = totalDonationCnt;
        this.createdAt = createdAt;
    }

    public static User createUser(String nickname, String serialId, ERole role) {
        return User.builder()
                .nickname(nickname)
                .totalDonation(0)
                .totalDonationCnt(0)
                .serialId(serialId)
                .role(role)
                .createdAt(LocalDateTime.now())
                .build();
    }

    public void updateRefreshTokenAndLoginStatus(String refreshToken, Boolean isLogin) {
        this.refreshToken = refreshToken;
        this.isLogin = isLogin;
    }

    public void updateUserDonation(int donation) {
        this.totalDonation += donation;
        this.totalDonationCnt += 1;

        if(totalDonationCnt == 1) {
            addECountBadge(ECountBadge.FIRST_COUNT_BADGE);
            updateRecentCountBadge(ECountBadge.FIRST_COUNT_BADGE);
        } else if(totalDonationCnt == 5) {
            addECountBadge(ECountBadge.SECOND_COUNT_BADGE);
            updateRecentCountBadge(ECountBadge.SECOND_COUNT_BADGE);
        } else if(totalDonationCnt == 10) {
            addECountBadge(ECountBadge.THIRD_COUNT_BADGE);
            updateRecentCountBadge(ECountBadge.THIRD_COUNT_BADGE);
        } else if(totalDonationCnt == 50) {
            addECountBadge(ECountBadge.FOURTH_COUNT_BADGE);
            updateRecentCountBadge(ECountBadge.FOURTH_COUNT_BADGE);
        } else if(totalDonationCnt == 100) {
            addECountBadge(ECountBadge.FIFTH_COUNT_BADGE);
            updateRecentCountBadge(ECountBadge.FIFTH_COUNT_BADGE);
        }


        if(totalDonation >= 1000) {
            addEAmountBadge(EAmountBadge.THIRD_AMOUNT_BADGE);
            addEAmountBadge(EAmountBadge.SECOND_AMOUNT_BADGE);
            addEAmountBadge(EAmountBadge.FIRST_AMOUNT_BADGE);
            updateRecentAmountBadge(EAmountBadge.THIRD_AMOUNT_BADGE);

        } else if(totalDonation >= 100) {
            addEAmountBadge(EAmountBadge.SECOND_AMOUNT_BADGE);
            addEAmountBadge(EAmountBadge.FIRST_AMOUNT_BADGE);
            updateRecentAmountBadge(EAmountBadge.SECOND_AMOUNT_BADGE);
        } else if(totalDonation >= 10) {
            addEAmountBadge(EAmountBadge.FIRST_AMOUNT_BADGE);
            updateRecentAmountBadge(EAmountBadge.FIRST_AMOUNT_BADGE);
        }
    }

    public void addDonation(DonationCountry donationCountry) {
        donations.add(donationCountry);
    }

    public void updateRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public void addECountBadge(ECountBadge badge) {
        countBadges.add(badge);
        updateLightStatus(true);
    }


    public void addEAmountBadge(EAmountBadge badge) {
        amountBadges.add(badge);
        updateLightStatus(true);
    }

    public void updateLightStatus(Boolean isLightOn) {
        this.isLightOn = isLightOn;
    }

    public void updateRecentCountBadge(ECountBadge badge) {
        this.recentCountBadge = badge;
    }

    public void updateRecentAmountBadge(EAmountBadge badge) {
        this.recentAmountBadge = badge;
    }

    public void deleteRecentCountBadge() {
        this.recentCountBadge = null;
    }

    public void deleteRecentAmountBadge() {
        this.recentAmountBadge = null;
    }
}
