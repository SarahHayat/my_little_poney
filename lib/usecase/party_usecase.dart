import 'package:my_little_poney/api/party_service_io.dart';
import 'package:my_little_poney/models/Party.dart';

class PartyUseCase {
  PartyServiceApi api = PartyServiceApi();

  Future<List<Party>?> getAllParties() async {
    return api.getAll().then((value) => value);
  }

  Future<Party?> fetchPartyById(id) async {
    return api.fetchPartyById(id).then((value) => value);
  }

  Future<Party?> createParty(party) async {
    return api.createParty(party).then((value) => value);
  }

  Future<Party?> updatePartyById(party) async {
    return api.updateParty(party).then((value) => value);
  }

  Future<Party?> deletePartyById(id) async {
    api.deleteParty(id).then((value) => value);
  }
}
