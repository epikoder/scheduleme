class Workspace {
  const Workspace({required this.name});
  final String name;

  factory Workspace.from(dynamic jsonMap) {
    final name = jsonMap["name"];
    return Workspace(name: name);
  }
}
