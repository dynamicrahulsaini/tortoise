import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/navigation/navigation_service.dart';
import 'core/theme/app_colors.dart';
import 'features/product_catalog/pages/product_catalog_screen.dart';
import 'features/product_catalog/bloc/product_catalog_bloc.dart';
import 'features/product_catalog/bloc/product_catalog_event.dart';
import 'features/product_catalog/repositories/product_catalog_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCatalogBloc>(
          create: (context) => ProductCatalogBloc(
            ProductCatalogRepository(),
          )..add(const LoadProducts()),
        ),
      ],
      child: MaterialApp(
        title: 'Marketplace App',
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontFamilyFallback: GoogleFonts.inter().fontFamilyFallback,
            textTheme: GoogleFonts.interTextTheme(),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.black1,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.black1,
              scrolledUnderElevation: 0.0,
              surfaceTintColor: Colors.transparent,
            )),
        home: const ProductCatalogScreen(),
      ),
    );
  }
}
