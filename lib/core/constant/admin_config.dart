class AdminConfig {
  static const String adminCode = '2026';

  static const Map<String, String> tracks = {
    'Mobile App': '1',
    'Backend': '2',
    'Cyber Security': '3',
    'Network': '4',
    'Ai & Data Science': '5',
  };

  static bool isValidCode(String? value) => value?.trim() == adminCode;
}
