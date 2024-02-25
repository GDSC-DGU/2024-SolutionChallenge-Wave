package com.wave.dto.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EAmountBadge {
    FIRST_AMOUNT_BADGE("10wave donation badge"),
    SECOND_AMOUNT_BADGE("100wave donation badge"),
    THIRD_AMOUNT_BADGE("1000wave donation badge"),

    ;

    private final String description;
}
