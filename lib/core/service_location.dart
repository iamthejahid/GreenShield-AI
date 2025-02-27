import 'package:get_it/get_it.dart';
import 'package:greenshield_ai/features/predict/data/deepseek/deep_seek_repo.dart';
import 'package:greenshield_ai/features/predict/data/ml/ml_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerLazySingleton<ModelRepo>(ModelRepoImpl.new)
    ..registerLazySingleton<DeepSeekRepo>(DeepSeekRepoImpl.new);
}
