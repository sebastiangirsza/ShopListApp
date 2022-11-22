part of 'verification_cubit.dart';

class VerificationState {
  final String? errorMessage;
  final bool sent;

  const VerificationState({
    required this.errorMessage,
    required this.sent,
  });
}
