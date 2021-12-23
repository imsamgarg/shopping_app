import 'package:share_plus/share_plus.dart';

mixin ShareMixin {
  Future<void> shareText(String content, {String? subject}) {
    return Share.share(content, subject: subject);
  }

  Future<void> shareFile(
    String path, {
    String? content,
    String? subject,
  }) {
    return Share.shareFiles([path], subject: subject, text: content);
  }
}
