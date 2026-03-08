# Configuración Firebase para iOS

## Pasos:

1. **Descargar GoogleService-Info.plist**
   - Ve a: https://console.firebase.google.com/project/lutusvestbackend
   - Project Settings → Apps → iOS
   - Descarga: `GoogleService-Info.plist`

2. **Agregar a Xcode**
   - Abre: `ios/Runner.xcworkspace` (NO workspace, usar xcworkspace)
   - Clic derecho en "Runner" → "Add Files to Runner"
   - Selecciona el archivo `GoogleService-Info.plist`
   - Asegúrate de marcar: "Copy items if needed" y target "Runner"
   - Clic Add

3. **Actualizar Podfile**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Limpiar y ejecutar:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## Verificación:
- El archivo `GoogleService-Info.plist` debe aparecer en Xcode bajo "Runner"
- En terminal: `ls Runner/` debe mostrar el archivo plist

## Nota Importante:
- Usa `ios/Runner.xcworkspace` para desarrollar, NO `ios/Runner.xcodeproj`
- Siempre abre desde xcworkspace después de cambios en podspec

## URLs útiles:
- Firebase Console: https://console.firebase.google.com/project/lutusvestbackend
- Firebase iOS Setup: https://firebase.google.com/docs/ios/setup
