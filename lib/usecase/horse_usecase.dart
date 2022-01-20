import 'package:my_little_poney/api/horse_service_io.dart';
import 'package:my_little_poney/models/Horse.dart';

class HorseUseCase {
  HorseServiceApi api = HorseServiceApi();

  Future<List<Horse>?> getAllHorses() async {
    api.getAll().then((value) => value);
  }

  Future<Horse?> fetchHorseById(id) async {
    api.fetchHorseById(id).then((value) => value);
  }

  Future<Horse?> createHorse(horse) async {
    api.createHorse(horse).then((value) => value);
  }

  Future<Horse?> updateHorseById(horse) async {
    api.updateHorse(horse).then((value) => value);
  }

  Future<Horse?> deleteHorseById(id) async {
    api.deleteHorse(id).then((value) => value);
  }
}
