// import 'package:fake_store/core/shared/constants/app_colors.dart';
// import 'package:fake_store/core/shared/constants/app_styles.dart';
// import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PriceFilterSlider extends StatefulWidget {
//   const PriceFilterSlider({super.key});

//   @override
//   State<PriceFilterSlider> createState() => _PriceFilterSliderState();
// }

// class _PriceFilterSliderState extends State<PriceFilterSlider> {
//   late RangeValues _currentRange;

//   @override
//   void initState() {
//     super.initState();
//     final cubit = context.read<HomeCubit>();
//     _currentRange = RangeValues(cubit.selectedMinPrice, cubit.selectedMaxPrice);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<HomeCubit>();

//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Text('Filter by Price:', style: AppStyles.styleMedium18),
//             ],
//           ),
//           const SizedBox(height: 20),
//           RangeSlider(
//             values: _currentRange,
//             min: 0,
//             max: 1000,
//             divisions: 20,
//             activeColor: AppColors.primaryColor,
//             labels: RangeLabels(
//               '\$${_currentRange.start.round()}',
//               '\$${_currentRange.end.round()}',
//             ),
//             onChanged: (RangeValues values) {
//               setState(() {
//                 _currentRange = values;
//               });
//             },
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               cubit.filterByPrice(_currentRange.start, _currentRange.end);
//               Navigator.pop(context);
//             },
//             child: Text(
//               'Apply Filter',
//               style: AppStyles.styleMedium16.copyWith(
//                 color: AppColors.primaryColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
