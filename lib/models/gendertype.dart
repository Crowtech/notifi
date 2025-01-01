enum GenderType {
  MALE("Male"),
  FEMALE("Female"),
  UNDEFINED("Undefined"),
  NONBINARY_NONCONFORMING("Non Binary/Non Conforming"),
  PREFER_NOT_TO_RESPOND("Prefer Not To Respond");

  const GenderType(this.name);
  final String name;
}
