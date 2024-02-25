package com.wave.dto.response;

import com.wave.domain.Country;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Builder
public record CountryDonateDetailsInfoDto(

        @NotNull(message = "id는 필수값입니다.")
        int id,

        @NotNull(message = "country은 필수값입니다.")
        String country,

        @NotNull(message = "category은 필수값입니다.")
        String category,

        @NotNull(message = "mainTitle은 필수값입니다.")
        String mainTitle,

        @NotNull(message = "subTitle은 필수값입니다.")
        String subTitle,

        @NotNull(message = "image은 필수값입니다.")
        String image,

        @NotNull(message = "imageProducer은 필수값입니다.")
        String imageProducer,

        @NotNull(message = "allWave은 필수값입니다.")
        int allWave,

        @NotNull(message = "lastWave은 필수값입니다.")
        int lastWave,

        @NotNull(message = "casualties은 필수값입니다.")
        int casualties,

        @NotNull(message = "detailImage은 필수값입니다.")
        String detailImage,

        @NotNull(message = "detailImageTitle은 필수값입니다.")
        String detailImageTitle,

        @NotNull(message = "detailImageProducer은 필수값입니다.")
        String detailImageProducer,

        List<ContentInfo> contents,

        List<NewsInfo> news
) {
    @Builder
    public record ContentInfo(
            String title,
            String content
    ) {
        public static ContentInfo of(String title, String content) {
            return ContentInfo.builder()
                    .title(title)
                    .content(content)
                    .build();
        }
    }

    @Builder
    public record NewsInfo(
            String newsImage,
            String newsTitle,
            String newsUrl,
            String date
    ) {
        public static NewsInfo of(String newsImage, String newsTitle, String newsUrl, String date) {
            return NewsInfo.builder()
                    .newsImage(newsImage)
                    .newsTitle(newsTitle)
                    .newsUrl(newsUrl)
                    .date(date)
                    .build();
        }
    }

    public static CountryDonateDetailsInfoDto of(Country country) {
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");

        return CountryDonateDetailsInfoDto.builder()
                .id(country.getId().intValue())
                .country(country.getName())
                .category(country.getCategory().name())
                .mainTitle(country.getMainTitle())
                .subTitle(country.getSubTitle())
                .image(country.getImageUrl())
                .imageProducer(country.getImageProducer())
                .allWave(country.getTotalWave())
                .lastWave(country.getLastWave())
                .casualties(country.getCasualties())
                .contents(country.getCountryContents().stream()
                        .map(countryContent -> ContentInfo.of(countryContent.getTitle(), countryContent.getContent()))
                        .toList())
                .detailImage(country.getDetailImageUrl())
                .detailImageTitle(country.getDetailImageTitle())
                .detailImageProducer(country.getDetailImageProducer())
                .news(country.getNews() != null ? country.getNews().stream()
                        .map(news -> NewsInfo.of(news.getNewsImageUrl(), news.getNewsTitle(), news.getNewsUrl(), news.getDate().format(dateFormatter)))
                        .toList() : null)
                .build();
    }

}
