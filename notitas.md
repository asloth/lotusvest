
---

## Indicadores de Confianza y Badges (Análisis de `feed_screen.dart`)

En el archivo `feed_screen.dart` (líneas 448-567) se encuentran **indicadores de confianza y badges** mockeados que actualmente NO están incluidos en el modelo `Startup`. Estos datos son críticos para la experiencia del usuario.

### Indicadores de Confianza Mockeados:

#### 1. **Verificaciones de Startup**
```
✓ Identidad Verificada
  - Documentación revisada por LotusVest
  - Status: bool (isIdentityVerified)

✓ Empresa Registrada
  - RFC y acta constitutiva validados
  - Status: bool (isRegisteredCompany)

✓ Due Diligence Completado
  - Revisión financiera aprobada
  - Status: bool (isDueDiligenceCompleted)
```

#### 2. **Información de LinkedIn del Fundador**
```
- LinkedIn URL: String (linkedin profile URL)
- Conexiones: int (+500 conexiones)
- Experiencia: String ("Ex-Goldman Sachs")
- Status: bool (linkedinVerified)
```

#### 3. **Badges/Endorsements**
```
🏆 Top 10 Startups 2024
🎓 Y Combinator Aplicante
Potencialmente más: TechCrunch Disrupt, Innovadora Latinoamericana, etc.
```

#### 4. **Datos de Inversión Adicionales**
```
- investorsCount: int (47 inversores)
- daysRemaining: int (23 días restantes en campaña)
```

---


## Datos Mockeados Extendidos para FinaHer

```dart
// En CommunityService
static final finaHerStartup = Startup(
  id: 'startup1',
  name: 'FinaHer',
  description: 'Plataforma fintech que democratiza el acceso a servicios financieros',
  founderName: 'María González',
  founderPhotoUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
  logoUrl: 'https://...',
  industry: Industry.fintech,
  stage: StartupStage.preSeed,
  technologies: ['Flutter', 'Firebase', 'Python', 'AWS', 'Machine Learning'],
  fundingGoal: 50000,
  currentFunding: 32500,
  membersCount: 156,
  createdAt: DateTime.now().subtract(const Duration(days: 180)),

  // ⭐ Nuevos atributos de confianza
  isIdentityVerified: true,
  isRegisteredCompany: true,
  isDueDiligenceCompleted: true,
  investorsCount: 47,
  daysRemaining: 23,

  badges: [
    Badge(
      id: 'top10_2024',
      name: 'Top 10 Startups 2024',
      emoji: '🏆',
      earnedAt: DateTime.now().subtract(const Duration(days: 30)),
      issuedBy: 'LotusVest Community',
    ),
    Badge(
      id: 'yc_applicant',
      name: 'Y Combinator Aplicante',
      emoji: '🎓',
      earnedAt: DateTime.now().subtract(const Duration(days: 60)),
      issuedBy: 'Y Combinator',
    ),
  ],

  founderSocial: FounderSocial(
    linkedinUrl: 'https://linkedin.com/in/maria-gonzalez-finaher',
    linkedinConnections: 500,
    linkedinHeadline: 'Ex-Goldman Sachs',
    isLinkedinVerified: true,
  ),
);
```

## Ejemplo de Uso Práctico

### Crear una Startup con Verificación Completa

```dart
final finaHerVerification = StartupVerification(
  startupId: 'startup1',
  isIdentityVerified: true,
  isRegisteredCompany: true,
  isDueDiligenceCompleted: true,
  badges: [
    Badge(
      id: 'top10_2024',
      name: 'Top 10 Startups 2024',
      emoji: '🏆',
      earnedAt: DateTime.now().subtract(const Duration(days: 30)),
      issuedBy: 'LotusVest Community',
    ),
    Badge(
      id: 'yc_applicant',
      name: 'Y Combinator Aplicante',
      emoji: '🎓',
      earnedAt: DateTime.now().subtract(const Duration(days: 60)),
      issuedBy: 'Y Combinator',
    ),
  ],
  founderSocial: FounderSocial(
    linkedinUrl: 'https://linkedin.com/in/maria-gonzalez-finaher',
    linkedinConnections: 500,
    linkedinHeadline: 'Ex-Goldman Sachs',
    isLinkedinVerified: true,
  ),
  verifiedAt: DateTime.now().subtract(const Duration(days: 45)),
);

final finaHerStartup = Startup(
  id: 'startup1',
  name: 'FinaHer',
  description: 'Plataforma fintech para mujeres emprendedoras',
  founderName: 'María González',
  founderPhotoUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
  logoUrl: 'https://...',
  industry: Industry.fintech,
  stage: StartupStage.preSeed,
  technologies: ['Flutter', 'Firebase', 'Python', 'AWS', 'ML'],
  fundingGoal: 50000,
  currentFunding: 32500,
  membersCount: 156,
  createdAt: DateTime.now().subtract(const Duration(days: 180)),
  investorsCount: 47,
  daysRemaining: 23,
  verification: finaHerVerification,  // ← Relación con verificación
);
```

### Usar los Getters en UI

```dart
// En feed_screen.dart o cualquier widget
final startup = CommunityService.getMockStartupById('startup1');

// Verificar si está completamente verificada
if (startup.verification?.isFullyVerified ?? false) {
  showVerifiedBadge();
}

// Obtener score de confianza (0-100)
final trustScore = startup.verification?.trustScore ?? 0;
progressBar.setValue(trustScore);

// Mostrar badges dinámicamente
startup.verification?.badges.forEach((badge) {
  _buildEndorsementBadge(badge.emoji, badge.name);
});

// Mostrar información de LinkedIn
if (startup.verification?.founderSocial != null) {
  final social = startup.verification!.founderSocial!;
  showLinkedInProfile(social.linkedinUrl, social.linkedinConnections);
}

// Mostrar progreso de verificación
final progress = startup.verification?.completedVerificationsCount ?? 0;
final total = StartupVerification.totalVerifications;
showVerificationProgress('$progress/$total verificaciones completadas');
```

---

### Mediano Plazo (Próximas 2 semanas)
- [ ] Backend: Crear tablas/colecciones para `StartupVerification`
- [ ] Backend: Endpoints para crear/actualizar verificaciones
- [ ] Implementar autenticación para administradores de verificación
- [ ] Dashboard de verificación para team

### Largo Plazo (1-2 meses)
- [ ] Sistema de auditoría de cambios en verificaciones
- [ ] Notificaciones cuando se completa verificación
- [ ] Badges dinámicos del sistema (nivel de confianza automático)
- [ ] Historial de verificaciones para análisis

---

## Actualización de CommunityService ✅

### Método `getMockStartups()` - Actualizado

#### Versión Anterior (sin verificaciones):
```dart
Startup(
  id: 'startup1',
  name: 'FinaHer',
  // ... otros campos ...
  // Sin verificación ni inversores
)
```

#### Versión Nueva (con verificaciones):
```dart
// Paso 1: Crear instancia de StartupVerification
final finaHerVerification = StartupVerification(
  startupId: 'startup1',
  isIdentityVerified: true,
  isRegisteredCompany: true,
  isDueDiligenceCompleted: true,
  badges: [
    Badge(
      id: 'top10_2024',
      name: 'Top 10 Startups 2024',
      emoji: '🏆',
      earnedAt: DateTime.now().subtract(const Duration(days: 30)),
      issuedBy: 'LotusVest Community',
    ),
    Badge(
      id: 'yc_applicant',
      name: 'Y Combinator Aplicante',
      emoji: '🎓',
      earnedAt: DateTime.now().subtract(const Duration(days: 60)),
      issuedBy: 'Y Combinator',
    ),
  ],
  founderSocial: FounderSocial(
    linkedinUrl: 'https://linkedin.com/in/maria-gonzalez-finaher',
    linkedinConnections: 500,
    linkedinHeadline: 'Ex-Goldman Sachs',
    isLinkedinVerified: true,
  ),
  verifiedAt: DateTime.now().subtract(const Duration(days: 45)),
);

// Paso 2: Usar verificación en Startup
Startup(
  id: 'startup1',
  name: 'FinaHer',
  // ... campos existentes ...
  investorsCount: 47,
  daysRemaining: 23,
  verification: finaHerVerification,  // ← Nueva relación
)
```


