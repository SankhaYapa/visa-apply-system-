import 'dart:convert';

import 'package:alwaysvisa/components/custom_button.dart';
import 'package:alwaysvisa/components/custom_dialogBox.dart';
import 'package:alwaysvisa/components/custom_text.dart';
import 'package:alwaysvisa/components/custome_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

final nameController = TextEditingController();
final mobileController = TextEditingController();
final emailController = TextEditingController();
final subjectControler = TextEditingController();
final descriptionController = TextEditingController();
Future sendEmail() async {
  final serviceId = 'service_rp38611';
  final templateId = 'template_j3hpazi';
  final userId = '8Oq0drGqIM-XZduJK';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          "name": nameController.text,
          "subject": subjectControler.text,
          "mobile": mobileController.text,
          "email": emailController.text,
          "description": descriptionController.text,
        }
      }));
  return response.statusCode;
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Full Name',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                hintText: 'Enter Full Name',
                controller: nameController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Mobile Number',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                hintText: 'Enter Mobile Number',
                controller: mobileController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Email Address',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                hintText: 'Enter Email Address',
                controller: emailController,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Subject',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                hintText: 'Enter Subject or Reason for contacting',
                controller: subjectControler,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Description',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                hintText: 'Enter Description',
                controller: descriptionController,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                  onTap: () {
                    if (inputValidation()) {
                      sendEmail();
                      DialogBox().dialogBox(
                        context,
                        DialogType.SUCCES,
                        'Successfuly Deliverd',
                        'Your appliction form successfully deliverd',
                      );
                    } else {
                      DialogBox().dialogBox(
                        context,
                        DialogType.ERROR,
                        'Please fill all details',
                        'Please enter correct Information',
                      );
                    }

                    print("sent");
                  },
                  text: 'Contact Now'),
            ],
          ),
        ),
      ),
    );
  }

  bool inputValidation() {
    var isValid = false;
    if (nameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        emailController.text.isEmpty ||
        subjectControler.text.isEmpty ||
        descriptionController.text.isEmpty) {
      isValid = false;
    } else if (!EmailValidator.validate(emailController.text)) {
      isValid = false;
    } else {
      isValid = true;
    }
    return isValid;
  }
}
