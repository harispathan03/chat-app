class StringHelper {
  static String getTwoChars(String text) {
    List<String> words = text.split(" ");
    if (words.length == 1) {
      return text[0].toUpperCase() + text[0].toUpperCase();
    }
    return text[0].toUpperCase() + words[1][0].toUpperCase();
  }

  static String generateChatId(String selfUserEmail, String intendedUserEmail) {
    List<String> users = [selfUserEmail, intendedUserEmail];
    users.sort();
    return users.join("_");
  }

  static String getChatId(String selfUserEmail, String documentId) {
    var arr = documentId.split("_");
    String email = arr[0] == selfUserEmail ? arr[1] : arr[0];
    return email;
  }
}
