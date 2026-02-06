class UsefulFunctionUtil {
  static String formatPhoneNumber(String phoneNumber) {
    // Check if the phone number starts with a '+'
    if (phoneNumber.startsWith('+')) {
      // Extract the country code and the rest of the phone number
      String countryCode = phoneNumber.substring(
          0, phoneNumber.indexOf(' ') != -1 ? phoneNumber.indexOf(' ') : 3);
      String number =
          phoneNumber.substring(countryCode.length).replaceAll(' ', '');

      // Format the number part with masking
      String formattedNumber = '';
      for (int i = 0; i < number.length; i++) {
        if (i < 3 || i >= number.length - 4) {
          formattedNumber += number[i];
        } else if (i == 3) {
          formattedNumber += ' **** ';
        } else {
          formattedNumber += '*';
        }
      }

      return '$countryCode $formattedNumber';
    } else {
      // Handle phone numbers without a '+'
      String number = phoneNumber.replaceAll(' ', '');

      // Format the number part with masking
      String formattedNumber = '';
      for (int i = 0; i < number.length; i++) {
        if (i < 2 || i >= number.length - 4) {
          formattedNumber += number[i];
        } else if (i == 2) {
          formattedNumber += ' **** ';
        } else {
          formattedNumber += '*';
        }
      }

      return formattedNumber;
    }
  }
}
