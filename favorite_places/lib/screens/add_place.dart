import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceState();
  }
}

class _AddPlaceState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(
          enteredTitle,
          _selectedImage!,
          _selectedLocation!,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(
                pickedImg: (image) {
                  _selectedImage = image;
                },
              ),
              LocationInput(
                onselectLocation: (location) {
                  _selectedLocation = location;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _savePlace,
                label: const Text('Add Place'),
                icon: const Icon(Icons.add),
              )
            ],
          )),
    );
  }
}
