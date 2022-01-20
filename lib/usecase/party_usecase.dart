import 'package:my_little_poney/api/user_service_io.dart';
import 'package:my_little_poney/models/Party.dart';

class PartyUseCase {
  PartyServiceApi api = PartyServiceApi();

  Future<List<Party>?> getAllParties() async {
    api.getAll().then((value) => value);
  }

  Future<Party?> fetchPartyById(id) async {
    api.fetchPartyById(id).then((value) => value);
  }

  Future<Party?> createParty(party) async {
    api.createParty(party).then((value) => value);
  }

  Future<Party?> updatePartyById(party) async {
    api.updateParty(party).then((value) => value);
  }

  Future<Party?> deletePartyById(id) async {
    api.deleteParty(id).then((value) => value);
  }
}
