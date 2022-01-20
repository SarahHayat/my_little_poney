import 'package:my_little_poney/api/lesson_service_io.dart';
import 'package:my_little_poney/models/Lesson.dart';

class LessonUseCase {
  LessonServiceApi api = LessonServiceApi();

  Future<List<Lesson>?> getAllLessons() async {
    api.getAll().then((value) => value);
  }

  Future<Lesson?> fetchLessonById(id) async {
    api.fetchLessonById(id).then((value) => value);
  }

  Future<Lesson?> createParty(lesson) async {
    api.createLesson(lesson).then((value) => value);
  }

  Future<Lesson?> updateLessonById(lesson) async {
    api.updateLesson(lesson).then((value) => value);
  }

  Future<Lesson?> deleteLessonById(id) async {
    api.deleteLesson(id).then((value) => value);
  }
}
