package com.wave.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

import java.util.List;

@Builder
public record CountryDataListDto(

        List<CountryDataDto> countryDataList
) {
        @Builder
        public record CountryDataDto(

                @NotNull(message = "id은 필수값입니다.")
                Integer id,

                @JsonProperty("korean_name")
                @NotNull(message = "koreanName은 필수값입니다.")
                String koreanName,

                @JsonProperty("image_url")
                @NotNull(message = "englishName은 필수값입니다.")
                String imageUrl,

                @JsonProperty("detail_image_url")
                @NotNull(message = "detailImageUrl 필수값입니다.")
                String detailImageUrl,

                @JsonProperty("name")
                @NotNull(message = "name은 필수값입니다.")
                String name,

                @JsonProperty("category")
                @NotNull(message = "category은 필수값입니다.")
                String category,

                @JsonProperty("is_donate")
                @NotNull(message = "isDonate은 필수값입니다.")
                Boolean isDonate, // JSON 문자열을 Boolean으로 변경하였습니다.

                @JsonProperty("casualties")
                Integer casualties,

                @JsonProperty("main_title")
                @NotNull(message = "mainTitle은 필수값입니다.")
                String mainTitle,

                @JsonProperty("sub_title")
                @NotNull(message = "subTitle은 필수값입니다.")
                String subTitle,

                @JsonProperty("image_producer")
                @NotNull(message = "imageProducer은 필수값입니다.")
                String imageProducer,

                @JsonProperty("detail_image_title")
                @NotNull(message = "detailImageTitle은 필수값입니다.")
                String detailImageTitle,

                @JsonProperty("detail_image_producer")
                @NotNull(message = "detailImageProducer은 필수값입니다.")
                String detailImageProducer,

                @JsonProperty("title1")
                @NotNull(message = "content1은 필수값입니다.")
                String title1,

                @JsonProperty("content1")
                @NotNull(message = "content1은 필수값입니다.")
                String content1,

                @JsonProperty("title2")
                @NotNull(message = "title2은 필수값입니다.")
                String title2,

                @JsonProperty("content2")
                @NotNull(message = "content2은 필수값입니다.")
                String content2
        ) {

        }
}
