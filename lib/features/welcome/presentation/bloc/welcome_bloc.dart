import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState()) {
    on<UpdatePageIndex>((event, emit) {
      emit(WelcomeState(currentPage: event.index));
    });
  }
} 