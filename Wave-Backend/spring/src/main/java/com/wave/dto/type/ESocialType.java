package com.wave.dto.type;

import static java.util.Locale.ENGLISH;

public enum ESocialType {


    GOOGLE,
    ;

    public static ESocialType fromName(String type) {
        return ESocialType.valueOf(type.toUpperCase(ENGLISH));
    }
}
