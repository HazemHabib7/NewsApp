import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/network/local/cache_helper.dart';
import 'dark_mode_states.dart';

class DarkModeCubit extends Cubit<DarkStates> {
  DarkModeCubit() : super(NewsChangeModeState());
  static DarkModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({ bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }
}