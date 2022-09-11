import 'package:logger/logger.dart';

class Log {

  static final logger = Logger(printer: PrettyPrinter());

  static void i(dynamic message) {
    logger.i(message);
  }

  static void d(dynamic message) {
    logger.d(message);
  }

  static void e(dynamic message) {
    logger.e(message);
  }

}
