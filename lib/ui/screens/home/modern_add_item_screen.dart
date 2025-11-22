import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../models/item_model.dart';
import '../../../providers/item_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/modern_widgets.dart';

/// Modern Add Item screen - Instagram style
class ModernAddItemScreen extends ConsumerStatefulWidget {
  const ModernAddItemScreen({super.key});

  @override
  ConsumerState<ModernAddItemScreen> createState() => _ModernAddItemScreenState();
}

class _ModernAddItemScreenState extends ConsumerState<ModernAddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  final _picker = ImagePicker();

  ItemType _selectedType = ItemType.lost;
 XFile? _selectedImage;
  Uint8List? _imagePreview;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1280,
      imageQuality: 85,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    setState(() {
      _selectedImage = picked;
      _imagePreview = bytes;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(itemControllerProvider.notifier);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final success = await notifier.addItem(
      type: _selectedType,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      location: _locationController.text.trim(),
      contact: _contactController.text.trim(),
      image: _selectedImage,
    );

    if (success && mounted) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text('Item posted successfully! 🎉'),
          backgroundColor: AppColors.foundItemColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _selectedType = ItemType.lost;
        _selectedImage = null;
        _imagePreview = null;
        _titleController.clear();
        _descriptionController.clear();
        _locationController.clear();
        _contactController.clear();
      });
    } else if (!success && mounted) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text('Failed to post item'),
          backgroundColor: AppColors.lostItemColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addState = ref.watch(itemControllerProvider);
    final color = _selectedType == ItemType.lost
        ? AppColors.lostItemColor
        : AppColors.foundItemColor;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // Modern App Bar
            SliverAppBar.large(
            floating: true,
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Add Item',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              expandedTitleScale: 1.3,
            ),
          ),

          // Form Content
          SliverPadding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            sliver: SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Type Selector
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _TypeButton(
                                label: 'Lost',
                                icon: Icons.search_rounded,
                                color: AppColors.lostItemColor,
                                isSelected: _selectedType == ItemType.lost,
                                onTap: () =>
                                    setState(() => _selectedType = ItemType.lost),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _TypeButton(
                                label: 'Found',
                                icon: Icons.check_circle_rounded,
                                color: AppColors.foundItemColor,
                                isSelected: _selectedType == ItemType.found,
                                onTap: () =>
                                    setState(() => _selectedType = ItemType.found),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn().slideY(begin: -0.1),
                      const SizedBox(height: 24),

                      // Image Picker
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: color.withOpacity(0.3),
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: _imagePreview != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.memory(
                                        _imagePreview!,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: IconButton(
                                          icon: const Icon(Icons.close_rounded,
                                              color: Colors.white),
                                          onPressed: () {
                                            setState(() {
                                              _selectedImage = null;
                                              _imagePreview = null;
                                            });
                                          },
                                          style: IconButton.styleFrom(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate_outlined,
                                        size: 48, color: color),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tap to add photo',
                                      style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ).animate().fadeIn(delay: const Duration(milliseconds: 100)),
                      const SizedBox(height: 24),

                      // Form Fields
                      ModernTextField(
                        controller: _titleController,
                        label: 'Title',
                        hint: 'What did you lose/find?',
                        prefixIcon: Icons.title_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                      const SizedBox(height: 16),

                      ModernTextField(
                        controller: _descriptionController,
                        label: 'Description',
                        hint: 'Provide details...',
                        prefixIcon: Icons.description_outlined,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                      const SizedBox(height: 16),

                      ModernTextField(
                        controller: _locationController,
                        label: 'Location',
                        hint: 'Where was it lost/found?',
                        prefixIcon: Icons.location_on_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
                      const SizedBox(height: 16),

                      ModernTextField(
                        controller: _contactController,
                        label: 'Contact Number',
                        hint: 'How can we reach you?',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Valid contact number required';
                          }
                          return null;
                        },
                      ).animate().fadeIn(delay: const Duration(milliseconds: 500)),
                      const SizedBox(height: 32),

                      // Submit Button
                      GradientButton(
                        text: 'Publish Item',
                        icon: Icons.send_rounded,
                        onPressed: addState.isLoading ? null : _submit,
                        isLoading: addState.isLoading,
                        height: 56,
                      ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
                      const SizedBox(height: 80), // Extra bottom spacing for mobile
                    ],
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
}

class _TypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? color : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : color,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
