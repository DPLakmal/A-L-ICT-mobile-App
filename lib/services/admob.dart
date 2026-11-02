import 'package:flutter/material.dart';

const String testDevice = '0b60a0dc8901ca7b635b7294ef48b01a';
const int maxFailedLoadAttempts = 3;

class DummyAd {
  DummyAd load() => this;
  void dispose() {}
}

class AdmobService {
  static const String bannerAdUnitId =
      'ca-app-pub-7184513529131669/1021454936';
  static const String iOSInterstitialAdUnitID =
      'ca-app-pub-7184513529131669/3476776620';

  static void initialize() {
    // Google Ads SDK hook point
  }

  static DummyAd createBannerAd() {
    return DummyAd();
  }

  void showBannerAd() {}

  void disposeAds() {}

  void showInterstitialAd() {}
}

class AdWidget extends StatelessWidget {
  final dynamic ad;
  const AdWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
