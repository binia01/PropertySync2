import 'package:flutter/material.dart';
import 'package:my_application/core/widgets/header.dart';
import 'package:my_application/features/property/presentation/ui/widget/property_form.dart';

class CreatePropertyPage extends StatelessWidget {
  const CreatePropertyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(title: "Create a Property"),
      ),
      body: const PropertyForm(isEdit: false),
    );
  }
}
