// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final requiredController = TextEditingController();

  bool isAccepted = false;
  String? gender;
  bool notifications = false;
  double experience = 5;
  RangeValues ageRange = const RangeValues(18, 30);
  String? city;
  String? language;

  final cities = ['Sana\'a', 'Aden', 'Taiz', 'Ibb'];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    requiredController.dispose();
    super.dispose();
  }

  void showSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your Information'),
          content: Text('''
Name: ${nameController.text}
Email: ${emailController.text}
Phone: ${phoneController.text}
Required Field: ${requiredController.text}
Agreement: $isAccepted
Gender: $gender
Notifications: $notifications
Experience: $experience
Age: ${ageRange.start.round()} - ${ageRange.end.round()}
City: $city
Language: $language'''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TextField - Name
              TextField(
                controller: nameController,

                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),

              // 2. TextFormField - Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  return value!.contains('@') ? null : 'Invalid email';
                },
              ),
              const SizedBox(height: 12),

              // 3. TextFormField - Phone Number
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  return value!.length == 10 ? null : 'Invalid phone number';
                },
              ),
              const SizedBox(height: 12),

              // 4. TextFormField - Required Field
              TextFormField(
                controller: requiredController,
                decoration: const InputDecoration(labelText: 'Required Field'),
                validator: (value) {
                  return value!.isEmpty ? 'Required' : null;
                },
              ),
              const SizedBox(height: 12),

              // 5. FormField<bool> - Checkbox - Terms Agreement
              FormField<bool>(
                initialValue: false,
                validator: (value) {
                  return value == true ? null : 'Agree to the terms';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: const Text('I agree to the terms'),
                        value: isAccepted,
                        onChanged: (value) {
                          setState(() {
                            isAccepted = value ?? false;
                          });

                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            field.errorText!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),

              // 6. FormField<String> - Radio - Gender
              FormField<String>(
                validator: (value) {
                  return value != null ? null : 'Select a gender';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });

                          field.didChange(value);
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });

                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            field.errorText!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),

              // 7. Switch - Notifications
              SwitchListTile(
                title: const Text('Notifications'),
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 8. FormField<double> - Slider - Experience
              FormField<double>(
                initialValue: 5,
                validator: (value) {
                  return value! >= 0 && value <= 10 ? null : 'Out of range';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Experience: ${experience.toStringAsFixed(1)}'),
                      Slider(
                        min: 0,
                        max: 10,
                        value: experience,
                        onChanged: (value) {
                          setState(() {
                            experience = value;
                          });

                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),

              // 9. FormField<RangeValues> - RangeSlider - Age
              FormField<RangeValues>(
                initialValue: ageRange,
                validator: (value) {
                  return value!.start < value.end ? null : 'Invalid range';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age: '
                        '${ageRange.start.round()} - '
                        '${ageRange.end.round()}',
                      ),
                      RangeSlider(
                        min: 1,
                        max: 100,
                        values: ageRange,
                        onChanged: (value) {
                          setState(() {
                            ageRange = value;
                          });

                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),

              // 10. FormField<String> - DropdownButton - City
              FormField<String>(
                validator: (value) {
                  return value != null ? null : 'Select a city';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        value: city,
                        hint: const Text('Select City'),
                        isExpanded: true,
                        items: cities.map((cityName) {
                          return DropdownMenuItem<String>(
                            value: cityName,
                            child: Text(cityName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            city = value;
                          });

                          field.didChange(value);
                        },
                      ),
                      if (field.hasError)
                        Text(
                          field.errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),

              // 11. FormField<String> - PopupMenuButton - Language
              FormField<String>(
                validator: (value) {
                  return value != null ? null : 'Select a language';
                },
                builder: (field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PopupMenuButton<String>(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(language ?? 'Select Language'),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                        onSelected: (value) {
                          setState(() {
                            language = value;
                          });

                          field.didChange(value);
                        },
                        itemBuilder: (context) {
                          return const [
                            PopupMenuItem(
                              value: 'English',
                              child: Text('English'),
                            ),
                            PopupMenuItem(
                              value: 'Arabic',
                              child: Text('Arabic'),
                            ),
                          ];
                        },
                      ),
                      if (field.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            field.errorText!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        showSummary();
                        // }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                  // Reset Button
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          nameController.clear();
                          emailController.clear();
                          phoneController.clear();
                          requiredController.clear();

                          isAccepted = false;
                          gender = null;
                          notifications = false;

                          experience = 5;

                          ageRange = const RangeValues(18, 30);

                          city = null;
                          language = null;
                        });

                        formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
