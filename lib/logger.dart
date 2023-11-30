import 'package:talker/talker.dart';

late final TalkerLogger talker;

void initializeLogging(String logLevel) {
  LogLevel ll = switch (logLevel) {
    "verbose" => LogLevel.verbose,
    "info" => LogLevel.info,
    "warning" => LogLevel.warning,
    "debug" => LogLevel.debug,
    _ => LogLevel.info
  };
  talker = TalkerLogger(settings: TalkerLoggerSettings(level: ll));
}
