import 'package:my_little_poney/api/horse_service_io.dart';
import 'package:my_little_poney/models/Horse.dart';

class HorseUseCase {
  HorseServiceApi api = HorseServiceApi();

  Future<List<Horse>?> getAllHorses() async {
    final result = await api.getAll();
      return result;
  }

  Future<Horse?> fetchHorseById(id) async {
    return api.fetchHorseById(id).then((value) => value);
  }

  Future<Horse?> createHorse(horse) async {
    return api.createHorse(horse).then((value) => value);
  }

  Future<Horse?> updateHorseById(horse) async {
    return api.updateHorse(horse).then((value) => value);
  }

  Future<Horse?> deleteHorseById(id) async {
   return api.deleteHorse(id).then((value) => value);
  }
}
