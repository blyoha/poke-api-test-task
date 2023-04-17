part of 'poke_bloc.dart';

@immutable
abstract class PokeState {
  const PokeState();
}

class PokeInitial extends PokeState {}

class PokeLoading extends PokeState {
  const PokeLoading();
}

class PokeLoaded extends PokeState {
  final PokeModel poke;

  const PokeLoaded({required this.poke});
}

class PokeError extends PokeState {
  final String error;

  const PokeError({required this.error});
}
