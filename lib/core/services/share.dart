import 'package:share_plus/share_plus.dart';

class ShareHandler {
  ShareHandler._();

  static void shareLink ({required String link, String? title}){
    Share.share(link, subject: title ?? "Share", );
  }
}