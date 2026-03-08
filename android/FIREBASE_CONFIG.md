# Configuración Firebase para Android

## Pasos:

1. **Descargar google-services.json**
   - Ve a: https://console.firebase.google.com/project/lutusvestbackend
   - Proyecto Settings → Apps → Android
   - Descarga: `google-services.json`
   - Coloca aquí: `android/app/google-services.json`

2. **Verificar build.gradle (raíz)**
   - Debe contener en buildscript/dependencies:
   ```gradle
   classpath 'com.google.gms:google-services:4.3.15'
   ```

3. **Verificar app/build.gradle**
   - Debe tener al inicio de plugins:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

   - Y en dependencies:
   ```gradle
   implementation 'com.google.firebase:firebase-bom:32.0.0'
   implementation 'com.google.firebase:firebase-firestore'
   ```

4. **Ejecutar:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## URLs útiles:
- Firebase Console: https://console.firebase.google.com/project/lutusvestbackend
- Google Services Gradle Plugin: https://developers.google.com/android/guides/google-services-plugin
