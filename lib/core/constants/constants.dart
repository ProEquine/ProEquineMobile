import 'package:flutter/material.dart';

const appName = 'ProEquine';



// Languages
const defaultLanguage = 'ar';
const Map<String,Locale> languages = {
  'ar':Locale('ar'),
  'en': Locale('en'),
  // 'es':Locale('es'),
};


// Headers
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
