class Validationstring {
 static bool isValidEmail(String email) {
  // Simple regex for email validation
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

}