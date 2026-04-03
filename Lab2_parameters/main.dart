import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    // NEW: Path for Product with an ID (:id)
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        // Extracting the ID from the URL path
        final id = state.pathParameters['id']!;
        // Extracting the 'filter' from the URL query (?filter=...)
        final filter = state.uri.queryParameters['filter'] ?? 'none';
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
      title: 'Lab 2: Parameters',
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
          // NEW: Navigating to a specific product with a filter
          onPressed: () => context.go('/product/101?filter=electronics'),
          child: const Text('View Product 101'),
        ),
      ),
    );
  }
}

// NEW: Screen that displays the information passed through the URL
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
        child: Text(
          'Product ID: $id\nCategory Filter: $filter',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
