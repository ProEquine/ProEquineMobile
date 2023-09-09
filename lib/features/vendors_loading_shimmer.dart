// import 'package:flutter/material.dart';
//
// import '../../../../core/constants/constants.dart';
// import '../../../../core/utils/extensions.dart';
// import '../../../../core/widgets/shimmer.dart';
//
// class VendorsLoadingShimmer extends StatelessWidget {
//   const VendorsLoadingShimmer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer(
//       child: ListView(
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: ShimmerLoading(
//                     child: Container(
//                       height: 45,
//                       decoration: const BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 24.0,
//                 ),
//                 ShimmerLoading(
//                   child: Container(
//                     width: 45,
//                     height: 45,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                       color: Colors.grey,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 30.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kPadding),
//             child: ShimmerLoading(
//               child: Container(
//                 height: 30,
//                 decoration: const BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//               ),
//             ),
//           ),
//           // const SizedBox(
//           //   height: 20.0,
//           // ),
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: kPadding),
//           //   child: ShimmerLoading(
//           //
//           //     child: Container(
//           //       height: 45,
//           //       decoration: const BoxDecoration(
//           //         color: Colors.grey,
//           //         borderRadius: BorderRadius.all(Radius.circular(10)),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           SizedBox(
//             height: 40.0,
//             child: ListView(
//               physics: const BouncingScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               children: [
//                 const SizedBox(
//                   width: kPadding,
//                 ),
//                 ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const SizedBox(
//                       width: 14.0,
//                     );
//                   },
//                   itemBuilder: (BuildContext context, int index) {
//                     return ShimmerLoading(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0,
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 78.0,
//                         ),
//                         decoration: const BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(12),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   itemCount: 10,
//                 ),
//                 const SizedBox(
//                   width: kPadding,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 14.0),
//                 child: ShimmerLoading(
//                   child: Container(
//                     height: 10,
//                     width: 70,
//                     decoration: const BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           GridView.builder(
//             shrinkWrap: true,
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             physics: const BouncingScrollPhysics(),
//             itemCount: 20,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: context.width ~/ 160,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 14.0,
//               mainAxisSpacing: 20.0,
//             ),
//             itemBuilder: (context, index) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ShimmerLoading(
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                       child: AspectRatio(
//                         aspectRatio: 1.13,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ShimmerLoading(
//                     child: Container(
//                       height: 10,
//                       width: 50,
//                       decoration: const BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 7,
//                   ),
//                   ShimmerLoading(
//                     child: Container(
//                       height: 10,
//                       width: 100,
//                       decoration: const BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VendorsLoadingList extends StatelessWidget {
//   const VendorsLoadingList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(horizontal: 30.0),
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: 20,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: context.width ~/ 160,
//           childAspectRatio: 0.75,
//           crossAxisSpacing: 14.0,
//           mainAxisSpacing: 20.0,
//         ),
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ShimmerLoading(
//                 child: ClipRRect(
//                   borderRadius: const BorderRadius.all(Radius.circular(20)),
//                   child: AspectRatio(
//                     aspectRatio: 1.13,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               ShimmerLoading(
//                 child: Container(
//                   height: 10,
//                   width: 50,
//                   decoration: const BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 7,
//               ),
//               ShimmerLoading(
//                 child: Container(
//                   height: 10,
//                   width: 100,
//                   decoration: const BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
