import 'dart:io';

class InfoUtil {
  static Future<String> flutterDoctor() async {
    try {
      var result = await Process.run(
        'flutter',
        ['doctor', '-v'],
      );
      return result.stdout ?? result.stderr;
    } catch (e) {
      print(e);
    }
    return '';
  }
}
