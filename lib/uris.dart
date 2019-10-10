class Uris {
  static String string(Uri uri) => "${uri.toString()}${uri.hasFragment ? "#${uri.fragment}" : ""}";
}
