import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final filter = state.uri.queryParameters['filter'] ?? 'all';
        return ProductDetailScreen(id: id, filter: filter);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Lab 3: Navigation Stack',
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/product/99?filter=latest'),
          child: const Text('View Product 99'),
        ),
      ),
    );
  }
}

// UPDATED: Added a "Back to Home" button for Lab 3
class ProductDetailScreen extends StatelessWidget {
  final String id;
  final String filter;
  const ProductDetailScreen({
    super.key,
    required this.id,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product $id')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product ID: $id\nFilter: $filter'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'), // NEW: Navigates back to Home
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
