extension StringExtension on String {
  String capitalize() {
    return this.isNotEmpty ? "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}" : "";
  }

  String camelCaseToNormalCase() {
    return this.split(RegExp(r"(?=[A-Z])")).join(" ");
  }

  String enumValueToNormalCase(){
    return this.split('.').last.camelCaseToNormalCase();
  }
}