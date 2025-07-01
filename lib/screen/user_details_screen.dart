import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                user.name,
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  shadows: isDark
                      ? [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.8),
                    )
                  ]
                      : null,
                ),
              ),
              background: Hero(
                tag: 'user-${user.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: theme.colorScheme.onPrimary,
                      child: Text(
                        user.name[0],
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    context,
                    'Contact Info',
                    [
                      _buildInfoItem(Icons.email, 'Email', user.email),
                      _buildInfoItem(Icons.phone, 'Phone', user.phone),
                      _buildInfoItem(Icons.language, 'Website', user.website),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Address',
                    [
                      _buildInfoItem(Icons.home, 'Street', user.address.street),
                      _buildInfoItem(Icons.home_work, 'Suite', user.address.suite),
                      _buildInfoItem(Icons.location_city, 'City', user.address.city),
                      _buildInfoItem(Icons.local_post_office, 'Zipcode', user.address.zipcode),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    context,
                    'Company',
                    [
                      _buildInfoItem(Icons.business, 'Name', user.company.name),
                      _buildInfoItem(Icons.format_quote, 'Catch Phrase', user.company.catchPhrase),
                      _buildInfoItem(Icons.work, 'BS', user.company.bs),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          Clipboard.setData(ClipboardData(text: user.email));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Copied ${user.email} to clipboard'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.copy),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}