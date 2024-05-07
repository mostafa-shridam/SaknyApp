import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/cubit/post_cubit/post_cubit.dart';
import 'package:sakny/custom_widgets/card_list_view.dart';
import 'package:sakny/build/quarter_button_view.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/models/post_model.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        List<PostModel> post = PostCubit.get(context).posts;
        return post.isEmpty
            ? Center(
                child: progressLoading(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  physics: const ScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: QuarterButton(
                        onTap: () {},
                        buttonText: 'Add Some',
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: CardListView(),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
