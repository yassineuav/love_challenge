import 'package:app/core/core.dart';
import 'package:appwrite/appwrite.dart';

abstract class IAuthAPI {
  FutureEither<Account> signUp({
    required String email,
    required String password,
  });
}


