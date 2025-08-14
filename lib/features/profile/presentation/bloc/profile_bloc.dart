import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../../../core/usecases/usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileBloc({
    required this.getUserProfileUseCase,
    required this.updateProfileUseCase,
    required this.logoutUseCase,
  }) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    
    final result = await getUserProfileUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile: profile)),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating());
    
    final result = await updateProfileUseCase(event.profile);
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileUpdated(profile: profile)),
    );
  }

  Future<void> _onLogout(Logout event, Emitter<ProfileState> emit) async {
    emit(ProfileLoggingOut());
    
    final result = await logoutUseCase(const NoParams());
    
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(ProfileLoggedOut()),
    );
  }
}
