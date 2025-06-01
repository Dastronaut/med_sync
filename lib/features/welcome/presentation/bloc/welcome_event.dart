import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToSignIn extends WelcomeEvent {}

class UpdatePageIndex extends WelcomeEvent {
  final int index;

  const UpdatePageIndex(this.index);

  @override
  List<Object?> get props => [index];
} 