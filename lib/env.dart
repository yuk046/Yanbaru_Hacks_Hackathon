import 'package:envied/envied.dart';
import 'package:munimuniohagi/env/env.dart';

@Envied(path: 'env/.env')
abstract class Env {
  @EnviedField(varName: 'APIKEY')
  static final String key = Env.key;

}