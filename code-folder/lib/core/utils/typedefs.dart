import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

typedef ResultEither<T> = Future<Either<Failure, T>>;
typedef ResultOption = Future<Option<Failure>>;
