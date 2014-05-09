module.exports =
    FIELD_REQUIRED: (name) -> "#{name} is required",
    TOO_DECIMAL_DIGITS: (name, decimalDigits) -> "#{name} should contains at most #{decimalDigits} decimal digits"
    TOO_INTEGER_DIGITS: (name, integerDigits) -> "#{name} should contains at most #{integerDigits} integer digits"
