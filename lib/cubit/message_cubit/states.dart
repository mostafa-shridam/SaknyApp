abstract class MessageStates {}

class MessageInitial extends MessageStates {}

class SendMessageLoading extends MessageStates {}

class GetUserDataLoading extends MessageStates {}

class GetUserDataSuccess extends MessageStates {}

class GetUserDataError extends MessageStates {}

class SendMessageSuccess extends MessageStates {}

class SendMessageError extends MessageStates {
  final String error;

  SendMessageError(this.error);
}

class GetMessageSuccess extends MessageStates {}

class GetMessageError extends MessageStates {
  final String error;

  GetMessageError(this.error);
}
