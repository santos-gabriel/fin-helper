class DateUtil {
  static String getMonthExtensive(String date) {
    switch (DateTime.parse(date).month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Desembro';
      default:
        return '';
    }
  }

  static int getYear(String date) {
    return DateTime.parse(date).year;
  }

  static int getDay(String date) {
    return DateTime.parse(date).day;
  }
}
