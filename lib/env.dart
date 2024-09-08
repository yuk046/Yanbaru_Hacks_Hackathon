import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: 'env/.env')
abstract class Env {
  @EnviedField(varName: 'APIKEY')
  static final String apikey = _Env.apikey;

}