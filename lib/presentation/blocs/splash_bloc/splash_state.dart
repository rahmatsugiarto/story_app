class SplashState {
  final bool isLogin;

  const SplashState({
    required this.isLogin,
  });

  SplashState copyWith({
    bool? isLogin,
  }) {
    return SplashState(
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
