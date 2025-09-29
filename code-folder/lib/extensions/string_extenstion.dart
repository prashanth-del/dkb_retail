import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

extension StringExtenstion on String{
  String amountNormalize() {
    return this.replaceAll(',', '').replaceAll(' ', '').replaceAll('.', '').toLowerCase();
  }

  String formatDateLanguage(String language) {
    try {
      if(language == 'ar') {
        var dateFormat = DateFormat("dd-MMM-yyyy");
        // Parse the date string to DateTime
        DateTime date = dateFormat.parse(this);
        // Format date for Arabic
        return "${date.day.toString().padLeft(2, '0')}-${DateFormat('MMM', 'ar').format(date)}-${date.year}";
      }
      return this;
    }
    catch (e){
      return " ";
    }
  }

  String formatDateInLoans(String language) {
    try {
      if(language == 'ar') {
        final inputFormat = DateFormat('dd MMMM yyyy', 'en');
        DateTime date = inputFormat.parse(this);
        return "${date.day.toString().padLeft(2, '0')} ${DateFormat('MMMM', 'ar').format(date)} ${date.year}";
      }
      return this;

    } catch (e) {
      return '-';
    }
  }

  String negativeNumberForRtl(String language) {

    try {
      if(language == 'ar' && startsWith('-')) {
        return '${substring(1)}-';
      }
      return this;

    } catch (e) {
      return '-';
    }
  }

  String getFileExtension(File file) {
    return path.extension(file.path).toLowerCase();
  }

  String getFileDetails(File file) {
    // Get the file extension
    String fileExtension = path.extension(file.path).toLowerCase(); // e.g., ".jpeg"

    // Determine the file type based on the extension
    String fileType;
    if (fileExtension == '.jpg' || fileExtension == '.jpeg') {
      fileType = 'jpeg';
    } else if (fileExtension == '.png') {
      fileType = 'png';
    } else if (fileExtension == '.pdf') {
      fileType = 'pdf';
    } else {
      fileType = 'unknown';
    }
    return fileType;
  }

}