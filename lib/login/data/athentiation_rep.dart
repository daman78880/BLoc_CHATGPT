class AuthRepository {
  Future<bool> login(String email, String password) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 2));
    return email == 'test@example.com' && password == 'password123';
  }
}