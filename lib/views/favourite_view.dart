import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/cubit/post_cubit/post_cubit.dart';
import 'package:sakny/models/post_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PostCubit.get(context).favourite.isEmpty
              ? Center(
                  child: progressLoading(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: PostCubit.get(context).favourite.length,
                  itemBuilder: (context, index) => FavouriteCard(
                    model: PostCubit.get(context).posts[index],
                  ),
                );
        },
      ),
    );
  }
}

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({super.key, required this.model});

  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: defaultColor,
          width: 3,
        ),
      ),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Row(
          children: [
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${model.postImage} '),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          model.name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                '${model.text}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
