package com.wave.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "`news`")
public class News {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Lob
    @Column(name = "news_image", nullable = false, columnDefinition = "TEXT")
    private String newsImageUrl;

    @Lob
    @Column(name = "news_title", nullable = false, columnDefinition = "TEXT")
    private String newsTitle;

    @Lob
    @Column(name = "news_url", nullable = false, columnDefinition = "TEXT")
    private String newsUrl;


    @Column(name = "date", nullable = false)
    private LocalDate date;

    @JoinColumn(name = "country_id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Country country;

    @Builder
    public News(String newsImageUrl, String newsTitle, String newsUrl, LocalDate date, Country country) {
        this.newsImageUrl = newsImageUrl;
        this.newsTitle = newsTitle;
        this.newsUrl = newsUrl;
        this.date = date;
        this.country = country;
    }

    public static News createNews(String newsImageUrl, String newsTitle, String newsUrl, LocalDate date, Country country) {
        News news = News.builder()
                .newsImageUrl(newsImageUrl)
                .newsTitle(newsTitle)
                .newsUrl(newsUrl)
                .date(date)
                .country(country)
                .build();
        country.addNews(news);

        return news;
    }
}
