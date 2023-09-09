import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:proequine/features/horses/presentation/widgets/delete_horse_bottom_sheet.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';

class DocumentWidget extends StatefulWidget {
  String? title;
  String? date;
  Function? onTapEdit;
  Function? onTapDelete;

  DocumentWidget({
    super.key,
    required this.title,
    required this.date,
    required this.onTapDelete,
    required this.onTapEdit,
  });

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          // A pane can dismiss the Slidable.
          // All actions are defined in the children parameter.
          children: [
            Expanded(
              flex: 1,
              child: Builder(
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Colors.red),
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.delete, color: AppColors.white),
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                Slidable.of(context)!.close();
                                showDeleteHorseBottomSheet(context: context, title: "Delete Document", content: Column(
                                  children: [
                                    Text(
                                      "Are you sure you want to delete ${widget.title} ? ",
                                      style: AppStyles.descriptions,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Submit",
                                        style: TextStyle(color: AppColors.red),
                                      ),
                                    )
                                  ],
                                ));
                              });

                              widget.onTapDelete!();

                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ]),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.8, color: Color(0xFFDFD9C9)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.blackLight,
                      fontSize: 14,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    'Expires on ${widget.date}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  widget.onTapEdit!();
                },
                child: const Text(
                  "Edit",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Color(0xFFC48636),
                    fontSize: 14,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//           child: Slidable(
//             endActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 extentRatio: 0.25,
//                 // A pane can dismiss the Slidable.
//                 // All actions are defined in the children parameter.
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                         left: 8,
//                       ),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           color: Colors.red),
//                       child: Column(
//                         children: [
//                           BlocConsumer<CreateAuctionCubit, CreateAuctionState>(
//                             // bloc: createAuctionCubit..getLots(widget.auctionId),
//                             listener: (context, state) {
//                               if (state is DeleteLotSuccessfully) {
//                                 RebiMessage.success(
//                                     msg: "Lot Deleted Successfully".tra);
//                                 final slidableState = Slidable.of(context);
//                                 slidableState!.close();
//                               }
//                             },
//                             builder: (context, state) {
//                               if (state is DeleteLotLoading) {
//                                 return Expanded(child: LoadingCircularWidget());
//                               } else {
//                                 return Expanded(
//                                   child: InkWell(
//                                     child: SizedBox(
//                                       width: double.infinity,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: const [
//                                           Icon(Icons.delete,
//                                               color: AppColors.white),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       final slidableState =
//                                           Slidable.of(context);
//                                       slidableState!.close();
//                                       _onPressDeleteLot(
//                                           widget.item, context, widget.lotId);
//                                     },
//                                   ),
//                                 );
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ]),
//             child: Card(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   SizedBox(
//                       height: 60,
//                       width: 120,
//                       child: Image.network(widget.image ??
//                           'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg')),
//                   Column(
//                     children: [
//                       Text(widget.name!),
//                       Row(
//                         children: [
//                           Text(widget.startTime!),
//                           Text(widget.endTime!),
//                         ],
//                       ),
//                       Text(widget.category!),
//                       Row(
//                         children: [
//                           IconButton(
//                             icon:  Icon(Icons.remove,color: isSubmitted?Colors.black:Colors.grey),
//                             onPressed: () {
//                               if(isSubmitted){
//                                 setState(() {
//                                   isThereChanges = true;
//                                   if (widget.productCount > 0) {
//                                     widget.productCount = widget.productCount - 1;
//                                   }
//                                   calculateLotCost(widget.productCount);
//                                 });
//                               }else{
//
//                               }
//
//                             },
//                           ),
//                           Text(
//                             widget.productCount.toString(),
//                             style:  TextStyle(fontSize: 16,color: isSubmitted?Colors.black:Colors.grey),
//                           ),
//                           IconButton(
//                             icon:  Icon(Icons.add,color: isSubmitted?Colors.black:Colors.grey),
//                             onPressed: () {
//                               if(isSubmitted){
//                                 setState(() {
//                                   isThereChanges = true;
//                                   if (widget.productCount < 10) {
//                                     widget.productCount = widget.productCount + 1;
//
//                                     calculateLotCost(widget.productCount);
//                                   }
//                                 });
//                               }else{
//
//                               }
//
//                             },
//                           ),
//                         ],
//                       ),
//                       Center(
//                           child: Row(
//                         children: [
//                           Text("The Price is ".tra),
//                           Text(widget.price.toString(),style: TextStyle(color: isSubmitted?Colors.black:Colors.grey),),
//                           Text(" AED".tra),
//                         ],
//                       )),
//                       isSubmitted?RebiButton(
//                           backgroundColor:
//                               isThereChanges ? Colors.green : Colors.grey,
//                           onPressed: () async{
//                             if (isThereChanges) {
//                               Print(widget.productCount);
//                               await _localStorageRepository.editSpecificLot(
//                                   widget.auctionId,
//                                   widget.lotId,
//                                   Lot(
//                                     name: widget.lot.name,
//                                     //Todo: fix the description
//                                     description: widget.lot.description,
//                                     startTime: widget.lot.startTime,
//                                     endTime: widget.lot.endTime,
//                                     id: widget.lotId,
//                                     categoryType: widget.lot.categoryType,
//                                     products: widget.lot.products,
//                                     productsCount: widget.productCount,
//                                     lotPrice: widget.price,
//                                   ));
//                               createAuctionCubit.getLots(widget.auctionId);
//                               Print(isThereChanges);
//
//
//                               setState(() {
//                                 isSubmitted = false;
//
//                               });
//                             } else {}
//                           },
//                           child: const Text("Submit the changes")):const SizedBox()
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   _onPressDeleteLot(Auction auction, BuildContext context, String lotId) {
//     createAuctionCubit.deleteLot(DeleteLotSuccessfully(item: auction), lotId);
//   }
// }
