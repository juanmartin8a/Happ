import 'package:equatable/equatable.dart';

abstract class ReverseLocationDetailsState extends Equatable {
  const ReverseLocationDetailsState();

  @override
  List<Object?> get props => [];
}

class ReverseLocationDetailsInitState extends ReverseLocationDetailsState {}

class ReverseLocationDetailsLoadedState extends ReverseLocationDetailsState {
  final String name;

  const ReverseLocationDetailsLoadedState({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}