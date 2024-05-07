import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sakny/componantes/componantes.dart';

class DefaultSelectedDate extends StatefulWidget {
  final Function(String?) onDateSelected;

  const DefaultSelectedDate({super.key, required this.onDateSelected});

  @override
  State<DefaultSelectedDate> createState() => _DefaultSelectedDateState();
}

class _DefaultSelectedDateState extends State<DefaultSelectedDate> {
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 4,
          right: 4,
        ),
        decoration: const BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              width: 3,
              color: defaultColor,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range_outlined),
            const SizedBox(
              width: 10,
            ),
            Text(
              _selectedDate != null
                  ? formatDate(
                      DateTime.tryParse(_selectedDate.toString())!,
                      [yyyy, '-', mm, '-', dd],
                    )
                  : "Select Date",
            ),
          ],
        ),
      ),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate:
              DateTime.tryParse(_selectedDate.toString()) ?? DateTime.now(),
          fieldHintText: 'birth Date',
          helpText: 'Birth date',
          fieldLabelText: 'birth Date',
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ).then(
          (pickedDate) {
            if (pickedDate != null) {
              setState(
                () {
                  _selectedDate = pickedDate.toString();
                  widget.onDateSelected(_selectedDate);
                },
              );
            }
          },
        );
      },
    );
  }
}
