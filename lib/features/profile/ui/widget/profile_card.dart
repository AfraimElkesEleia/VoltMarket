import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volt_market/features/signup/model/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile? profile;
  const ProfileCard({super.key, required this.profile});

  void _getCurrentLocation() async {
    // Implement GPS functionality
    // You can use location package for this
    print("GPS functionality will be implemented here");
  }

  @override
  Widget build(BuildContext context) {
    return
    // Profile Details Card
    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Address with GPS button
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue),
              title: Text('Address'),
              subtitle: Text(profile?.address ?? "Null"),
              trailing: IconButton(
                icon: Icon(Icons.gps_fixed, color: Colors.blue),
                onPressed: () {
                  // GPS functionality
                  _getCurrentLocation();
                },
              ),
            ),
            Divider(),

            // City
            ListTile(
              leading: Icon(Icons.location_city, color: Colors.blue),
              title: Text('City'),
              subtitle: Text(profile?.city ?? "Null"),
            ),
            Divider(),

            // ZIP Code
            ListTile(
              leading: Icon(Icons.markunread_mailbox, color: Colors.blue),
              title: Text('ZIP Code'),
              subtitle: Text(profile?.zip ?? "Null"),
            ),
          ],
        ),
      ),
    );
  }
}
