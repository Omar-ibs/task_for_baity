import 'package:intl/intl.dart';

class FormatDate {
  static String formatDate(String dateString) {
    // Parse the incoming date string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Get the current date and time
    DateTime now = DateTime.now();

    // Calculate the difference in time
    Duration difference = now.difference(dateTime);

    // Format based on conditions
    if (difference.inMinutes < 60) {
      // Less than an hour ago
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      // Less than a day ago
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1 && difference.inDays < 2) {
      // Yesterday
      String formattedTime =
          DateFormat('HH:mm').format(dateTime); // Format as 10:00
      return 'Yesterday ($formattedTime)';
    } else {
      // Specific date
      return DateFormat('yyyy/MM/dd (HH:mm)')
          .format(dateTime); // Customize the date format as needed
    }
  }
}
