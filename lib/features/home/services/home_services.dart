import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/pitch_project.dart';

class HomeService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'pitch_project';

  /// Obtiene los datos mockeados de PitchProject
  static List<PitchProject> getMockPitchProjects() {
    return [
      PitchProject(
        id: '1',
        name: 'MindFlow AI',
        founderName: 'Ana Rodríguez',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=5',
        thumbnailUrl: 'https://picsum.photos/seed/mindflow/600/400',
        description:
            'Plataforma de bienestar mental basada en inteligencia artificial y diseñada específicamente para mujeres emprendedoras. Coaching personalizado, seguimiento del estado de ánimo y prevención del agotamiento.',
        category: 'Health',
        categoryColor: const Color(0xFFEC4899),
        techStack: ['Python', 'TensorFlow', 'AWS'],
        fundingGoal: 50000,
        currentFunding: 32500,
        backersCount: 214,
        daysLeft: 18,
      ),
      PitchProject(
        id: '2',
        name: 'FinaHer',
        founderName: 'María González',
        founderPhotoUrl:
            'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200',
        thumbnailUrl: 'https://picsum.photos/seed/finaher/600/400',
        description:
            'Plataforma de microcréditos diseñada para emprendedoras en Latinoamérica. Sin colateral, aprobación rápida, respaldada por la comunidad.',
        category: 'Fintech',
        categoryColor: const Color(0xFF10B981),
        techStack: ['Flutter', 'Firebase', 'Stripe'],
        fundingGoal: 80000,
        currentFunding: 54000,
        backersCount: 389,
        daysLeft: 12,
      ),
      PitchProject(
        id: '3',
        name: 'EduSpark',
        founderName: 'Laura Martínez',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=9',
        thumbnailUrl: 'https://picsum.photos/seed/eduspark/600/400',
        description:
            'Plataforma de aprendizaje adaptativo que utiliza el aprendizaje automático para personalizar las trayectorias educativas de los estudiantes desfavorecidos de toda América Latina.',
        category: 'EdTech',
        categoryColor: const Color(0xFFF59E0B),
        techStack: ['React Native', 'Node.js', 'ML'],
        fundingGoal: 35000,
        currentFunding: 12250,
        backersCount: 97,
        daysLeft: 25,
      ),
      PitchProject(
        id: '4',
        name: 'NovaMind',
        founderName: 'Sofía Herrera',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=16',
        thumbnailUrl: 'https://picsum.photos/seed/novamind/600/400',
        description:
            'Asistente de IA generativa para propietarios de pequeñas empresas. Automatiza facturación, gestión de inventario y comunicación con clientes.',
        category: 'AI',
        categoryColor: const Color(0xFF8B5CF6),
        techStack: ['Python', 'OpenAI', 'FastAPI', 'Docker'],
        fundingGoal: 60000,
        currentFunding: 47800,
        backersCount: 312,
        daysLeft: 7,
      ),
      PitchProject(
        id: '5',
        name: 'GreenTrace',
        founderName: 'Camila Vega',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=21',
        thumbnailUrl: 'https://picsum.photos/seed/greentrace/600/400',
        description:
            'Seguimiento de huella de carbono impulsado por IA para PYMES. Análisis en tiempo real de la cadena de suministro con información accionable sobre sostenibilidad.',
        category: 'AI',
        categoryColor: const Color(0xFF8B5CF6),
        techStack: ['Python', 'TensorFlow', 'GCP', 'GraphQL'],
        fundingGoal: 45000,
        currentFunding: 18000,
        backersCount: 143,
        daysLeft: 30,
      ),
      PitchProject(
        id: '6',
        name: 'PayHer',
        founderName: 'Valentina Cruz',
        founderPhotoUrl: 'https://i.pravatar.cc/150?img=32',
        thumbnailUrl: 'https://picsum.photos/seed/payher/600/400',
        description:
            'App de fintech de pago por demanda para trabajadores del economía gig. Acceso inmediato a los salarios ganados sin esperar al día de pago.',
        category: 'Fintech',
        categoryColor: const Color(0xFF10B981),
        techStack: ['Flutter', 'Node.js', 'PostgreSQL'],
        fundingGoal: 70000,
        currentFunding: 61000,
        backersCount: 501,
        daysLeft: 5,
      ),
    ];
  }

  /// Envía los datos mockeados a la colección 'pitch_project' en Firestore
  static Future<void> uploadMockPitchProjects() async {
    try {
      final projects = getMockPitchProjects();

      for (final project in projects) {
        await _firestore
            .collection(_collectionName)
            .doc(project.id)
            .set(project.toFirestore());
      }

      print('✓ ${projects.length} proyectos subidos exitosamente a Firebase');
    } catch (e) {
      print('✗ Error al subir proyectos: $e');
      rethrow;
    }
  }

  /// Obtiene todos los proyectos de Firestore
  static Future<List<PitchProject>> getPitchProjectsFromFirestore() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).get();

      return querySnapshot.docs
          .map((doc) => PitchProject.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('✗ Error al obtener proyectos: $e');
      rethrow;
    }
  }

  /// Obtiene un proyecto específico por su ID
  static Future<PitchProject?> getPitchProjectById(String projectId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(projectId)
          .get();

      if (doc.exists) {
        return PitchProject.fromFirestore(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('✗ Error al obtener proyecto: $e');
      rethrow;
    }
  }

  /// Obtiene proyectos por categoría
  static Future<List<PitchProject>> getPitchProjectsByCategory(
    String category,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('category', isEqualTo: category)
          .get();

      return querySnapshot.docs
          .map((doc) => PitchProject.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print('✗ Error al obtener proyectos por categoría: $e');
      rethrow;
    }
  }

  /// Stream en tiempo real de todos los proyectos
  static Stream<List<PitchProject>> watchPitchProjects() {
    return _firestore
        .collection(_collectionName)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PitchProject.fromFirestore(doc.data()))
              .toList(),
        );
  }

  /// Elimina todos los proyectos de Firestore (útil para testing)
  static Future<void> clearAllPitchProjects() async {
    try {
      final docs = await _firestore.collection(_collectionName).get();

      for (final doc in docs.docs) {
        await doc.reference.delete();
      }

      print('✓ Todos los proyectos han sido eliminados');
    } catch (e) {
      print('✗ Error al eliminar proyectos: $e');
      rethrow;
    }
  }
}
