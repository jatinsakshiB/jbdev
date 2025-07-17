extension EnumListParser<T extends Enum> on List<T> {
  T fromString(String? value, {T? fallback}) {
    return firstWhere((e) => e.name == value, orElse: () => fallback ?? first);
  }
}
