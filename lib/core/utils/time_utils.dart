class TimerUtils{

  static String formatMilliseconds(int milliseconds) {
    int seconds = milliseconds ~/ 1000;
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    seconds = seconds % 60;

    // Formatea la cadena para mostrar dos dígitos para horas, minutos y segundos.
    // Ejemplo: "02:04:05"
    String formattedTime = "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    return formattedTime;
  }
}