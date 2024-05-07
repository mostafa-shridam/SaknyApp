import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakny/componantes/componantes.dart';
import 'package:sakny/build/default_form_field.dart';
import 'package:sakny/build/default_selected_date.dart';
import 'package:sakny/cubit/cubit/cubit.dart';
import 'package:sakny/cubit/cubit/states.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static String id = 'edit';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPassword = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        titleSpacing: -8,
        backgroundColor: defaultColor,
        leading: IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var userModel = UserCubit.get(context).model;
              if (userModel == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: LinearProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }
              nameController.text = userModel.name;
              phoneController.text = userModel.phone;
              bioController.text = userModel.bio;
              var userProfileImage = UserCubit.get(context).profileImage;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (state is SaknyUpdateUserLoadingState)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: LinearProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 56,
                          backgroundImage: userProfileImage == null
                              ? NetworkImage(
                                  '${userModel.image}',
                                )
                              : FileImage(userProfileImage) as ImageProvider,
                        ),
                        InkWell(
                          onTap: () {
                            UserCubit.get(context)
                                .getProfileImage(source: ImageSource.gallery);
                          },
                          child: const CircleAvatar(
                            backgroundColor: defaultColor,
                            radius: 14,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    userModel.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${userModel.email}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Type your name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    labelText: 'New user name',
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: bioController,
                    validator: (value) {
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    labelText: 'Write your bio...',
                    prefixIcon: const Icon(Icons.info_outline_rounded),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Type your phone';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    labelText: 'New phone',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    obscureText: isPassword,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is too short!';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    labelText: 'New password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: isPassword
                          ? const Icon(
                              Icons.visibility_off_outlined,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultSelectedDate(onDateSelected: (value) {
                    UserCubit.get(context).model?.birthDate = value;
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      UserCubit.get(context).updateUser(
                        phone: phoneController.text,
                        name: nameController.text,
                        bio: bioController.text,
                        // birthDate: selectedDate.toString(),
                      );
                    },
                    style: buildButtonStyle(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      elevation: const MaterialStatePropertyAll(0),
      shadowColor: const MaterialStatePropertyAll(Colors.grey),
      foregroundColor: const MaterialStatePropertyAll(Colors.black),
      overlayColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.2)),
      fixedSize: const MaterialStatePropertyAll(
        Size(120, 1),
      ),
      textStyle: const MaterialStatePropertyAll(
          TextStyle(fontWeight: FontWeight.bold)),
      shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
      side: const MaterialStatePropertyAll(
        BorderSide(
          color: defaultColor,
          width: 2,
        ),
      ),
    );
  }
}

// class DefaultSelectedDate extends StatefulWidget {
//   final Function(DateTime?) onDateSelected;
//
//   const DefaultSelectedDate({super.key, required this.onDateSelected});
//
//   @override
//   State<DefaultSelectedDate> createState() => _DefaultSelectedDateState();
// }
//
// class _DefaultSelectedDateState extends State<DefaultSelectedDate> {
//   SaknyUserModel? model;
//   DateTime? _selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         padding: const EdgeInsets.only(
//           bottom: 4,
//           right: 4,
//         ),
//         decoration: const BoxDecoration(
//           border: BorderDirectional(
//             bottom: BorderSide(
//               width: 3,
//               color: defaultColor,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.date_range_outlined),
//             const SizedBox(
//               width: 10,
//             ),
//             Text(
//               formatDate(
//                 DateTime.tryParse(model!.birthDate.toString())!,
//                 [yyyy, '-', mm, '-', dd],
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         showDatePicker(
//           context: context,
//           initialDate: _selectedDate ?? DateTime.now(),
//           fieldHintText: 'birth Date',
//           helpText: 'Birth date',
//           fieldLabelText: 'birth Date',
//           firstDate: DateTime(1900),
//           lastDate: DateTime.now(),
//         ).then(
//           (pickedDate) {
//             if (pickedDate != null) {
//               setState(
//                 () {
//                   _selectedDate = pickedDate;
//                   widget.onDateSelected(
//                       DateTime.tryParse(model!.birthDate.toString()));
//                 },
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }
