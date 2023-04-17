import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../bloc/poke_bloc.dart';
import '../config/theme.dart';

class SearchBar extends StatefulWidget {
  final PokeBloc bloc;

  const SearchBar({Key? key, required this.bloc}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final searchController = TextEditingController();
  final searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                widget.bloc.add(PokeGet(pokeName: name));
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
}
