//
//  DetailViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import SDWebImage
import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var savedItems = [FrenchFilms]() // CoreData
    var managedObjectContext: NSManagedObjectContext?
    
    var imageString = String()
    var posterString = String()
    var titleString = String()
    var voteDouble = Double()
    var dateString = String()
    var descriptionString = String()
    var checkCompleted = Bool()
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailVotes: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTitle.text = titleString
        detailVotes.text = String(voteDouble)
        detailDate.text = "Release date: \(dateString)"
        detailOverview.text = descriptionString
        detailImage.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "film.jpg"))
        
        self.checkCompleted = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func loadData(){
        let request: NSFetchRequest<FrenchFilms> = FrenchFilms.fetchRequest()
        do{
            let result = try managedObjectContext?.fetch(request)
            savedItems = result!
        }catch{
            fatalError("Error in loading core data item")
        }
    }
    
    func saveData(){
        do{
            try managedObjectContext?.save()
        }catch{
            fatalError("Error in saving in core data item")
        }
    }
    
    let savedTitle: String! = "Film added to Favourites"
    let savedMessage = "Go to heart icon to see your favourite film list"
    
    @IBAction func favouritesButtonTapped(_ sender: Any) {
        
        switch addButton.titleLabel?.text{
        case "Add to Favourites":
            addButton.setTitle("Is Added", for: .normal)
            let filmItem = FrenchFilms(context: self.managedObjectContext!)
            filmItem.title = titleString
            filmItem.image = posterString
            filmItem.voteCount = String(voteDouble)
            filmItem.overview = descriptionString
            filmItem.date = dateString
            filmItem.completed = checkCompleted
            
            if !imageString.isEmpty{
                filmItem.image = posterString
            }
            self.savedItems.append(filmItem)
            self.checkCompleted = false
            
            basicAlert(title: savedTitle, message: savedMessage)
            
        case  "Is Added to Favourites":
            basicAlert(title: "Favourites Message", message: "Film is already added to Your Favourites")
            
        default:
            addButton.setTitle("Is Added", for: .normal)
                }
        saveData()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        shareData([titleString])
    }
    
    func shareData(_ dataToShare: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: [titleString], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

