import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/poke_model.dart';

class PokeCard extends StatelessWidget {
  final PokeModel poke;

  const PokeCard({Key? key, required this.poke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poke image
          Image.network(poke.image),

          // Poke name and ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                poke.name.toUpperCase().replaceAll("-", " "),
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ID: ${poke.id}",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          _buildDivider(),

          // Poke weight and height
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildParameter("Weight", poke.weight.toString()),
              _buildParameter("Height", poke.height.toString()),
            ],
          ),
          _buildDivider(),

          // Poke abilities
          const Text(
            "Abilities",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Gap(8.0),
          _buildItems(poke.abilities),
          _buildDivider(),

          // Poke forms
          const Text(
            "Forms",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          const Gap(8.0),
          _buildItems(poke.forms),

          const Gap(80.0),
        ],
      ),
    );
  }

  Widget _buildParameter(String parameter, String value) {
    return Column(
      children: [
        Text(parameter, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(10.0),
        Text(value),
      ],
    );
  }

  Widget _buildItems(List items) {
    return SizedBox(
      height: 40.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black.withOpacity(0.1),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          child: Text(items[index]),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Column(
      children: [
        Gap(10.0),
        Divider(),
        Gap(10.0),
      ],
    );
  }
}
