part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileEntity profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final UserProfileEntity profile;

  const ProfileUpdated({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileLoggingOut extends ProfileState {}

class ProfileLoggedOut extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
