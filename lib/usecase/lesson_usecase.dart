import 'package:my_little_poney/api/lesson_service_io.dart';
import 'package:my_little_poney/models/Lesson.dart';

class LessonUseCase {
  LessonServiceApi api = LessonServiceApi();

  Future<List<Lesson>?> getAllLessons() async {
    return api.getAll().then((value) => value);
  }

  Future<Lesson?> fetchLessonById(id) async {
    return api.fetchLessonById(id).then((value) => value);
  }

  Future<Lesson?> createLesson(lesson) async {
    return api.createLesson(lesson).then((value) => value);
  }

  Future<Lesson?> updateLessonById(lesson) async {
    return api
        .updateLesson(lesson)
        .then((value) => value)
        .catchError((onError) => onError);
  }

  Future<Lesson?> deleteLessonById(id) async {
    api.deleteLesson(id).then((value) => value);
  }
}
