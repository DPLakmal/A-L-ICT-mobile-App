import 'package:flutter/material.dart';

const String testDevice = '0b60a0dc8901ca7b635b7294ef48b01a';
const int maxFailedLoadAttempts = 3;

class _DummyAd {
  _DummyAd load() => this;
  void dispose() {}
}

class AdmobService {
  static const String bannerAdUnitId =
      'ca-app-pub-7184513529131669/1021454936';
  static const String iOSInterstitialAdUnitID =
      'ca-app-pub-7184513529131669/3476776620';

  static void initialize() {
    // Google Ads function held
  }

  static _DummyAd createBannerAd() {
    return _DummyAd();
  }

  void showBannerAd() {}

  void disposeAds() {}

  void showInterstitialAd() {}
}

class AdWidget extends StatelessWidget {
  final dynamic ad;
  const AdWidget({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
