import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/poke_bloc.dart';
import '../repository/poke_repository.dart';
import '../components/poke_card.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  late final PokeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PokeBloc(pokeRepository: context.read<PokeRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokeRand"),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          bloc.add(const PokeGet());
        },
        label: const Text("Get a Poke!"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: BlocConsumer<PokeBloc, PokeState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is PokeError) {
                _showError(state.error);
              }
            },
            builder: (context, state) {
              if (state is PokeLoaded) {
                return PokeCard(poke: state.poke);
              } else if (state is PokeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Text(
                  'Press the button to generate a Pokemon',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    // Shows SnackBar when error occurs
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            const Text(
              "Error",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
