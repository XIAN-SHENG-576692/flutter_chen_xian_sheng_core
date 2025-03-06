part of library;

extension CharacterConvertor on String {
  decodeHtml() {
    return replaceAll('&amp;', '/')
      .replaceAll("&quot;", "\"")
      .replaceAll("&ldquo;", "“")
      .replaceAll("&rdquo;", "”")
      .replaceAll("<br>", "\n")
      .replaceAll("&gt;", ">")
      .replaceAll("&lt;", "<");
  }
}
