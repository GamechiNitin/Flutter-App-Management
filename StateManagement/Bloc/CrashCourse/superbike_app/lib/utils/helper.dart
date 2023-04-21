import 'package:superbike_app/utils/import.dart';

class Helper {
  static Widget progress() => const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
  static void toast(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          content: Text(message),
          backgroundColor: Colors.teal,
        ),
      );
}
