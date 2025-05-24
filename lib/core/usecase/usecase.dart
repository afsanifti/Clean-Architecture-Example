import 'package:testingapp/core/utils/typedefs.dart';

// We use this classes to make our inherited classes callable
// We can use the core functionality of a class just by making an instance

abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
