import 'dart:async';

abstract class MediatorMessage<T> {
  final String id;
  final T data;

  MediatorMessage(this.id, this.data);
}

class CubitMessage<T> extends MediatorMessage<T> {
  CubitMessage(String id, T data) : super(id, data);
}

class Mediator<T> {
  final _messageStreamController = StreamController<MediatorMessage<T>>.broadcast();
  Stream<MediatorMessage<T>> get messageStream => _messageStreamController.stream;

  void sendMessage(MediatorMessage<T> message) {
    _messageStreamController.sink.add(message);
  }

  void dispose() {
    _messageStreamController.close();
  }
}

abstract class Cubit<T, M extends Mediator<dynamic>> {
  final M mediator;
  final _stateStreamController = StreamController<T>.broadcast();
  Stream<T> get stateStream => _stateStreamController.stream;

  Cubit(this.mediator) {
    mediator.messageStream.listen((message) {
      if (message is CubitMessage<T>) {
        if (message.id == cubitId) {
          handleMediatorMessage(message.data);
        }
      }
    });
  }

  String get cubitId;

  void emit(T state) {
    _stateStreamController.sink.add(state);
  }

  void handleMediatorMessage(dynamic data);

  void sendMessage(MediatorMessage<dynamic> message) {
    mediator.sendMessage(message);
  }

  void dispose() {
    _stateStreamController.close();
  }
}
