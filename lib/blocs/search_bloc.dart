import 'package:rxdart/rxdart.dart';
import 'package:test_project/models/responses.dart';
import 'package:test_project/repos/app_repo.dart';

class MarkersCollectionBloc {
  AppRepository _repo = AppRepository();
  BehaviorSubject<PokemonResponse> _behaviorSubject =
      BehaviorSubject<PokemonResponse>();

  PokemonResponse defaultItem = PokemonResponseInitial();

  Stream<PokemonResponse> get stream => _behaviorSubject.stream;

  pickEvent(PokemonResponse type) {
    _behaviorSubject.sink.add(type);
  }

  searchRandom() async {
    _behaviorSubject.sink.add(PokemonResponseLoading());
    var response = await _repo.getPokemonById();
    _behaviorSubject.sink.add(response);
  }

  searchByName(String name) async {
    _behaviorSubject.sink.add(PokemonResponseLoading());
    var response = await _repo.getPokemonByName(name);
    _behaviorSubject.sink.add(response);
  }

  dispose() {
    _behaviorSubject.close();
  }
}
