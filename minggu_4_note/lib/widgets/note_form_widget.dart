import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget({
    super.key,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.onChangedIsImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription
  });

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangedIsImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Switch(
                  value: isImportant,
                  onChanged: onChangedIsImportant,
                ),
                Expanded(
                  child: Slider(
                    value: number.toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (value) => onChangedNumber(value.toInt()),
                  ),
                )
              ],
            ),
            _buildTitleField(),
            const SizedBox(height: 8),
            _buildDescriptionField()
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
      decoration: const InputDecoration(
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none
      ),
      onChanged: onChangedTitle,
      validator: (title) {
        return title != null && title.isEmpty ? 'Title cannot be empty' : null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: 1,
      initialValue: description,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
      decoration: const InputDecoration(
        hintText: 'Type sumthing~',
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none
      ),
      onChanged: onChangedDescription,
      validator: (desc) {
        return desc != null && desc.isEmpty ? 'Description cannot be empty' : null;
      },
    );
  }
}
