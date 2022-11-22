part of 'auth_cubit.dart';

class AuthState {
  final UserModel? user;
  final String errorMessages;

  const AuthState({
    required this.user,
    required this.errorMessages,
  });
}
