class Enum { constructor(name) { this.name = name; } toString() { return this.constructor.name + "::" + this.name; } }
function setEnumValues(enumType, values) { for (value of values) { enumType[value] = new enumType(value); } }
