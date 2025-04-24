@echo off
echo Running build_runner for the project...
echo This will generate code for Dependency Injection, Freezed models, and JSON serialization.
echo.

flutter pub run build_runner build --delete-conflicting-outputs

if %ERRORLEVEL% NEQ 0 (
  echo.
  echo Error: Build runner failed! Check the error messages above.
  pause
  exit /b %ERRORLEVEL%
) else (
  echo.
  echo Build runner completed successfully!
  pause
) 