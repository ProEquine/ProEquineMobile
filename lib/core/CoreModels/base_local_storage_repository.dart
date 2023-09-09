
import 'package:hive/hive.dart';
import 'package:proequine/features/home/data/local_horse.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();

  List<Horse> getHorses(Box box);

  Future<void> createHorse(Box box, Horse item);
  //
  // Future<void> deleteAuction(Box box, Auction item);
  //
  // Future<void> clearAuctions(Box box);
  //
  // Future<Box> openAuctionIdsBox();
  //
  // Future<void> addAuctionIds(String id);
  //
  // Future<void> deleteAuctionIds(String id);
  //
  // Future<void> addLotToAuction(String id, Lot lot);
  //
  // Future<void> editSpecificLot(String auctionIndex,String lotIndex, Lot lot);
  //
  // Future<void> deleteLotFromAuction(String auctionId, String lotId);
  //
  // Future<void> addProduct(String auctionId, String lotId, Product product);
  // Future<void> deleteProduct(String auctionId, String lotId, String productId);
  //
  // List<Product> getProducts(String auctionId, String lotId);
}
