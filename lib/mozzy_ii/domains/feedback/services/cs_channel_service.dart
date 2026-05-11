import 'package:url_launcher/url_launcher.dart';

class CsChannelConfig {
  static const whatsappNumber = String.fromEnvironment(
    'BETA_CS_WHATSAPP',
    defaultValue: '',
  );
}

class CsChannelService {
  static Future<void> openWhatsApp() async {
    if (CsChannelConfig.whatsappNumber.isEmpty) {
      throw Exception('CS channel not configured');
    }

    final url = Uri.parse('https://wa.me/${CsChannelConfig.whatsappNumber}');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch WhatsApp');
    }
  }
}
