
import 'package:ecommerce_admin_app/src/category/presentation/views/widgets/edit_category_form_field.dart';
import 'package:flutter/material.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditCategoryFormField(
          controller: nameController,
          title: 'FULL NAME',
          // hintText: context.currentUser!.name,
        ),
        const SizedBox(height: 30,),
        EditCategoryFormField(
          title: 'EMAIL ADDRESS',
          controller: emailController,
          // hintText: context.currentUser!.email.obscureEmail,
        ),
        const SizedBox(height: 30,),
        EditCategoryFormField(
          title: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        const SizedBox(height: 30,),
        StatefulBuilder(
          builder: (context, setState) {
            oldPasswordController.addListener(()=> setState((){}));
            return EditCategoryFormField(
              title: 'PASSWORD',
              controller: passwordController,
              hintText: '********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        const SizedBox(height: 30,),
        EditCategoryFormField(
          title: 'BIO', 
          controller: bioController,
          // hintText: context.currentUser!.bio,
          maxLength: 500,
          isTextArea: true,
        ),
      ],
    );
  }
}
