class User {
  String name;
  int age;
  List<String> professions;

  User({required this.name, required this.age, required this.professions});

  User copyWith({
    String? name,
    int? age,
    List<String>? professions,
  }) =>
      User(
          name: name ?? this.name,
          age: age ?? this.age,
          professions: professions ?? this.professions);
}
