//
//  Product+CoreDataProperties.swift
//  A2_FA_iOS_Jaspreet_C0812273
//
//  Created by Jaspreet Kaur on 25/05/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchCoreRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productId: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productProvider: String?

}

extension Product : Identifiable {

}
