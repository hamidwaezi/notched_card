# NotchedCard - A Customizable Card with Notch Effect

[![pub package](https://img.shields.io/pub/v/notched_card.svg)](https://pub.dev/packages/notched_card)

A Flutter plugin that provides a `Card` widget with a customizable notch effect on different sides (top, bottom, left, or right). Enhance your UI with unique and modern designs!

## Features
✅ Supports notch effect on **top, bottom, left, and right** sides of the card.
✅ Fully customizable card appearance.
✅ Easy integration with existing Flutter projects.
✅ Works with any child widget inside the card.

## Installation
Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  notched_card: latest_version
```

Then, run:

```sh
flutter pub get
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:notched_card/notched_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: NotchedCard(
            notchPosition: NotchPosition.bottom,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Notched Card"),
            ),
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### NotchedCard Properties
| Property        | Type            | Default | Description |
|----------------|----------------|---------|-------------|
| `child`        | `Widget`        | `null`  | The content inside the card. |
| `notchPosition` | `NotchPosition` | `NotchPosition.bottom` | Defines the notch position (top, bottom, left, or right). |
| `color`        | `Color?`        | `null`  | Background color of the card. |
| `elevation`    | `double`        | `1.0`   | Card elevation (shadow effect). |
| `margin`       | `EdgeInsetsGeometry?` | `null` | External margin around the card. |

### NotchPosition Enum
- `NotchPosition.top`
- `NotchPosition.bottom`
- `NotchPosition.left`
- `NotchPosition.right`

## Screenshots

| Top Notch | Bottom Notch | Left Notch | Right Notch |
|-----------|-------------|------------|-------------|
| ![Top Notch](https://cdn.jsdelivr.net/gh/hamidwaezi/notched_card@cdn/assets/top.png) | ![Bottom Notch](https://cdn.jsdelivr.net/gh/hamidwaezi/notched_card@cdn/assets/bottom.png) | ![Left Notch](https://cdn.jsdelivr.net/gh/hamidwaezi/notched_card@cdn/assets/left.png) | ![Right Notch](https://cdn.jsdelivr.net/gh/hamidwaezi/notched_card@cdn/assets/right.png) |

## Contributions
Contributions are welcome! If you find any issues or have feature requests, feel free to open an [issue](https://github.com/yourusername/notched_card/issues) or submit a pull request.

## License
MIT License. See the [LICENSE](LICENSE) file for details.

