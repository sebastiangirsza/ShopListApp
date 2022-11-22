import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

part 'verification_state.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._userRemoteDataSource)
      : super(
          const VerificationState(
            errorMessage: null,
            sent: false,
          ),
        );
  final UserRemoteDataSource _userRemoteDataSource;

  Future<void> sendVerificationEmail() async {
    try {
      await _userRemoteDataSource.currentUser()!.sendEmailVerification();
      emit(
        const VerificationState(
          errorMessage: null,
          sent: false,
        ),
      );
    } catch (error) {
      emit(
        VerificationState(
          errorMessage: error.toString(),
          sent: true,
        ),
      );
    }
  }
}
