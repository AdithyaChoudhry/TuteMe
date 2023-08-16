class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String Subject;
  final String PhoneNumber;
  final String Address;
  final String Classes;
  final String Fees;

  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.Subject,
    required this.Address,
    required this.PhoneNumber,
    required this.Fees,
    required this.Classes,
    required this.isDarkMode,
  });
}