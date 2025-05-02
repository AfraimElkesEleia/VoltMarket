import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volt_market/core/helper/app_regex.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/features/profile/logic/cubit/profile_cubit.dart';
import 'package:volt_market/features/profile/ui/widget/my_orders_button.dart';
import 'package:volt_market/features/profile/ui/widget/profile_card.dart';
import 'package:volt_market/features/signup/model/profile.dart'; // For using SVG icons

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? profile;
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile();
  }

  final _picker = ImagePicker();
  void _pickImage() async {
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      context.read<ProfileCubit>().img = File(pickedImage.path);
      context.read<ProfileCubit>().updateProfileImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), elevation: 0),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        buildWhen:
            (previous, current) =>
                (current is Loading) ||
                current is ProfileError ||
                current is ProfileLoaded,
        listener: (context, state) {
          if (state is LoggedOut) {
            context.pushNamedAndRemoveUntil(
              MyRoutes.loginScreen,
              (route) => false,
            );
          } else if (state is RequestPermission) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please enable location permission'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is NetworkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error in Network Conection'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ErrorGps) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error while trying get location: ${state.message}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(
              child: Text('Error on loading profile ${state.message}'),
            );
          }
          profile = context.read<ProfileCubit>().profile;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        profile?.imgProfile ??
                            'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
                      ),
                      backgroundColor: Colors.grey[300],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            // Add image picker functionality
                            _pickImage();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // User Name
                Text(
                  profile?.name ?? 'Null',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // User Email
                Text(
                  profile?.email ?? 'Null',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 30),
                ProfileCard(profile: profile),
                SizedBox(height: 30),
                // Logout Button
                MyOrdersButton(),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      // Logout functionality
                      _logout();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Edit profile floating button
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          _showEditProfileDialog(profile!);
        },
      ),
    );
  }

  // Placeholder functions for the functionality

  void _logout() {
    // Implement logout functionality
    context.read<ProfileCubit>().logout();
  }

  void _showEditProfileDialog(Profile profile) {
    String? userName;
    String? userEmail;
    String? userAddress;
    String? userCity;
    String? userZip;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Form(
              key: context.read<ProfileCubit>().formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    onChanged: (value) => userName = value,
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: "Address"),
                    onChanged: (value) => userAddress = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "City"),
                    onChanged: (value) => userCity = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "ZIP Code"),
                    onChanged: (value) => userZip = value,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(child: Text("Cancel"), onPressed: () => context.pop()),
            TextButton(
              child: Text("Save"),
              onPressed: () {
                if (context
                    .read<ProfileCubit>()
                    .formKey
                    .currentState!
                    .validate()) {
                  context.read<ProfileCubit>().updateProfile(
                    Profile(
                      uuid: FirebaseAuth.instance.currentUser!.uid,
                      name: userName ?? '',
                      imgProfile: '',
                      address: userAddress ?? '',
                      city: userCity ?? '',
                      zip: userZip ?? '',
                    ),
                  );
                }
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
