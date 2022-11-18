part of 'auth_cubit.dart';

class AuthState {
  final UserModel? user;
  final String errorMessages;

  const AuthState({
    required this.user,
    required this.errorMessages,
  });
}

class VerificationState {
  final String? errorMessage;
  final bool sent;

  const VerificationState({
    required this.errorMessage,
    required this.sent,
  });
}
