import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/poke_bloc.dart';
import '../components/poke_card.dart';
import '../config/theme.dart';
import '../models/poke_model.dart';
import '../repository/poke_repository.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final PokeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PokeBloc(pokeRepository: context.read<PokeRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("PokeSearch"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            children: [
              const Gap(10.0),
              _buildSearchBar(),
              Expanded(
                child: BlocConsumer(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state is PokeError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    if (state is PokeLoaded) {
                      return _buildPokeInfo(state.poke);
                    } else if (state is PokeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Center(
                      child: Text(
                        "Find your Pokemon!",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final searchController = TextEditingController();
    final searchFocus = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          // Search bar field
          Expanded(
            child: TextField(
              autocorrect: false,
              focusNode: searchFocus,
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.secondary.withOpacity(0.5),
                prefixIcon: const Icon(Icons.search_rounded),
                prefixIconColor: Colors.black.withOpacity(0.5),
                label: const Text(
                  "Pokemon name or ID",
                  style: TextStyle(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.secondary.withOpacity(0.5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.secondary.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const Gap(10.0),

          // Search button
          MaterialButton(
            color: AppColors.secondary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: const Text("Search"),
            onPressed: () {
              final String name = searchController.text.toLowerCase();

              if (name.isNotEmpty) {
                bloc.add(PokeGet(pokeName: name));
                searchFocus.unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enter a Pokemon name")));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPokeInfo(PokeModel poke) {
    return PokeCard(poke: poke);
  }
}
