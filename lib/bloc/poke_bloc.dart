import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/poke_model.dart';
import '../repository/poke_repository.dart';

part 'poke_event.dart';

part 'poke_state.dart';

class PokeBloc extends Bloc<PokeEvent, PokeState> {
  final PokeRepository pokeRepository;

  PokeBloc({required this.pokeRepository}) : super(PokeInitial()) {
    on<PokeGet>(_onPokeGetEvent);
  }

  _onPokeGetEvent(PokeGet event, Emitter<PokeState> emit) async {
    emit(const PokeLoading());

    late final PokeModel poke;
    try {
      poke = await pokeRepository.getPoke(name: event.pokeName);
      emit(PokeLoaded(poke: poke));
    } catch (e) {
      emit(PokeError(error: e.toString()));
    }
  }
}
