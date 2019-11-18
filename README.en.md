# Flutter base project with Firebase
Other languages: [Spanish](https://github.com/ramoncardena/flutter-firebase-starter/blob/master/README.md)

## Description

This project aims to be a base template or _starter_ to start a project with Flutter and Firebase quickly.

The application consists of two screens: **Login** and **Home**

### Login Screen

In this screen the user can:

* Login to Firebase with email/password
* Sign in to Firebase with a Google Account
* Register in Firebase with email/password

### Home Screen

Screen that we arrive at once identified and that allows us to end the session.

### Database
In addition the application creates a document in the database called **activity** in which is saved the time and id of the user each time he logs in.


### Objective
The aim of this project is to **demonstrate the use of Flutter together with Firebase** to quickly create an application with a backend to manage users and authentication and a database to store information.


<p>&nbsp;</p>


## Flutter Installation

Install Flutter on the development machine:

[https://flutter.dev/docs/get-started/install/macos](https://flutter.dev/docs/get-started/install/macos)

Make sure you have installed Android Studio and Xcode:

[Download xCode](https://flutter.dev/docs/get-started/install/macos)

[Download Android Studio (for Mac)](https://flutter.dev/docs/get-started/install/macos)

Once installed, check the installation with:

`flutter doctor`

<p>&nbsp;</p>

## Project installation

`git clone git@github.com:ramoncardena/flutter-firebase-starter.git`

`cd flutter-firebase-starter`

<p>&nbsp;</p>

## Configuration

### Definition of the Bundle ID in iOS

We open the **iOS** project in xCode: `~/flutter-firebase-starter/ios`

In the structure of the project we select the root **Runner** and in the section **_General_** in the section **_Identity_** we define the Bundle ID (**_Bundle identifier_**) and the version (**_Version_**).

Then we go to the section **_Signing & Capabilities_** and in the section **_Signing_** we select the appropriate team (**Team**) to sign the project.

<p>&nbsp;</p>

### Android Application ID Definition

Let's go to the project folder where you define the Gradle for the application in:
`~/flutter-firebase-starter/android/app/build.gradle`

And modify the section of **_defaultConfig_** with the corresponding application ID (**_applicationId_**) and set the minimum version of SDK (**_minSdkVersion_**) to 21.

```
defaultConfig {
	applicationId "com.ramoncardena.firebasestarter"
	minSdkVersion 21
	targetSdkVersion 28
	versionCode flutterVersionCode.toInteger()
	versionName flutterVersionName
	testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
}
```

<p>&nbsp;</p>

## Execution
Once the ID has been modified, we check that the newly installed application runs on both systems (we connect an Android mobile and an iPhone):

`flutter run -d all`

(or starting the project from Android Studio)

<p>&nbsp;</p>

## Firebase Configuration
Detailed information is available in English, [in this article] (https://firebase.google.com/docs/flutter/setup).

Let's go to the [Firebase console](https://console.firebase.google.com/).

We create a new project and once created, we add two applications, one Android and one iOS.

### iOS Application
We created a new iOS application from the Firebase console and filled in the basic data.

Then, download the configuration file **_GoogleService-Info.plist_**.

**_Important:_** Open xCode and right-click on the Runner/Runner folder, add the Firebase configuration file and close xCode.

In addition, for authentication with ***Google Sign-In*** to work, we have to add the corresponding key to the file `ios/Runner/Info.plist`:

```
<!-- Google Sign-in Section -->
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>	
<!-- TODO Replace this value: --> 
<!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
<string>com.googleusercontent.apps.861823949799-vcuujjn0vvnmcvjppkn</string>
    </array>
  </dict>
</array>
<!-- End of the Google Sign-in Section -->
```


### Android Application
We created a new Android application from the Firebase console with the basic data.

To [add the SHA signature key](https://developers.google.com/android/guides/client-auth), from a terminal go to the project folder and run:

`keytool -list -v \ -alias androiddebugkeystore ~/.android/debug.keystore`

(as password we use `android`)

Then we download the configuration file **google-services.json** and copy it into the project folder: `android/app`.

Once copied the file, we have to configure Gradle to work with Firebase. First we edit `android/build.gradle`:

```
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google() // Google's Maven repository
  }

  // ...

  dependencies {
    // ...

    // Add the following line:
    classpath 'com.google.gms:google-services:4.3.3' // Google Services plugin
  }
}
allprojects {
  // ...

  repositories {
    // Check that you have following line (if not, add it):
    google() // Google's Maven repository
    // ...
  }
}

```

And in `android/app/build.gradle`:

```
dependencies {
// ...
}

// Add the following line to the bottom of the file:
apply plugin: 'com.google.gms.google-services' // Google Play services Gradle plugin
```

Finally we edit the file `android/gradle.properties` and add it:

```
android.useAndroidX=true
android.enableJetifier=true
```

We finally execute:

`flutter packages get`

## Installation of Firebase plugins

We add the plugins we need from Firebase in `pubspec.yaml` in the **_dependencies_** section:

```
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2

  ## HERE FIREBASE AND OTHER DEPENDENCIES...
  firebase_core: ^0.4.1+5
  firebase_analytics: ^5.0.6
  Cloud_firestore: ^0.12.10
  firebase_auth: ^0.14.0+9
  google_sign_in: ^4.0.14
  rxdart: ^0.22.6
  provider: 2.0.0+1
  font_awesome_flutter: 8.4.0
```

Once the plugins are defined, we install them:

`get flutter packages`

And we run the app to see that everything works:

`flutter run -d all`

# About me
You can learn more about me at [my website](https://ramoncardena.com/en) or read my articles from my [blog](https://ramoncardena.com/en/blog)