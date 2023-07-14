class ExampleCubit<T> extends Cubit<T, Mediator<dynamic>> {
  ExampleCubit(Mediator<dynamic> mediator) : super(mediator);

  @override
  String get cubitId => 'exampleCubit';

  @override
  void handleMediatorMessage(dynamic data) {
    // Handle the mediator message data of type T
  }
}

final mediator = Mediator<dynamic>();
final cubit = ExampleCubit<int>(mediator);

cubit.emit(42);  // Emit a state of type int
cubit.sendMessage(CubitMessage<int>(cubit.cubitId, 123));  // Send a message of type int

cubit.dispose();
mediator.dispose();
