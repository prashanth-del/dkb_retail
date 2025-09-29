class UsernameValidation {
  final bool hasChars;
  final bool hasNoSpace;
  final bool hasNoSpecialChars;
  final bool isEmpty;

  const UsernameValidation({
    this.hasChars = false,
    this.hasNoSpace = false,
    this.hasNoSpecialChars = false,
    this.isEmpty = true,
  });

  bool get isValid => !isEmpty && hasChars && hasNoSpace && hasNoSpecialChars;

  UsernameValidation copyWith({
    bool? hasChars,
    bool? hasNoSpace,
    bool? hasNoSpecialChars,
    bool? isEmpty,
  }) {
    return UsernameValidation(
      hasChars: hasChars ?? this.hasChars,
      hasNoSpace: hasNoSpace ?? this.hasNoSpace,
      hasNoSpecialChars: hasNoSpecialChars ?? this.hasNoSpecialChars,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  factory UsernameValidation.check(String username) {
    if (username.isEmpty) {
      return const UsernameValidation(isEmpty: true);
    }
    return UsernameValidation(
      isEmpty: false,
      hasChars: RegExp('[a-zA-Z0-9]').hasMatch(username),
      hasNoSpace: !username.contains(' '),
      hasNoSpecialChars: RegExp(r'^[a-zA-Z0-9]*$').hasMatch(username),
    );
  }
}
