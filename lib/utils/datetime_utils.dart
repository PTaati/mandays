class DateTimeUtils {
  static String getDurationFormat(int durationInSeconds) {
    return Duration(seconds: durationInSeconds)
        .toString()
        .split('.')
        .first
        .padLeft(8, "0");
  }
}
