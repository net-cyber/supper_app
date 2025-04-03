import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegistrationResponse> register(Registration registration);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpService _httpService;

  AuthRemoteDataSourceImpl(this._httpService);

  @override
  Future<RegistrationResponse> register(Registration registration) async {
    try {
      final Map<String, dynamic> data = {
        'username': registration.userName.value.getOrElse(() => ''),
        'full_name': registration.fullName.value.getOrElse(() => ''),
        'international_phone_number': registration.phoneNumber.value.getOrElse(() => ''),
        'password': registration.password.value.getOrElse(() => ''),
      };
      
      final response = await _httpService.client().post(
        '/users',
        data: data,
      );
      
      return RegistrationResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e;
    }
  }
} 