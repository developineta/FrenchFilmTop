//
//  FavouriteTableViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import UIKit
import CoreData
import SDWebImage

class FavouriteTableViewController: UITableViewController {

    var savedItems = [FrenchFilms]() // CoreData
    var managedObjectContext: NSManagedObjectContext?
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "Favourite Films Info!", message: "In this section you will find your favourite films. You can check them as as seen by just clicking on the film. If you decide to delete some of them, you can do it by using pencil icon button and click on delete symbol, or alternative way is to pointer on related film and swipe from right side to the left, then press \"delete\"!")
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    func saveData(){
        do{
            try managedObjectContext?.save()
        }catch{
            fatalError("Error in saving in core data item")
        }
        loadData()
    }
    
    func loadData(){
        let request: NSFetchRequest<FrenchFilms> = FrenchFilms.fetchRequest()
        do {
            savedItems = try (managedObjectContext?.fetch(request))!
            tableView.reloadData()
        }catch{
            fatalError("Error in retrieving Saved Items")
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if savedItems.count == 0 {
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "paper-background.png")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else if savedItems.count > 0 {
            self.view.backgroundColor = UIColor.darkGray
        }
        return savedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritesCell", for: indexPath) as? FilmTableViewCell else{
            return UITableViewCell()
        }

        let item = savedItems[indexPath.row] // From CoreData to Cell
        cell.titleLabel.text = item.title
        cell.titleLabel.numberOfLines = 0
        cell.dateForCell.text = "Release date: " + item.date!
        cell.voteLabel.text = item.voteCount
        cell.imageForCell.sd_setImage(with: URL(string: item.image ?? ""), placeholderImage: UIImage(named: "film.jpg"))
        cell.accessoryType = item.completed ? .checkmark : .none
        return cell
    }
    
    // Check mark on the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = savedItems[indexPath.row]
        if item.completed == false {
            item.completed = true
        }else {
            item.completed = false
        }
        saveData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    // Confirmation of delition
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                let item = self.savedItems[indexPath.row]
                self.managedObjectContext?.delete(item)
                self.saveData()
            }))
            self.present(alert, animated: true)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let row = savedItems.remove(at: fromIndexPath.row)
        savedItems.insert(row, at: to.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
}
