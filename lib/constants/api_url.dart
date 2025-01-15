abstract class ApiURL {
  static const base = "https://api.scheduleme.com";
  static const loginProvider = "$base/login-provider";
  static const login = "$base/login";
  static const signup = "$base/register";

  // spaces
  static const spaces = "$base/spaces";
  static String spaceWithId(String id) => "$base/spaces/$id";
}
