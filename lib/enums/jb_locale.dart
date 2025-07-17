import 'dart:ui';

enum JBLocale {
  en_IN, // English (India)
  sa_IN, // Sanskrit (India)
  hi_IN, // Hindi
  mr_IN, // Marathi
  ta_IN, // Tamil
  te_IN, // Telugu
  bn_IN, // Bengali
  gu_IN, // Gujarati
  kn_IN, // Kannada
  ml_IN, // Malayalam
  pa_IN, // Punjabi
  or_IN, // Odia
  en_US, // English (US)
}

extension JBLocaleExtension on JBLocale {
  Locale get locale {
    final parts = name.split('_');
    return Locale(parts[0], parts[1]);
  }
}