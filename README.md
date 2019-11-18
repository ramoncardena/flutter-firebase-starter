# Proyecto base de Flutter con Firebase

## Descripción

Este proyecto pretende ser una plantilla base o _starter_ para empezar un proyecto con Flutter y Firebase de forma rápida.

<p>&nbsp;</p>

##Instalación de Flutter

Instalar Flutter en el equipo de desarrollo:

[https://flutter.dev/docs/get-started/install/macos](https://flutter.dev/docs/get-started/install/macos)

Asegurarnos de que tenemos instalado Android Studio y Xcode:

[Descarga de xCode](https://flutter.dev/docs/get-started/install/macos)

[Descarga de Android Studio (para Mac)](https://flutter.dev/docs/get-started/install/macos)

Una vez instalado, comprobar la instalación con:

`flutter doctor`

<p>&nbsp;</p>

## Instalación proyecto

`git clone git@github.com:ramoncardena/flutter-firebase-starter.git`
`cd flutter-firebase-starter`

<p>&nbsp;</p>
##Configuración

###Definición del Bundle ID en iOS

Abrimos el proyecto de **iOS** en xCode: `~/flutter-firebase-starter/ios`

En la estructura del proyecto seleccionamos el root **Runner** y en la sección **_General_** en el apartado **_Identity_** definimos el Bundle ID (**Bundle identifier**) y la versión (**Version**).

Después vamos a la sección de **_Signing & Capabilities_** y en el apartado **Signing** seleccionamos el equipo adecuado (**Team**) para firmar el proyecto.

<p>&nbsp;</p>

###Definición del Application ID en Android

Vamos a la carpeta del proyecto donde se define el Gradle para la aplicación en:
`~/flutter-firebase-starter/android/app/build.gradle`

Y modificamos la sección de **_defaultConfig_** con el application ID (**_applicationId_**) correspondiente y fijamos la versión mínima de SDK (**_minSdkVersion_**) a 21

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

##Ejecución
Una vez modificado el ID, comprobamos que la aplicación recién instalada se ejecuta en los dos sistemas (conectamos un móvil Android y un iPhone:

`flutter run -d all`

(o arrancando el proyecto desde Android Studio)

<p>&nbsp;</p>

##Configuración de Firebase
Encontraremos la información detallada en inglés, [en este artículo](https://firebase.google.com/docs/flutter/setup).

Vamos a la [consola de Firebase](https://console.firebase.google.com/).

Creamos un proyecto nuevo y una vez creado, añadimos dos aplicaciones, una Android y otra iOS.

###Aplicación iOS
Creamos una nueva aplicación iOS desde la consola de Firebase y rellenamos los datos básicos.

Después, descargamos el fichero **_GoogleService-Info.plist_** de configuración.

**_Importante:_** Abrimos xCode y con el botón derecho sobre la carpeta Runner/Runner, añadimos el fichero de configuración de Firebase y cerramos xCode.

###Aplicación Android
Creamos una nueva aplicación Android desde la consola de Firebase con los datos básicos.

Para [añadir la clave de firma SHA](https://developers.google.com/android/guides/client-auth), desde un terminal vamos a la carpeta del proyecto y ejecutamos:

`keytool -list -v \ -alias androiddebugkey -keystore ~/.android/debug.keystore`

(como contraseña usamos `android`)

Después descargamos el fichero **google-services.json** de configuración y lo copiamos en la carpeta del proyecto: `android/app`.

Una vez copiado el fichero, hemos de configurar el Gradle para que funcione con Firebase. Editamos en primer lugar `android/build.gradle`:

```
buildscript {
  repositories {
    // Check that you have the following line (if not, add it):
    google()  // Google's Maven repository
  }

  // ...

  dependencies {
    // ...

    // Add the following line:
    classpath 'com.google.gms:google-services:4.3.3'  // Google Services plugin
  }
}
allprojects {
  // ...

  repositories {
    // Check that you have following line (if not, add it):
    google()  // Google's Maven repository
    // ...
  }
}

```

Y en `android/app/build.gradle`:

```
dependencies {
// ...
}

// Add the following line to the bottom of the file:
apply plugin: 'com.google.gms.google-services'  // Google Play services Gradle plugin
```

Por último editamos el fichero `android/gradle.properties` y le añadimos:

```
android.useAndroidX=true
android.enableJetifier=true
```

Finalmente ejecutamos:

`flutter packages get`

##Instalación de los plugins de Firebase

Añadimos los plugins que necesitemos de Firebase en `pubspec.yaml` en la sección de **_dependencies_**:

```
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2

  ## AQUÍ DEPENDENCIAS FIREBASE Y OTRAS...
  firebase_core: ^0.4.1+5
  firebase_analytics: ^5.0.6
  cloud_firestore: ^0.12.10
  firebase_auth: ^0.14.0+9
  google_sign_in: ^4.0.14
  rxdart: ^0.22.6
  provider: 2.0.0+1
  font_awesome_flutter: 8.4.0
```

Una vez definidos los plugins, los instalamos:

`flutter packages get`

Y ejecutamos la app para ver que todo funciona:

`flutter run -d all`
