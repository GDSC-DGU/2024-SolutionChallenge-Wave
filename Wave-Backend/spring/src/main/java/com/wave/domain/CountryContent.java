package com.wave.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "country_content")
public class CountryContent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Lob
    @Column(name = "title", columnDefinition = "TEXT")
    private String title;

    @Lob
    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @JoinColumn(name = "country_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Country country;

    @Builder
    private CountryContent(String title, String content, Country country) {
        this.title = title;
        this.content = content;
        this.country = country;
    }

    public static CountryContent createCountryContent(String title, String content, Country country) {
        CountryContent countryContent = CountryContent.builder()
                .title(title)
                .content(content)
                .country(country)
                .build();
        country.addCountryContent(countryContent);

        return countryContent;
    }
}
