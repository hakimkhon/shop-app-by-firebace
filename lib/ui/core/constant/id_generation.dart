class IdGeneration {
  static int id() {
    // Hozirgi vaqtni olish
  DateTime now = DateTime.now();

  // Hozirgi vaqtni formatlash (HHMMSS)
  String formattedTime = '${now.hour.toString().padLeft(2, '0')}'
      '${now.minute.toString().padLeft(2, '0')}'
      '${now.second.toString().padLeft(2, '0')}';

    return int.parse(formattedTime);
  }
}
