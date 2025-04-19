import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_code_response.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_confirm_response.dart';
import 'package:super_app/features/auth/domain/login/entities/login_response.dart';

abstract class AuthRemoteDataSource {
  Future<RegistrationResponse> register(Registration registration);
  Future<VerificationCodeResponse> sendVerificationCode(String phoneNumber);
  Future<VerificationConfirmResponse> verifyOtp(String phoneNumber, String otp);
  Future<LoginResponse> login(String username, String password);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<RegistrationResponse> register(Registration registration) async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm token is !!$fcmToken');
      // Get the profile photo path if available
      final profilePhotoPath = registration.profilePhoto.value.getOrElse(() => null);
      
      // Create a FormData object for multipart request
      final FormData formData = FormData.fromMap({
        'username': registration.userName.value.getOrElse(() => ''),
        'full_name': registration.fullName.value.getOrElse(() => ''),
        'international_phone_number': registration.phoneNumber.value.getOrElse(() => ''),
        'password': registration.password.value.getOrElse(() => ''),
        // Add FCM token if needed - assuming a default value for now
        'fcmtoken': fcmToken, 
      });
      
      // Add logo/profile photo if path is available
      if (profilePhotoPath != null && profilePhotoPath.isNotEmpty) {
        // Create MultipartFile from the file path
        final File imageFile = File(profilePhotoPath);
        
        if (await imageFile.exists()) {
          formData.files.add(
            MapEntry(
              'logo', 
              await MultipartFile.fromFile(
                profilePhotoPath,
                filename: profilePhotoPath.split('/').last,
              ),
            ),
          );
        }
      }
      
      // Use the HttpService with multipart flag set to true
      final response = await getIt<HttpService>()
          .client(isMultipart: true)
          .post('/users', data: formData);
      
      return RegistrationResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerificationCodeResponse> sendVerificationCode(String phoneNumber) async {
    try {
      final data = <String, dynamic>{
        'phone_number': phoneNumber,
      };
      
      final response = await getIt<HttpService>().client().post(
        '/verify/send',
        data: data,
      );
      
      return VerificationCodeResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<VerificationConfirmResponse> verifyOtp(String phoneNumber, String otp) async {
    try {
      final data = <String, dynamic>{
        'phone_number': phoneNumber,
        'otp': otp,
      };
      
      final response = await getIt<HttpService>().client().post(
        '/verify/confirm',
        data: data,
      );
      
      return VerificationConfirmResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> login(String username, String password) async {
    try {
      final data = <String, dynamic>{
        'username': username,
        'password': password,
      };
      
      final response = await getIt<HttpService>().client().post(
        '/users/login',
        data: data,
      );
      
      return LoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      rethrow;
    }
  }
} 