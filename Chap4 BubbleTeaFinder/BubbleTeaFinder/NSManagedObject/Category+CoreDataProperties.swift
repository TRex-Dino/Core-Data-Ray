// swiftlint:disable all
/// Copyright (c) 2019 Razeware LLC
///

import Foundation
import CoreData

extension Category {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
    return NSFetchRequest<Category>(entityName: "Category")
  }
  
  @NSManaged public var categoryID: String?
  @NSManaged public var name: String?
  @NSManaged public var venue: Venue?
}
