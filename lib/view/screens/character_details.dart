import 'package:bloc_flutter/business_logic/cubit/charcaters_cubit.dart';
import 'package:bloc_flutter/constants/my_colors.dart';
import 'package:bloc_flutter/data/model/character.dart';
import 'package:bloc_flutter/view/widgets/txt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Txt(
          widget.character.name,
          size: 25,
          color: Colors.white,
        ),
        background: Hero(
          tag: widget.character.charId,
          child: Image.network(
            widget.character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  buildQouteContent({required CharcatersCubit cubit, required state}) {
    if (state is QuoteLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            color: CustomColors.red,
            backgroundColor: CustomColors.lightRed,
          ),
        ),
      );
    } else {
      if (cubit.quots.isEmpty) {
        return Container();
      } else {
        return Column(
          children: [
            buildTile(title: 'Some Quotes', text: ''),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Txt(
                cubit.quots.join('\n\n'),
                maxLine: cubit.quots.length,
                weight: FontWeight.bold,
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        buildSliverAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildTile(
                  title: 'Job', text: widget.character.occupation.join(',')),
              buildTile(title: 'Nickname', text: widget.character.nickname),
              buildTile(
                  title: 'Appeared in',
                  text: widget.character.appearance.join(' / ')),
              buildTile(title: 'Status', text: widget.character.status),
              buildTile(title: 'Actor name', text: widget.character.portrayed),
              buildTile(title: 'Birthday', text: widget.character.birthday),
              BlocBuilder<CharcatersCubit, CharcatersState>(
                builder: (context, state) {
                  var cubit = CharcatersCubit.get(context);
                  return buildQouteContent(cubit: cubit, state: state);
                },
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ],
    ));
  }

  Padding buildTile({required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.red, width: 1),
                color: CustomColors.red,
                borderRadius: BorderRadius.circular(15)),
            child: Txt(
              '$title : ',
              size: 23,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(child: Txt(text))
        ],
      ),
    );
  }

  @override
  void initState() {
    CharcatersCubit.get(context)
        .getQuotesOfCharacter(charName: widget.character.name);

    super.initState();
  }
}
