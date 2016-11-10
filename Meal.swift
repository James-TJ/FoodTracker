//
//  Meal.swift
//  FoodTracker
//
//  Created by Tao Jie on 9/2/16.
//
//

import UIKit

class Meal : NSObject, NSCoding {
    
    //Mark properties
    var name: String
    var photo: UIImage?
    var rating:Int
    
    //Mark Archiving Path
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    static let ArchiveURL = DocumentsDirectory?.appendingPathComponent("meals")
    
    
    
    //Mark Types
    struct ProperKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    
    //Mark initialization
    init?(name: String, photo:UIImage?, rating: Int){
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
        
    }
    
    // Mark NSCodingq
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: ProperKey.nameKey)
        aCoder.encode(photo, forKey: ProperKey.photoKey)
        aCoder.encode(rating, forKey: ProperKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: ProperKey.nameKey) as? String
        let photo = aDecoder.decodeObject(forKey: ProperKey.photoKey) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: ProperKey.ratingKey)
        
        // Must call designated initializer.
        self.init(name: name!, photo: photo, rating: rating)
        
    }
    
}
