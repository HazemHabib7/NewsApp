import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layouts/news_app/cubit/cubit.dart';
import '../../../layouts/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';


class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return cubit.science.isEmpty ? const Center(child: CircularProgressIndicator()) : buildArticleList(list: cubit.science);
      },
    );
  }
}
