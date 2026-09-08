enum AppStates { initial, loading, success, error ,registerLoading,googleLoading,neededCompleteProfile}

extension AppStatesExtension on AppStates {
  bool get isInitial => this == AppStates.initial;
  bool get isLoading => this == AppStates.loading;
  bool get isSuccess => this == AppStates.success;
  bool get isError => this == AppStates.error;
  bool get isRegisterLoading => this == AppStates.registerLoading;
  bool get isGoogleLoading => this == AppStates.googleLoading;
  bool get isNeededCompleteProfile => this == AppStates.neededCompleteProfile;
}