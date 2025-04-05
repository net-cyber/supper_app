import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/router/route_name.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Smart Financial Planning',
      description: 'Track your spending, set budgets, and reach your financial goals faster.',
      illustration: AppConstants.gohbetochLogoHorizontal,
    ),
    OnboardingItem(
      title: 'Secure Investments',
      description: 'Diversify your portfolio with our range of low-risk investment options.',
      illustration: AppConstants.gohbetochLogoHorizontal,
    ),
    OnboardingItem(
      title: 'Instant Payments',
      description: 'Send and receive money globally with zero fees and instant transfers.',
      illustration: AppConstants.gohbetochLogoHorizontal,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TextButton(
                  onPressed: () => _onFinish(context),
                  child: Text(
                    'Skip',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _buildPage(context, item);
                },
              ),
            ),
            
            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _items.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: colorScheme.primary,
                  dotColor: colorScheme.primary.withOpacity(0.3),
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 6,
                  expansionFactor: 3,
                ),
              ),
            ),
            
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (hidden on first page)
                  _currentPage > 0
                      ? TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            'Back',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.primary,
                            ),
                          ),
                        )
                      : const SizedBox(width: 80),
                  
                  // Next/Finish button
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage < _items.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _onFinish(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage < _items.length - 1 ? 'Next' : 'Get Started',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, OnboardingItem item) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SVG Illustration
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                item.illustration,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Title
          Text(
            item.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          // Description
          Text(
            item.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _onFinish(BuildContext context) {
    // Navigate to login after onboarding
    context.goNamed(RouteName.login);
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String illustration;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.illustration,
  });
} 