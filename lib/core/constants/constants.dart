import 'package:flutter/material.dart';

const appName = 'ProEquine';

// Languages
const defaultLanguage = 'ar';
const Map<String, Locale> languages = {
  'ar': Locale('ar'),
  'en': Locale('en'),
  // 'es':Locale('es'),
};

// Headers
const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFF323232),
    Color.fromRGBO(255, 255, 252, 0.2),
    Color(0xFF323232),
  ],
  stops: [
    0.1,
    0.5,
    0.9,
  ],
  begin: Alignment(-2.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.mirror,
);
const HEADER_LANGUAGE = 'x-lang';
const HEADER_AUTH = 'authorization';
const DEVICE_ID = 'x-deviceid';
const HEADER_CONTENT_TYPE = 'Content-Type';
const HEADER_ACCEPT = 'accept';

// Notifications Channels
const NOTIFICATIONS_CHANNEL_ID = 'global-channel';
const NOTIFICATIONS_CHANNEL_TITLE = 'Global';
const NOTIFICATIONS_CHANNEL_DESCRIPTION = 'Global Channel';

const kPadding = 15.0;
const kAnimationDuration = Duration(milliseconds: 600);
