// swiftlint:disable all
/// Copyright (c) 2019 Razeware LLC
///

import Foundation
import CoreData

extension PriceInfo {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<PriceInfo> {
    return NSFetchRequest<PriceInfo>(entityName: "PriceInfo")
  }
  
  @NSManaged public var priceCategory: String?
  @NSManaged public var venue: Venue?
}
