import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class NextPageEvent extends OnboardingEvent {}

class SkipEvent extends OnboardingEvent {}

class PageChangedEvent extends OnboardingEvent {
  final int index;

  const PageChangedEvent(this.index);

  @override
  List<Object?> get props => [index];
}
