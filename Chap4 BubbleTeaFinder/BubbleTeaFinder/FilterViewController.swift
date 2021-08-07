/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///

import UIKit
import CoreData

protocol FilterViewControllerDelegate: AnyObject {
  func filterViewController(
    filter: FilterViewController,
    didSelectPredicate predicate: NSPredicate?,
    sortDescriptor: NSSortDescriptor?
  )
}

class FilterViewController: UITableViewController {
  @IBOutlet weak var firstPriceCategoryLabel: UILabel!
  @IBOutlet weak var secondPriceCategoryLabel: UILabel!
  @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
  @IBOutlet weak var numDealsLabel: UILabel!

  // MARK: - Price section
  @IBOutlet weak var cheapVenueCell: UITableViewCell!
  @IBOutlet weak var moderateVenueCell: UITableViewCell!
  @IBOutlet weak var expensiveVenueCell: UITableViewCell!

  // MARK: - Most popular section
  @IBOutlet weak var offeringDealCell: UITableViewCell!
  @IBOutlet weak var walkingDistanceCell: UITableViewCell!
  @IBOutlet weak var userTipsCell: UITableViewCell!

  // MARK: - Sort section
  @IBOutlet weak var nameAZSortCell: UITableViewCell!
  @IBOutlet weak var nameZASortCell: UITableViewCell!
  @IBOutlet weak var distanceSortCell: UITableViewCell!
  @IBOutlet weak var priceSortCell: UITableViewCell!

  //MARK: - Properties
  var coreDataStack: CoreDataStack!
  
  weak var delegate: FilterViewControllerDelegate?
  var selectedSortDescriptior: NSSortDescriptor?
  var selectedPredicate: NSPredicate?
  
  //MARK:
  lazy var cheapVenuePredicate: NSPredicate = {
    NSPredicate(format: "%K == %@",
                #keyPath(Venue.priceInfo.priceCategory), "$")
  }()
  
  lazy var moderateVenuePredicate: NSPredicate = {
    NSPredicate(format: "%K == %@",
                #keyPath(Venue.priceInfo.priceCategory), "$$")
  }()
  
  lazy var expensiveVenuePredicate: NSPredicate = {
    NSPredicate(format: "%K == %@",
                #keyPath(Venue.priceInfo.priceCategory), "$$$")
  }()
  
  lazy var offeringDealPredicate: NSPredicate = {
    NSPredicate(format: "%K > 0",
                #keyPath(Venue.specialCount))
  }()
  
  lazy var walkingDistancePredicate: NSPredicate = {
    NSPredicate(format: "%K > 500",
                #keyPath(Venue.location.distance))
  }()
  
  lazy var hasUserTipsPredicate: NSPredicate = {
    NSPredicate(format: "%K > 0",
                #keyPath(Venue.stats.tipCount))
  }()
  
  //MARK: initialize NSSortDescriptor
  lazy var nameSortDescriptor: NSSortDescriptor = {
    let compareSelector =
      #selector(NSString.localizedStandardCompare(_:))
    return NSSortDescriptor(key: #keyPath(Venue.name),
                            ascending: true,
                            selector: compareSelector)
  }()
  
  lazy var distanceSortDescriptor: NSSortDescriptor = {
    return NSSortDescriptor(
      key: #keyPath(Venue.location.distance),
      ascending: true)
  }()
  
  lazy var priceSortDescriptor: NSSortDescriptor = {
    return NSSortDescriptor(
      key: #keyPath(Venue.priceInfo.priceCategory),
      ascending: true)
  }()

  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    populateCheapVenueCountLabel()
    populateModerateVenueCountLabel()
    populateExpensiveVenueCountLabel()
  }
}

// MARK: - IBActions
extension FilterViewController {
  @IBAction func search(_ sender: UIBarButtonItem) {
    delegate?.filterViewController(filter: self,
                                   didSelectPredicate: selectedPredicate,
                                   sortDescriptor: selectedSortDescriptior)
    dismiss(animated: true)
  }
}

// MARK: - UITableViewDelegate
extension FilterViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else {
      return
    }
    
    switch cell {
    // Price section
    case cheapVenueCell:
      selectedPredicate = cheapVenuePredicate
    case moderateVenueCell:
      selectedPredicate = moderateVenuePredicate
    case expensiveVenueCell:
      selectedPredicate = expensiveVenuePredicate
      
    // Most Popular section
    case offeringDealCell:
      selectedPredicate = offeringDealPredicate
    case walkingDistanceCell:
      selectedPredicate = walkingDistancePredicate
    case userTipsCell:
      selectedPredicate = hasUserTipsPredicate
      
    // Sort By section
    case nameAZSortCell:
      selectedSortDescriptior = nameSortDescriptor
      //We can reuse nameAZSortCell with reversedSortDescriptor
    case nameAZSortCell:
      selectedSortDescriptior = nameSortDescriptor.reversedSortDescriptor as? NSSortDescriptor
    case distanceSortCell:
      selectedSortDescriptior = distanceSortDescriptor
    case priceSortCell:
      selectedSortDescriptior = priceSortDescriptor
    default: break
    }
    
    cell.accessoryType = .checkmark
  }
}

//MARK: - Helper methods
extension FilterViewController {
  func populateCheapVenueCountLabel() {
    let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Venue")
    fetchRequest.resultType = .countResultType
    fetchRequest.predicate = cheapVenuePredicate
    
    do {
      let countResult = try coreDataStack.managedContext.fetch(fetchRequest)
      
      let count = countResult.first?.intValue ?? 0
      let pluralized = count == 1 ? "place" : "places"
      firstPriceCategoryLabel.text = "\(count) bubble tea \(pluralized)"
    } catch let error as NSError {
      print("count not fetch \(error), \(error.userInfo)")
    }
  }
  
  func populateModerateVenueCountLabel() {
    let fetchRequest = NSFetchRequest<NSNumber>(entityName: "Venue")
    fetchRequest.resultType = .countResultType
    fetchRequest.predicate = moderateVenuePredicate
    
    do {
      let countResult =
        try coreDataStack.managedContext.fetch(fetchRequest)
      let count = countResult.first?.intValue ?? 0
      let pluralized = count == 1 ? "place" : "places"
      secondPriceCategoryLabel.text =
        "\(count) bubble tea \(pluralized)"
    } catch let error as NSError {
      print("count not fetched \(error), \(error.userInfo)")
    }
  }
  
  func populateExpensiveVenueCountLabel() {
    let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
    fetchRequest.predicate = expensiveVenuePredicate
    
    do {
      //here we don't have resultType, and we take count with method cound(for:)
      let count =
        try coreDataStack.managedContext.count(for: fetchRequest)
      let pluralized = count == 1 ? "place" : "places"
      thirdPriceCategoryLabel.text =
        "\(count) bubble tea \(pluralized)"
    } catch let error as NSError {
      print("count not fetched \(error), \(error.userInfo)")
    }
  }
  
  func populateDealsCountLabel() {
    // 1
    let fetchRequest =
      NSFetchRequest<NSDictionary>(entityName: "Venue")
    fetchRequest.resultType = .dictionaryResultType
    
    // 2
    let sumExpressionDesc = NSExpressionDescription()
    sumExpressionDesc.name = "sumDeals"
    
    // 3
    let specialCountExp =
      NSExpression(forKeyPath: #keyPath(Venue.specialCount))
    sumExpressionDesc.expression =
      NSExpression(forFunction: "sum:",
                   arguments: [specialCountExp])
    sumExpressionDesc.expressionResultType =
      .integer32AttributeType
    
    // 4
    fetchRequest.propertiesToFetch = [sumExpressionDesc]
    
    //5
    do {
      let results =
        try coreDataStack.managedContext.fetch(fetchRequest)
      let resultDict = results.first
      let numDeals = resultDict?["sumDeals"] as? Int ?? 0
      let pluralized = numDeals == 1 ? "deal" : "deals"
      numDealsLabel.text = "\(numDeals) \(pluralized)"
    } catch let error as NSError {
      print("count not fetched \(error), \(error.userInfo)")
    }
  }

}

//MARK: comments populateCheapVenueCountLabel
/*
 Это расширение предоставляет populateCheapVenueCountLabel (), который создает запрос на fetchRequest Venue. Затем вы устанавливаете тип результата на .countResultType и устанавливаете .predicate fetchRequest на cheapVenuePredicate. Обратите внимание, что для того, чтобы это работало правильно, параметр типа fetchRequest должен быть NSNumber, а не Venue. Когда вы устанавливаете тип результата fetchRequest на .countResultType, возвращаемое значение становится массивом Swift, содержащим единственный NSNumber. Целое число внутри NSNumber - это общее количество, которое вы ищете. И снова вы выполняете fetchRequest для свойства NSManagedObjectContext CoreDataStack. Затем вы извлекаете целое число из полученного NSNumber и используете его для заполнения firstPriceCategoryLabel.
 */

//MARK: comments populateDealsCountLabel
/*
 1. Вы начинаете с создания типичного запроса на получение объектов Venue. Затем вы указываете тип результата как .dictionaryResultType.

 2. Вы создаете NSExpressionDescription для запроса суммы и даете ему имя sumDeals, чтобы вы могли прочитать его результат из словаря результатов, который вы получите обратно из запроса выборки.

 3. Вы даете описанию выражения выражение NSExpression, чтобы указать, что вам нужна функция суммы. Затем дайте этому выражению другое выражение NSExpression, чтобы указать, какое свойство вы хотите суммировать - в данном случае specialCount. Наконец, вы должны установить тип возвращаемых данных описания вашего выражения, поэтому вы установите для него значение integer32AttributeType.

 4. Вы указываете исходному запросу на получение суммы, задав для него
 propertiesToFetch к описанию выражения, которое вы только что создали.

 5. Наконец, выполните запрос на выборку в обычном операторе do-catch. Тип результата - это массив NSDictionary, поэтому вы получаете результат своего выражения, используя имя описания выражения (sumDeals)
 */
