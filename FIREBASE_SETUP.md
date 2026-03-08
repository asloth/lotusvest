# Firebase Configuration Guide - LotusVest

## Estado actual ✅
- ✅ Firebase Core y Cloud Firestore agregados a pubspec.yaml
- ✅ Archivo firebase_options.dart creado con credenciales
- ✅ main.dart configurado para inicializar Firebase
- ✅ Reglas de Firestore actualizadas
- ✅ HomeService con funciones CRUD completadas

## Próximos pasos necesarios 📋

### 1. **Configuración de Android** 📱

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto: **lutusvestbackend**
3. Ve a Project Settings → Apps → Android
4. Descarga `google-services.json`
5. Coloca el archivo en: `android/app/google-services.json`

**Configurar build.gradle:**
```gradle
// android/build.gradle (raíz del proyecto)
buildscript {
  dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
  }
}

// android/app/build.gradle
apply plugin: 'com.google.gms.google-services'

dependencies {
  implementation 'com.google.firebase:firebase-bom:32.0.0'
}
```

### 2. **Configuración de iOS** 🍎

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto: **lutusvestbackend**
3. Ve a Project Settings → Apps → iOS
4. Descarga `GoogleService-Info.plist`
5. Abre Xcode: `ios/Runner.xcworkspace`
6. Arrastra el archivo a Xcode (marca "Copy items if needed", target "Runner")

**Actualizar Podfile:**
```bash
cd ios
pod install
cd ..
```

### 3. **Actualizar firebase_options.dart** ⚙️

El archivo `lib/firebase_options.dart` contiene placeholders. Reemplaza los valores:

- `apiKey` (Android/iOS): Obtén del archivo de configuración
- `appId` (Android/iOS): Obtén del archivo de configuración
- `iosBundleId`: Generalmente `com.example.app` o según tu dominio

### 4. **Desplegar Reglas de Firestore** 🚀

```bash
firebase deploy --only firestore:rules
```

O desde Firebase Console:
1. Firestore Database → Reglas
2. Reemplaza con el contenido de `firestore.rules`
3. Click en "Publicar"

## Usar las funciones de Firebase

```dart
// En cualquier parte de tu app
import 'package:app_lutus/features/home/services/home_services.dart';

// Subir datos mockeados
await HomeService.uploadMockPitchProjects();

// Obtener todos los proyectos
final projects = await HomeService.getPitchProjectsFromFirestore();

// Obtener en tiempo real
HomeService.watchPitchProjects().listen((projects) {
  print('Proyectos: ${projects.length}');
});

// Obtener por categoría
final aiProjects = await HomeService.getPitchProjectsByCategory('AI');
```

## Verificar Conexión ✓

Para verificar que Firebase está funcionando:

1. Ejecuta la app
2. Haz click en el ícono ⚙️ (tune) en la búsqueda
3. Debería mostrar: "✓ Proyectos subidos a Firebase"
4. Ve a Firebase Console → Firestore → Ver datos
5. Deberías ver la colección `pitch_project` con 6 documentos

## Solución de Problemas 🔧

### Error: "Platform exception"
- Verifica que `google-services.json` esté en `android/app/`
- Verifica que `GoogleService-Info.plist` esté en Xcode

### Error: "Permission denied"
- Revisa las reglas en `firestore.rules`
- Asegúrate de que publicaste las reglas: `firebase deploy --only firestore:rules`

### Error: "Firebase not initialized"
- Verifica que `Firebase.initializeApp()` se ejecutó en main()
- Asegúrate de tener `firebase_core` en pubspec.yaml

## Guía Rápida: Primeros pasos

```bash
# 1. Instala Firebase CLI si no lo tienes
npm install -g firebase-tools

# 2. Inicia sesión
firebase login

# 3. Despliega las reglas
firebase deploy --only firestore:rules

# 4. Ejecuta tu app
flutter run
```

## Notas Importantes 📝

- El archivo `firebase_options.dart` contiene datos de ejemplo. Reemplaza con tus credenciales reales
- Las reglas de Firestore permiten lectura pública y prohíben escritura directa desde la app (solo lectura)
- Los datos mockeados solo se suben cuando haces click en el ícono de tune
- Usa `HomeService.clearAllPitchProjects()` para limpiar datos si es necesario

---

Para más ayuda: [Firebase Flutter Docs](https://firebase.google.com/docs/flutter/setup)
