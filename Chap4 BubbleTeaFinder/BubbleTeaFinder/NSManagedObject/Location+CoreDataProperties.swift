// swiftlint:disable all
/// Copyright (c) 2019 Razeware LLC
///ONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import CoreData

extension Location {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
    return NSFetchRequest<Location>(entityName: "Location")
  }
  
  @NSManaged public var address: String?
  @NSManaged public var city: String?
  @NSManaged public var country: String?
  @NSManaged public var distance: Float
  @NSManaged public var state: String?
  @NSManaged public var zipcode: String?
  @NSManaged public var venue: Venue?
}
