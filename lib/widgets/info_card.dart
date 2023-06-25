import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/model/constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  _launchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kForegroundColor,
      title: Image.asset('assets/logo.png'),
      content: SizedBox(
        height: 72,
        child: Column(
          children: [
            Text.rich(
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              TextSpan(
                text: 'Made with ',
                children: [
                  WidgetSpan(
                    child: Image.asset(
                      'assets/heart.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const TextSpan(text: ' by Mitesh Tank'),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _launchUrl('https://github.com/codewithmitesh'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/github.png'),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                GestureDetector(
                  onTap: () =>
                      _launchUrl('https://www.linkedin.com/in/mitesh-tank'),
                  child: const Image(
                    height: 30,
                    image: AssetImage('assets/linkedin.jpg'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
