import 'dart:io';
import 'package:blog_app/models/user.dart';
import 'package:blog_app/models/user_provider.dart';
import 'package:blog_app/users/services/database_services.dart';
import 'package:blog_app/users/services/media_services.dart';
import 'package:blog_app/users/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/users/widgets/snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  late MediaServices _mediaServices;
  late StorageService _storageServices;
  late DatabaseService _databaseServices;
  File? selectedImage;

  @override
  void initState() {
    _mediaServices = GetIt.instance.get<MediaServices>();
    _storageServices = GetIt.instance.get<StorageService>();
    _databaseServices = GetIt.instance.get<DatabaseService>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    final userData = ref.watch(userDataNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 46, 75, 150),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // image picker
            _imagePicker(userData),
            SizedBox(
              height: s.height * 0.02,
            ),
            Text(
              "${userData.name}",
              style: const TextStyle(
                color: Color.fromARGB(255, 46, 75, 150),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: s.height * 0.02,
            ),
            const Divider(),

            SizedBox(
              height: s.height * 0.02,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Full Name",
                label: const Text("Full Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 46, 75, 150),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.01,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Gender ",
                label: const Text("Gender"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 46, 75, 150),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.01,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                label: const Text("Email"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 46, 75, 150),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: s.height * 0.01,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "User Name",
                label: const Text("User Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 46, 75, 150),
                  ),
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                snackbarToast(
                    context: context,
                    title: "This Function is in Development!",
                    icon: Icons.error_outline);
              },
              child: Container(
                height: s.height * 0.06,
                width: s.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 46, 75, 150),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePicker(UserData userData) {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaServices.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // decoration: BoxDecoration(border: Border.all()),
        child: CircleAvatar(
          backgroundColor: Colors.blue[200],
          radius: MediaQuery.of(context).size.width * 0.17,
          child: CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.16,
            backgroundImage: (selectedImage != null)
                ? FileImage(selectedImage!)
                : NetworkImage("${userData.pfpURL}"),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.small(
                backgroundColor: Colors.blue[200],
                onPressed: () async {
                  File? file = await _mediaServices.getImageFromGallery();
                  if (file != null) {
                    setState(() {
                      selectedImage = file;
                    });
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
