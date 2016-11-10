//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Tao Jie on 9/2/16.
//
//

import UIKit

class MealTableViewController: UITableViewController  {
    
    // Mark properties
    
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        }else {
            
            self.loadSampleMeals()
        }
        
    }
    
    func loadSampleMeals() {
        
        let photo1 = UIImage(named: "meal1")
        let meal1 = Meal(name: "Tenpura", photo: photo1, rating: 4)
        
        let photo2 = UIImage(named: "meal2")
        let meal2 = Meal(name: "Yasai", photo: photo2, rating: 5)
        
        let photo3 = UIImage(named: "meal3")
        let meal3 = Meal(name: "Ji dan bing", photo: photo3, rating: 3)
        
        let photo4 = UIImage(named: "meal4")
        let meal4 = Meal(name: "Xiao jiahuo", photo: photo4, rating: 5)
        
        meals += [meal1!, meal2!, meal3!, meal4!]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell
        
        let meal = meals[(indexPath as NSIndexPath).row]
        
        cell?.nameLabel.text = meal.name
        cell?.photoImageView.image = meal.photo
        cell?.ratingControl.rating = meal.rating
        
        return cell!
    }
    
    
    @IBAction func unwindToMealList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update meal
                meals[(selectedIndexPath as NSIndexPath).row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else {
                // add new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .bottom)

            }
            
            //save meals to file
            saveMeals()
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItem" {
            print("Adding New Meal")
            
        }else if segue.identifier == "ShowDetail" {
            
            if let mealDetailViewController = segue.destination as? MealViewController {
                
                if let selectedMealCell = sender as? MealTableViewCell {
                    
                    let indexPath = tableView.indexPath(for: selectedMealCell)
                    let selectedMeal = meals[((indexPath as NSIndexPath?)?.row)!]
                    mealDetailViewController.meal = selectedMeal
                    
                }

            }
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete seleted row
            meals.remove(at: (indexPath as NSIndexPath).row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else {
            //
        }
    }
    
    //Mark NSCoding
    func saveMeals() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL!.path)
        
        if !isSuccessfulSave {
            print("Failed to save the meal data")
        }
        
    }
    
    func loadMeals() -> [Meal]? {
        print("saved file path = " + (Meal.ArchiveURL?.path)!)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL!.path) as? [Meal]
    }

    

}
