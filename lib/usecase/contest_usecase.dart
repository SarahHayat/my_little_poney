import 'package:my_little_poney/api/contest_service_io.dart';
import 'package:my_little_poney/models/Contest.dart';

class ContestUseCase {
  ContestServiceApi api = ContestServiceApi();

  Future<List<Contest>?> getAllContests() async {
    return api.getAll().then((value) => value);
  }

  Future<Contest?> fetchContestById(id) async {
    return api.fetchContestById(id).then((value) => value);
  }

  Future<Contest?> createContest(contest) async {
    return api.createContest(contest).then((value) => value);
  }

  Future<Contest?> updateContestById(contest) async {
    return api
        .updateContest(contest)
        .then((value) => value)
        .catchError((onError) => onError);
  }

  Future<Contest?> deleteContestById(id) async {
    api.deleteContest(id).then((value) => value);
  }
}
