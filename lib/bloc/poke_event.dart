part of 'poke_bloc.dart';

@immutable
abstract class PokeEvent {
  const PokeEvent();
}

class PokeGet extends PokeEvent {
  final String? pokeName;

  const PokeGet({this.pokeName});
}
