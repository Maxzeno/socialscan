const qrDomain = "socialscan.com/qr/";

String dumpQrUrl(data) {
  return "https://$qrDomain${Uri.encodeComponent(data)}";
}

String parseQrUrl(String url) {
  List<String> data = url.split(qrDomain);
  if (data.isEmpty) {
    return ";;;;";
  }
  return Uri.decodeComponent(data.last);
}
