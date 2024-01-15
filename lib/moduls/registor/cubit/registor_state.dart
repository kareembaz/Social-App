abstract class RegistorStates {}

class RegistorInitialState extends RegistorStates {}

class registorLoadingState extends RegistorStates {}

class registorSccessState extends RegistorStates {}

class registoreErorrState extends RegistorStates {
  final String error;

  registoreErorrState(this.error);
}

class CreateUserSccessState extends RegistorStates {}

class CreateUserErorrState extends RegistorStates {
  final String error;

  CreateUserErorrState(this.error);
}

class showRegistorPasswordState extends RegistorStates {}
