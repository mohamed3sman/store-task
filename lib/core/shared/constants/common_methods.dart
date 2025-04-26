validateField({String? value}) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter this field';
  }
  return null;
}
