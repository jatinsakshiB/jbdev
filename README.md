
# 📦 `jbdev` (Internal Utility Package)

A collection of extensions, widgets, and helpers to streamline JBDEV app development.
Maintained by [Jatin Batra](https://jbdev.in) — not for public use.

---

## 🔧 Core Setup

Wrap your app:

```dart
App.init();
runApp(Jbdev(
builder: (ctx) => MaterialApp(navigatorKey: navKey, home: HomePage()),
));
```

Quick config:

```dart
App.currencySymbol = "₹";
App.locale = JBLocale.en_IN;
App.timezone = JBTimezone.ist;
```

---

## ⚙️ `JBConfig` Settings

Customize:

* Default button styles
* Popup / BottomSheet UI
* Locale, timezone, symbol

Override widgets:

```dart
JBConfig.defCurrencySymbol = '₹';
JBConfig.defLocale = JBLocale.en_IN;
JBConfig.defTimezone = JBTimezone.ist;

JBConfig.loadingPopupWidget = (ctx) => MyCustomLoading();
JBConfig.popupWidget = (ctx, popup) => MyCustomPopup(popup);
JBConfig.bottomSheetWidget = (ctx, popup) => MyBottomSheet(popup);

JBConfig.bottomSheetMaxHeight = 0.8;
JBConfig.bottomSheetBorderRadius = 16;
JBConfig.bottomSheetBackgroundColor = Colors.white;
JBConfig.bottomSheetBarrierBlur = 4;

JBConfig.popupBarrierColor = Colors.black54;
JBConfig.popupBorderRadius = 16;
JBConfig.popupPadding = EdgeInsets.all(26);
JBConfig.popupBarrierBlur = 4;
JBConfig.popupBackgroundColor = Colors.white;

JBConfig.defaultButton = JBButtonProperties(
color: Colors.blue,
textColor: Colors.white,
);

JBConfig.buttons = {
"success": JBButtonProperties(color: Colors.green, textColor: Colors.white),
"error": JBButtonProperties(color: Colors.red, textColor: Colors.white),
"primary:light": JBButtonProperties(color: Colors.blue.shade100, textColor: Colors.black),
// Add more types as needed
};

```

---

## 📲 SharedPreferencesManager

* `save()`, `get()`, `remove()`, `clear()`
* Supports `String`, `bool`, `int`, `double`, `List<String>`, `toJson()` objects

---

## 🔄 Utilities

### Loading

```dart
showLoading(ctx); // show
hideLoading(); // hide
```

### Popups

```dart
showJBPopup(ctx, popup);
hideJBPopup("id");
hideJBAllPopups();
```

---

## 🖲 JBButton

Custom-styled button via `JBConfig.buttons`:

```dart
JBButton(
  text: "Save",
  type: "success",
  onPressed: () {},
);
```

Supports icon, gradient, radius, etc.

---

## 🧠 Extensions (Quick Access)

### BuildContext

* `screenWidth`, `isDarkMode`
* `launchAction(JBAction)`
* `textThemes`, `colors`

### Enum

* `.fromString("value", fallback: ...)`

### `DateTime`

* `.toJBTimezone()`, `.toShortDate()`, `.toRelativeTime()`, `.age`, `.isWeekend`

### `Color`

* `HexColor.fromHex("#abc123")`
* `color.toHex()`

### `String`

* `.camelCase`, `.snakeCase`, `.slugify()`, `.isEmail`, `.isPan`, `.toEnum(...)`

### `num`

* `.money()`, `.half`, `.pluralize("apple")`, `.seconds`

### `Object?`

* `.toNum()`, `.toBool()`, `.toDateTime()`, `.toList()`, `.isEmptyValue`

### `TextStyle`

* `.sm`, `.xl`, `.primary(context)`, `.underline`, `.ellipsis`

### `Widget`

* `.withPadding()`, `.centered()`, `.onTap()`, `.scrollable()`, `.withSize()`

---

## 📝 Log Utility

```dart
Log.e("Error"); // 🔴
Log.i("Info");  // 🔵
Log.s("Success"); // 🟢
```

→ Debug only, uses ANSI color in terminal.

---

## 🌐 Apis

```dart
// Set your base URL and optional API config
JBConfig.baseUrl = "https://yourdomain.com/api/";
JBConfig.apiConfig = ApiConfig();


try {
  Api('/endpoint', apiMethod: ApiMethods.get, data: {}).call(ctx).then((response) {
    // Handle response
  });
} catch (e) {
  // Handle error if needed
}

```

→ Debug only, uses ANSI color in terminal.

---

## ✅ Best Practices

* Call `App.init()` early
* Use fallback/defaults for missing styles
* Centralize UI config via `JBConfig`
* Use extensions for cleaner and faster UI

---
