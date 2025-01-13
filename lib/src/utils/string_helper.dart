extension StringUtilsExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String capitalize() {
    if (isNullOrEmpty) return "";
    return "${this![0].toUpperCase()}${this!.substring(1)}";
  }
}

extension NumberUtilsExtension on num? {
  String? get withZeroPrefix {
    if (this == null) return null;
    if (this! < 10) return "0$this";
    return "$this";
  }

  String? get toWorkoutTime {
    if (this == null) return null;
    if (this! < 60) return "${this}s";

    final minutes = this! ~/ 60;
    final seconds = this! % 60;
    return "${minutes}m ${seconds}s";
  }
}
