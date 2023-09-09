
import 'package:hive/hive.dart';
import 'package:proequine/features/home/data/local_horse.dart';

import '../../../../../core/CoreModels/base_local_storage_repository.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = '1232';
  String idsBoxName = 'horse';

  /// Method to create auction
  @override
  Future<void> createHorse(Box<dynamic> box, Horse item) async {
    await box.put(item.id, item);
  }

  // @override
  // Future<void> addAuctionIds(String id) async {
  //   Box box = await Hive.openBox<String>(idsBoxName);
  //   await box.put(id, id);
  // }
  //
  // /// Method to delete all of the auctions
  // @override
  // Future<void> clearAuctions(Box<dynamic> box) async {
  //   await box.clear();
  // }
  //
  // /// Method to delete a specific auction
  // @override
  // Future<void> deleteAuction(Box box, Auction item) async {
  //   await box.delete(item.id);
  // }
  //
  // @override
  // Future<void> deleteAuctionIds(String id) async {
  //   Box box = await Hive.openBox<String>(idsBoxName);
  //   await box.delete(id);
  // }
  //
  /// Method to get the auction
  @override
  List<Horse> getHorses(Box box) {
    return box.values.toList() as List<Horse>;
  }
  //
  // /// Method to get the lots inside a specific auction
  // List<Lot> getLots(String auctionId) {
  //   Box box = Hive.box<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //   return auction?.lots ?? [];
  // }
  //
  // /// open the ids box
  // @override
  // Future<Box> openAuctionIdsBox() async {
  //   Box box = await Hive.openBox<int>(idsBoxName);
  //   return box;
  // }
  //
  // /// open the auctions box
  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Horse>(boxName);
    return box;
  }
  //
  // /// method to create lot inside the auction
  // @override
  // Future<void> addLotToAuction(String auctionId, Lot lot) async {
  //   Box box = await Hive.openBox<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //
  //   if (auction != null) {
  //     auction.lots.add(lot);
  //     await box.put(auctionId, auction);
  //   }
  // }
  //
  // @override
  // Future<void> editSpecificLot(String auctionId, String lotId, Lot updatedLot) async {
  //   final box = await Hive.openBox<Auction>(boxName); // Open the Hive box for 'auctions'
  //
  //   final auction = box.values.cast<Auction>().firstWhere((a) => a.id == auctionId,);
  //   if (auction != null) {
  //     final lot = auction.lots.firstWhere((l) => l.id == lotId,);
  //     if (lot != null) {
  //       lot.productsCount = updatedLot.productsCount; // Update the lot properties as needed
  //       lot.lotPrice = updatedLot.lotPrice;
  //       // Update other properties accordingly
  //
  //       await box.put(auction.key, auction); // Update the auction in Hive
  //       Print('Lot with ID $lotId in auction with ID $auctionId successfully updated.');
  //     } else {
  //       Print('Lot with ID $lotId not found in auction with ID $auctionId.');
  //     }
  //   } else {
  //     Print('Auction with ID $auctionId not found in Hive.');
  //   }
  //
  //   await box.close(); // Close the Hive box
  // }
  //
  // /// method to delete the lot from the auction
  // @override
  // Future<void> deleteLotFromAuction(String auctionId, String lotId) async {
  //   Box box = await Hive.openBox<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //
  //   if (auction != null) {
  //     auction.lots.removeWhere((lot) => lot.id == lotId);
  //     await box.put(auctionId, auction);
  //   }
  // }
  //
  // /// Method to get the products from a specific lot
  // @override
  // List<Product> getProducts(String auctionId, String lotId) {
  //   Box box = Hive.box<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //
  //   if (auction != null) {
  //     Lot? lot = auction.lots
  //         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
  //     if (lot != null) {
  //       return lot.products;
  //     }
  //   }
  //
  //   return [];
  // }
  //
  // /// method to create a product inside a specific lot
  // @override
  // Future<void> addProduct(
  //     String auctionId, String lotId, Product product) async {
  //   Box box = await Hive.openBox<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //
  //   if (auction != null) {
  //     Lot? lot = auction.lots
  //         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
  //     Print("lot id $lotId");
  //     Print("lot id.. ${lot.id}");
  //
  //     if (lot.id != null) {
  //       lot.products.add(product);
  //       Print(lot.products);
  //
  //       await box.put(auctionId, auction);
  //     }
  //   }
  // }
  //
  // /// method to delete a product from a specific lot
  // @override
  // Future<void> deleteProduct(
  //     String auctionId, String lotId, String productId) async {
  //   Box box = await Hive.openBox<Auction>(boxName);
  //   Auction? auction = box.get(auctionId);
  //
  //   if (auction != null) {
  //     Lot? lot = auction.lots
  //         .firstWhere((lot) => lot.id == lotId, orElse: () => auction.lots[0]);
  //
  //     if (lot != null) {
  //       lot.products.removeWhere((product) => product.id == productId);
  //       await box.put(auctionId, auction);
  //     }
  //   }
  // }
}
