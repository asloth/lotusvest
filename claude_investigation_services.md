# Análisis de Servicios y Modelos - Community Service

## Descripción General

El archivo `community_service.dart` contiene servicios **mockeados** para proporcionar datos de prueba que permiten llenar las pantallas de la aplicación. Es un servicio de prueba/desarrollo que proporciona datos realistas para la funcionalidad de comunidad.

---

## Servicios Disponibles en CommunityService

### 1. **getMockPostsByStartup(String startupId)**
- **Propósito**: Obtener posts específicos de una startup
- **Retorna**: `List<Post>`
- **Datos disponibles**: Posts de demostración con diferentes tipos (milestone, teamPhoto)
- **Ejemplo de uso**: Llenar feed de una startup específica

### 2. **getMockAllPosts()**
- **Propósito**: Obtener todos los posts de la comunidad
- **Retorna**: `List<Post>`
- **Cantidad**: 4 posts de demostración
- **Tipos incluidos**: updates, milestones, teamPhotos, productPreviews

### 3. **getMockForums()**
- **Propósito**: Obtener lista de foros disponibles
- **Retorna**: `List<Forum>`
- **Categorías disponibles**:
  - Tecnología (💻)
  - Estrategia de Mercado (📈)
  - Feedback del Producto (💬)

### 4. **getMockThreads(String forumId)**
- **Propósito**: Obtener threads de un foro específico
- **Retorna**: `List<ForumThread>`
- **Características**: Algunos threads pueden estar pinned (fijados)

### 5. **getMockAllyOffers()**
- **Propósito**: Obtener ofertas disponibles de aliados
- **Retorna**: `List<AllyOffer>`
- **Tipos de ofertas**:
  - 🎓 Mentoría
  - 💰 Financiamiento
  - 🤝 Contactos/Networking
  - 🧠 Expertise/Consultoría

### 6. **getMockStartups()**
- **Propósito**: Obtener lista de startups registradas
- **Retorna**: `List<Startup>`
- **Datos incluidos**: FinaHer (Fintech) y MindFlow (HealthTech)

---

## Modelos de Datos

### **Post Model** (`post.dart`)
```
Propiedades:
- id: String
- startupId: String
- authorName: String
- authorPhotoUrl: String
- content: String
- imageUrls: List<String>
- type: PostType (enum: update, milestone, teamPhoto, productPreview)
- likesCount: int
- commentsCount: int
- createdAt: DateTime
- isLikedByUser: bool (default: false)

Getters:
- typeLabel: Retorna etiqueta legible del tipo de post
- timeAgo: Calcula tiempo relativo desde creación (ej: "hace 2h")
```

### **Comment Model** (`post.dart`)
```
Propiedades:
- id: String
- postId: String
- authorName: String
- authorPhotoUrl: String
- content: String
- createdAt: DateTime
```

### **Forum Model** (`forum.dart`)
```
Propiedades:
- id: String
- title: String
- category: ForumCategory (enum: technology, marketStrategy, productFeedback)
- description: String
- threadsCount: int
- membersCount: int
- lastActivity: DateTime

Getters:
- categoryLabel: Etiqueta legible de categoría
- categoryIcon: Ícono emoji de categoría
```

### **ForumThread Model** (`forum.dart`)
```
Propiedades:
- id: String
- forumId: String
- title: String
- authorName: String
- authorPhotoUrl: String
- preview: String
- repliesCount: int
- viewsCount: int
- createdAt: DateTime
- lastReplyAt: DateTime
- isPinned: bool (default: false)
```

### **ForumReply Model** (`forum.dart`)
```
Propiedades:
- id: String
- threadId: String
- authorName: String
- authorPhotoUrl: String
- content: String
- likesCount: int
- createdAt: DateTime
```

### **Ally Model** (`ally.dart`)
```
Propiedades:
- id: String
- name: String
- photoUrl: String
- title: String
- company: String
- bio: String
- offerTypes: List<AllyOfferType>
- expertise: List<String>
- connectionsCount: int
- isVerified: bool (default: false)
- joinedAt: DateTime

Método:
- getOfferTypeLabel(AllyOfferType): Retorna etiqueta legible
```

### **AllyOffer Model** (`ally.dart`)
```
Propiedades:
- id: String
- allyId: String
- allyName: String
- allyPhotoUrl: String
- type: AllyOfferType (enum: mentorship, funding, networking, expertise)
- title: String
- description: String
- isAvailable: bool
- createdAt: DateTime

Getters:
- typeLabel: Etiqueta legible del tipo de oferta
- typeIcon: Ícono emoji asociado
```

### **Startup Model** (`startup.dart`)
```
Propiedades:
- id: String
- name: String
- description: String
- founderName: String
- founderPhotoUrl: String
- logoUrl: String
- industry: Industry (enum: fintech, healthtech, edtech, ai, ecommerce, sustainability, socialImpact, other)
- stage: StartupStage (enum: ideation, preSeed, seed)
- technologies: List<String>
- fundingGoal: double
- currentFunding: double
- membersCount: int
- createdAt: DateTime

Getters:
- fundingProgress: Calcula progreso de financiamiento (currentFunding / fundingGoal)
- industryLabel: Etiqueta legible de industria
- stageLabel: Etiqueta legible de etapa
```

### **PitchProject Model** (`lib/features/home/models/pitch_project.dart`)
```
Propiedades:
- id: String
- name: String
- founderName: String
- founderPhotoUrl: String
- thumbnailUrl: String
- description: String
- category: String
- categoryColor: Color
- techStack: List<String>
- fundingGoal: double
- currentFunding: double
- backersCount: int
- daysLeft: int

Getter:
- fundingProgress: Calcula progreso de financiamiento
```

### **Badge Model** (`startup_verification.dart`)
```
Propiedades:
- id: String
- name: String
- emoji: String
- earnedAt: DateTime
- issuedBy: String? (opcional)
```

### **FounderSocial Model** (`startup_verification.dart`)
```
Propiedades:
- linkedinUrl: String
- linkedinConnections: int
- linkedinHeadline: String? (opcional)
- isLinkedinVerified: bool (default: false)
```

### **StartupVerification Model** (`startup_verification.dart`)
```
Propiedades:
- startupId: String
- isIdentityVerified: bool (default: false)
- isRegisteredCompany: bool (default: false)
- isDueDiligenceCompleted: bool (default: false)
- badges: List<Badge> (default: [])
- founderSocial: FounderSocial? (opcional)
- verifiedAt: DateTime

Getters:
- trustScore: Calcula score de confianza (0-100) basado en verificaciones completadas
  * Identidad verificada = +33
  * Empresa registrada = +33
  * Due diligence completado = +34
- isFullyVerified: Retorna true si todas las 3 verificaciones están completadas
- completedVerificationsCount: Número de verificaciones completadas
- totalVerifications: Constante = 3 (verificaciones disponibles)
```

---

## Relaciones entre Modelos

```
Startup
  ├── Contiene múltiples Posts
  ├── Tiene un founder (representado en founderName, founderPhotoUrl)
  ├── Tiene una StartupVerification (referencia por startupId)
  └── Puede tener una PitchProject (representación alternativa)

Post
  └── Puede tener múltiples Comments

Forum
  └── Contiene múltiples ForumThreads (threads)

ForumThread
  ├── Pertenece a un Forum
  └── Puede tener múltiples ForumReplies

AllyOffer
  └── Es ofrecido por un Ally

StartupVerification
  ├── Referencia a Startup (startupId)
  ├── Contiene múltiples Badges
  └── Contiene datos sociales del founder (FounderSocial - LinkedIn)

Badge
  └── Ganado/emitido por la Startup (a través de StartupVerification)

FounderSocial
  └── Información del fundador en redes sociales (LinkedIn)

PitchProject
  └── Representación alternativa/complementaria de startups con datos de financiamiento
```

### Descripción de Relaciones Clave:

**Startup → StartupVerification**: Cada Startup puede tener un registro de verificación que indica:
- Si la identidad del fundador ha sido verificada
- Si la empresa está registrada legalmente
- Si se completó el due diligence
- Badges obtenidos y logros
- Información de redes sociales del fundador (LinkedIn)

**StartupVerification → FounderSocial**: Contiene información verificada sobre la presencia del fundador en LinkedIn para establecer credibilidad.

**StartupVerification → Badge**: Mantiene un historial de distintivos/logros obtenidos por la startup, con fecha de emisión e identificador de quien los emitió.

---

## Datos Mock Disponibles

### Startups Mockeadas:
1. **FinaHer** (ID: startup1)
   - Industria: Fintech
   - Etapa: Pre-Seed
   - Fundador: María González
   - Objetivo: $50,000 | Actual: $32,500 (65% progreso)
   - Miembros: 156
   - Tech: Flutter, Firebase, IA

2. **MindFlow** (ID: startup2)
   - Industria: HealthTech
   - Etapa: Ideación
   - Fundador: Ana Rodríguez
   - Objetivo: $25,000 | Actual: $8,750 (35% progreso)
   - Miembros: 89
   - Tech: React Native, Node.js, ML

### Foros Disponibles:
1. Tecnología (45 threads, 234 miembros)
2. Estrategia de Mercado (32 threads, 189 miembros)
3. Feedback del Producto (67 threads, 312 miembros)

### Aliados Mockeados:
1. **Carlos Mendoza** - Mentoría en Fintech (2h/semana disponible)
2. **Patricia Vega** - Conexiones en Silicon Valley
3. **Roberto Silva** - Consultoría UX/UI
4. **Elena Torres** - Angel Investment Pre-seed ($10k-$50k)

---

## Notas Importantes

- ✅ Todos los servicios son **estáticos** (static methods)
- ✅ Los datos son **mockeados** (no conectados a base de datos real)
- ✅ Los timestamps usan `DateTime.now()` con `subtract()` para simular data histórica
- ✅ Cada modelo tiene getters computados para valores derivados (labels, progreso, tiempo)
- ⚠️ Estos servicios son **SOLO PARA DESARROLLO/PRUEBA**, no para producción
- 📝 Los datos están orientados al contexto de emprendimiento femenino en Latinoamérica

---

## Propósito de StartupVerification

El modelo `StartupVerification` es responsable de:

1. **Verificación de Identidad**: Confirmar que el fundador/a es quien dice ser
2. **Validación Legal**: Verificar que la empresa está registrada correctamente
3. **Due Diligence**: Evaluar riesgos y cumplimiento normativo básico
4. **Credibilidad**: Generar un "trust score" para que inversores confíen en la startup
5. **Elementos de Gamificación**: Badges para reconocer logros de la startup
6. **Validación de Redes Sociales**: Verificación de presencia en LinkedIn del fundador

### Trust Score
El score de confianza (0-100) se calcula de manera simple:
- Identidad verificada: +33 puntos
- Empresa registrada: +33 puntos
- Due diligence completado: +34 puntos
- **Score completo (100)**: Se logra solo si las 3 verificaciones están completadas

---

```dart
// Obtener posts de una startup
List<Post> posts = CommunityService.getMockPostsByStartup('startup1');

// Obtener todos los posts
List<Post> allPosts = CommunityService.getMockAllPosts();

// Obtener foros disponibles
List<Forum> forums = CommunityService.getMockForums();

// Obtener threads de un foro
List<ForumThread> threads = CommunityService.getMockThreads('1');

// Obtener aliados y sus ofertas
List<AllyOffer> offers = CommunityService.getMockAllyOffers();

// Obtener startups
List<Startup> startups = CommunityService.getMockStartups();
```

---
