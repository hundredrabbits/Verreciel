function setEnumValues (enumType, values) {
  for (value of values) {
    enumType[value] = value
  }
}
