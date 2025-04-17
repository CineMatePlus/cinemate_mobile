import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/models/user.dart';
import '../../service/service.dart';

class EditProfileState {
  final User? user;
  final bool isLoading;
  final String? error;

  const EditProfileState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  EditProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return EditProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final editProfileProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>((ref) {
  return EditProfileNotifier();
});

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  EditProfileNotifier() : super(const EditProfileState()) {
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    state = state.copyWith(isLoading: true);
    try {
      final user =
          await ProfileService().me(); // Aynı sample user'ı kullanıyoruz
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'Profil yüklenirken bir hata oluştu',
        isLoading: false,
      );
    }
  }

  Future<void> updateProfile() async {
    //FIXME
    final updatedUser = state.user?.copyWith(
      name: state.user?.name ?? '',
      email: state.user?.email ?? '',
    );

    if (updatedUser != null) {
      state = state.copyWith(user: updatedUser);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
