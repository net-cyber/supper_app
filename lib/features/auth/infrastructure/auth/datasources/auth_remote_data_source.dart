import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_code_response.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_confirm_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegistrationResponse> register(Registration registration);
  Future<VerificationCodeResponse> sendVerificationCode(String phoneNumber);
  Future<VerificationConfirmResponse> verifyOtp(String phoneNumber, String otp);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<RegistrationResponse> register(Registration registration) async {
    try {
      final Map<String, dynamic> data = {
        'username': registration.userName.value.getOrElse(() => ''),
        'full_name': registration.fullName.value.getOrElse(() => ''),
        'international_phone_number': registration.phoneNumber.value.getOrElse(() => ''),
        'password': registration.password.value.getOrElse(() => ''),
      };
      
      final response = await getIt<HttpService>().client(requireAuth: false).post(
        '/users',
        data: data,
      );
      
      return RegistrationResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e;
    }
  }

  @override
  Future<VerificationCodeResponse> sendVerificationCode(String phoneNumber) async {
    try {
      final Map<String, dynamic> data = {
        'phone_number': phoneNumber,
      };
      
      final response = await getIt<HttpService>().client(requireAuth: false).post(
        '/verify/send',
        data: data,
      );
      
      return VerificationCodeResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e;
    }
  }

  @override
  Future<VerificationConfirmResponse> verifyOtp(String phoneNumber, String otp) async {
    try {
      final Map<String, dynamic> data = {
        'phone_number': phoneNumber,
        'otp': otp,
      };
      
      final response = await getIt<HttpService>().client(requireAuth: false).post(
        '/verify/confirm',
        data: data,
      );
      
      return VerificationConfirmResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e;
    }
  }
} 