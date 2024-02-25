package com.wave.domain;


import com.wave.dto.type.ECategory;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "`country`")
public class Country {

    @Id
    @Column(name = "id", unique = true, nullable = false)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "korean_name", nullable = false)
    private String koreanName;

    @Column(name = "category", nullable = false)
    @Enumerated(EnumType.STRING)
    public ECategory category;

    @Column(name = "is_donate", columnDefinition = "TINYINT(1)")
    private boolean isDonate;

    @Column(name = "total_wave")
    private Integer totalWave;

    @Column(name = "last_wave")
    private Integer lastWave;

    @Column(name = "casualties")
    private Integer casualties;

    @Column(name = "views")
    private Integer views;

    @Column(name = "main_title", nullable = false)
    private String mainTitle;

    @Column(name = "sub_title", nullable = false)
    private String subTitle;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "imageProducer", nullable = false)
    private String imageProducer;

    @Column(name = "detail_image_url", nullable = false)
    private String detailImageUrl;

    @Column(name = "detail_image_title", nullable = false)
    private String detailImageTitle;

    @Column(name = "detail_image_producer", nullable = false)
    private String detailImageProducer;

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<CountryContent> countryContents = new ArrayList<>();

    @OneToMany(mappedBy = "country", fetch = FetchType.LAZY)
    private List<News> news = new ArrayList<>();

    @Builder
    private Country(Long id, String name, String koreanName, ECategory category, boolean isDonate, Integer casualties, String mainTitle, String subTitle, String imageUrl, String imageProducer, String detailImageUrl, String detailImageTitle, String detailImageProducer) {
        this.id = id;
        this.name = name;
        this.koreanName = koreanName;
        this.category = category;
        this.isDonate = isDonate;
        this.casualties = casualties;
        this.mainTitle = mainTitle;
        this.views = 0;
        this.totalWave = 0;
        this.lastWave = 0;
        this.subTitle = subTitle;
        this.imageUrl = imageUrl;
        this.imageProducer = imageProducer;
        this.detailImageUrl = detailImageUrl;
        this.detailImageTitle = detailImageTitle;
        this.detailImageProducer = detailImageProducer;
    }

    public static Country createCountry(Long id, String name, String koreanName, ECategory category, boolean isDonate, Integer casualties, String mainTitle, String subTitle, String imageUrl, String imageProducer, String detailImageUrl, String detailImageTitle, String detailImageProducer) {
        return Country.builder()
                .id(id)
                .name(name)
                .koreanName(koreanName)
                .category(category)
                .isDonate(isDonate)
                .casualties(casualties)
                .mainTitle(mainTitle)
                .subTitle(subTitle)
                .imageUrl(imageUrl)
                .imageProducer(imageProducer)
                .detailImageUrl(detailImageUrl)
                .detailImageTitle(detailImageTitle)
                .detailImageProducer(detailImageProducer)
                .build();
    }


    public void addCountryContent(CountryContent countryContent) {
        this.countryContents.add(countryContent);
    }

    public void addNews(News news) {
        this.news.add(news);
    }

    public void updateViews() {
        if(this.views != null){
            this.views++;
        } else {
            this.views = 1;
        }
    }

    public void updateWave(int wave) {
        this.totalWave += wave;
        this.lastWave = wave;
    }


}
