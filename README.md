# flutter_kgo_vnpay

A new Flutter plugin to connect with vnpay sdk.

## Getting Started

This project is a starting point to connect with vnpay sdk
[vnpay](https://vnpay.vn/),

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### **iOS**

In the **ios/Runner/Info.plist** let’s add:

```dart
	<dict>
	     <key>NSAppTransportSecurity</key>
          <dict>
                <key>NSAllowsArbitraryLoads</key>
                <true/>
                <key>NSAllowsArbitraryLoadsInWebContent</key>
                <true/>
          </dict>
```

```dart
   	<key>CFBundleURLTypes</key>
   	<array>
   		<dict>
   			<key>CFBundleTypeRole</key>
   			<string>Editor</string>
   			<key>CFBundleURLName</key>
   			<string>vnpayxxx</string>
   			<key>CFBundleURLSchemes</key>
   			<array>
   				<string>vnpayxxx</string>
   			</array>
   		</dict>
   	</array>

```

#### **Android**

## Usage

#### 1\. Depend

Add this to you package's `pubspec.yaml` file:

```yaml
dependencies:
	flutter_kgo_vnpay: ^0.0.2+3
```

#### 2\. Install

Run command:

```bash
$ flutter pub get
```
