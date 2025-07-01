import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/color.dart';
import '../model/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(user.name, style: TextStyle(fontSize: 24)),
              background: Hero(
                tag: 'user-${user.id}',
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.5),
                        AppColors.light.withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 40,
                      child: Text(
                        user.name[0],
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                  _buildInfoCard(context, 'Contact Info', [
                    _buildInfoItem(Icons.email, 'Email', user.email),
                    _buildInfoItem(Icons.phone, 'Phone', user.phone),
                    _buildInfoItem(Icons.language, 'Website', user.website),
                  ]),
                  const SizedBox(height: 16),
                  _buildInfoCard(context, 'Address', [
                    _buildInfoItem(Icons.home, 'Street', user.address.street),
                    _buildInfoItem(
                      Icons.home_work,
                      'Suite',
                      user.address.suite,
                    ),
                    _buildInfoItem(
                      Icons.location_city,
                      'City',
                      user.address.city,
                    ),
                    _buildInfoItem(
                      Icons.local_post_office,
                      'Zipcode',
                      user.address.zipcode,
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildInfoCard(context, 'Company', [
                    _buildInfoItem(Icons.business, 'Name', user.company.name),
                    _buildInfoItem(
                      Icons.format_quote,
                      'Catch Phrase',
                      user.company.catchPhrase,
                    ),
                    _buildInfoItem(Icons.work, 'BS', user.company.bs),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
      /// copy button
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        elevation: 2,
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
        child: const Icon(Icons.copy , color: Colors.white, ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 1,surfaceTintColor: AppColors.light,


      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 21 ,fontWeight: FontWeight.bold , color: AppColors.secondary),
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
          Icon(icon, size: 20 , color: AppColors.primary,),
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
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
