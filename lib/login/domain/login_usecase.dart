import '../data/athentiation_rep.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<bool> execute(String email, String password) {
    return authRepository.login(email, password);
  }
}