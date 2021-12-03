// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_flutter/business_logic/cubit/charcaters_cubit.dart';
import 'package:bloc_flutter/constants/my_colors.dart';
import 'package:bloc_flutter/constants/strings.dart';
import 'package:bloc_flutter/view/widgets/txt.dart';
import 'package:bloc_flutter/view/widgets/txt_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  buildTitle() {
    return Center(
      child: SizedBox(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: GoogleFonts.lobster(
            fontSize: 30.0,
          ),
          child: TextLiquidFill(
            text: 'Breaking bad',
            waveColor: Colors.white,
            boxBackgroundColor: CustomColors.red,
            textStyle: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
            boxHeight: 300.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharcatersCubit, CharcatersState>(
      builder: (context, state) {
        var cubit = CharcatersCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: cubit.isSearching
                ? IconButton(
                    onPressed: () {
                      cubit.changeSearchingState();
                    },
                    icon: Icon(Icons.arrow_back_ios_new))
                : null,
            actions: _appBarActions(cubit: cubit),
            title: cubit.isSearching ? _searchBar(cubit: cubit) : buildTitle(),
          ),
          body: _buildContent(cubit: cubit, state: state),
        );
      },
    );
  }

  Widget _searchBar({required CharcatersCubit cubit}) {
    return TxtForm(
      textFieldName: "",
      editingController: searchController,
      textFieldHint: "Find a Character ...",
      onChange: (val) {
        cubit.searchCharacters(text: val);
      },
    );
  }

  // ignore: unused_element
  _appBarActions({required CharcatersCubit cubit}) {
    if (cubit.isSearching) {
      return [
        IconButton(
            onPressed: () {
              searchController.clear();
              cubit.searchCharacters(text: '');
            },
            icon: Icon(Icons.clear))
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              cubit.changeSearchingState();
              searchController.clear();
            },
            icon: Icon(Icons.search))
      ];
    }
  }

  Widget _buildContent({required cubit, required state}) {
    if (state is CharcatersInitial) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: GridForCharacters(cubit: cubit),
      );
    }
  }
}

class GridForCharacters extends StatelessWidget {
  const GridForCharacters({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final CharcatersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: cubit.isSearching
          ? cubit.searchedCharacters.length
          : cubit.characters.length,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3.6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) {
        return PannerOfCharacter(
          cubit: cubit,
          index: index,
        );
      },
    );
  }
}

class PannerOfCharacter extends StatelessWidget {
  const PannerOfCharacter({
    Key? key,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  final CharcatersCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetails,
              arguments: cubit.isSearching
                  ? cubit.searchedCharacters[index]
                  : cubit.characters[index]);
        },
        child: Column(
          children: [
            Container(
              height: 210,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Hero(
                tag: cubit.isSearching
                    ? cubit.searchedCharacters[index].charId
                    : cubit.characters[index].charId,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/load.gif',
                  image: cubit.isSearching
                      ? cubit.searchedCharacters[index].image
                      : cubit.characters[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Txt(
              cubit.isSearching
                  ? cubit.searchedCharacters[index].name
                  : cubit.characters[index].name,
              color: CustomColors.darkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
