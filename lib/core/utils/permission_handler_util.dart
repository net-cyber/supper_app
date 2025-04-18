import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

/// A utility class to handle permissions throughout the app
class PermissionHandlerUtil {
  /// Check and request camera permission
  static Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus status = await Permission.camera.status;
    
    if (status.isGranted) {
      return true;
    }
    
    if (status.isDenied) {
      status = await Permission.camera.request();
      return status.isGranted;
    }
    
    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog(
        context,
        'Camera access is required',
        'Please enable camera access in your device settings to continue.',
      );
      return false;
    }
    
    if (status.isRestricted || status.isLimited) {
      _showPermissionDeniedDialog(
        context,
        'Camera access is restricted',
        'Camera permissions are restricted on your device.',
      );
      return false;
    }
    
    return false;
  }
  
  /// Check and request photo library/storage permission
  static Future<bool> requestPhotoLibraryPermission(BuildContext context) async {
    PermissionStatus status;
    
    if (Platform.isIOS) {
      status = await Permission.photos.status;
      
      if (status.isGranted) {
        return true;
      }
      
      if (status.isDenied) {
        status = await Permission.photos.request();
        return status.isGranted;
      }
    } else {
      // On Android, we need storage permission
      status = await Permission.storage.status;
      
      if (status.isGranted) {
        return true;
      }
      
      if (status.isDenied) {
        status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    
    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog(
        context,
        'Storage access is required',
        'Please enable storage access in your device settings to continue.',
      );
      return false;
    }
    
    if (status.isRestricted || status.isLimited) {
      _showPermissionDeniedDialog(
        context,
        'Storage access is restricted',
        'Storage permissions are restricted on your device.',
      );
      return false;
    }
    
    return false;
  }
  
  /// Show a dialog when permission is permanently denied
  static void _showPermissionDeniedDialog(
    BuildContext context, 
    String title, 
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: Text(
              'Open Settings',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Show error dialog for permission-related errors
  static void showErrorDialog(
    BuildContext context, 
    String title, 
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: GoogleFonts.outfit(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.outfit(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 