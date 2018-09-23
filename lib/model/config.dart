
class AppConfig {
  static String jwtToken = "";
  static bool isDev = bool.fromEnvironment("dart.vm.product");
  static final String httpPrefix = isDev ? "http://localhost:9876/api" : "https://api.clippingkk.annatarhe.com/api";
}