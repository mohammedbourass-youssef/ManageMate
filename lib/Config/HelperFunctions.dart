import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teamtasks/Services/NotificationService.dart';
import 'package:teamtasks/Services/ProjectsService.dart';
import 'package:teamtasks/Services/TaskServices.dart';

class Helperfunctions {
  static void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white,
          onPressed: () {
            // TODO: Add Undo logic if needed
          },
        ),
      ),
    );
  }
    static String formatLoinedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String month = months[date.month - 1];
    return 'Member since $month ${date.day}, ${date.year}';
  }

  static String formatCreatedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String month = months[date.month - 1];
    return 'Created $month ${date.day}, ${date.year}';
  }
  
  static String getFormatTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  static Color getColor(int index) {
    if (index == EnProjectStatus.cancel.index) {
      return Colors.red;
    }
    if (index == EnProjectStatus.comlited.index) {
      return Colors.green;
    }
    if (index == EnProjectStatus.fresh.index) {
      return Colors.deepPurple;
    }
    if (index == EnProjectStatus.inprogress.index) {
      return Colors.orange;
    }
    return Colors.deepPurple;
  }

  static MaterialColor getColorOfStatusTask(int index) {
    if (index == EnTaskSatate.complited.index) {
      return Colors.green;
    }
    if (index == EnTaskSatate.fresh.index) {
      return Colors.blue;
    }
    if (index == EnTaskSatate.inprocessus.index) {
      return Colors.orange;
    }
    if (index == EnTaskSatate.verified.index) {
      return Colors.purple;
    }
    return Colors.deepPurple;
  }

  static Widget getTextForTask(int index) {
    String text = '';
    Color color = Helperfunctions.getColorOfStatusTask(index).shade900;

    if (index == EnTaskSatate.complited.index) {
      text = 'Completed';
    } else if (index == EnTaskSatate.fresh.index) {
      text = 'Fresh';
    } else if (index == EnTaskSatate.inprocessus.index) {
      text = 'In Progress';
    } else if (index == EnTaskSatate.verified.index) {
      text = 'Verified';
    } else {
      text = 'Unknown';
    }
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  static Widget getText(int index) {
    if (index == EnProjectStatus.cancel.index) {
      return Text("Cancelled", style: TextStyle(color: Colors.white));
    }
    if (index == EnProjectStatus.comlited.index) {
      return Text("Completed", style: TextStyle(color: Colors.black));
    }
    if (index == EnProjectStatus.fresh.index) {
      return Text("Fresh", style: TextStyle(color: Colors.white));
    }
    if (index == EnProjectStatus.inprogress.index) {
      return Text("In Progress", style: TextStyle(color: Colors.white));
    }
    return Text("Unknown", style: TextStyle(color: Colors.white));
  }

  static Color getRandomColor() {
    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.white,
    ];
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  static String getInitials(String fullName) {
    if (fullName.trim().isEmpty) return "";

    // Split the name by spaces
    List<String> parts = fullName.trim().split(" ");

    // Take first letter of first and last part
    String first = parts.first[0].toUpperCase();
    String last = parts.length > 1 ? parts.last[0].toUpperCase() : "";

    return "$first$last";
  }

  static String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return weeks == 1 ? 'last week' : '${weeks}w ago';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return months == 1 ? 'last month' : '${months}mo ago';
    } else {
      final years = (diff.inDays / 365).floor();
      return years == 1 ? 'last year' : '${years}y ago';
    }
  }

  static String notificationMessage(int index) {
    if (index == EnNotifyType.sendinvitation.index) {
      return 'Project Invitation';
    } else if (index == EnNotifyType.newtask.index) {
      return 'New Task';
    } else if (index == EnNotifyType.information.index) {
      return 'Information';
    }
    return 'Notification';
  }
}
