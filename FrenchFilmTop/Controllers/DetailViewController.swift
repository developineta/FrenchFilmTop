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
    var titleString = String()
    var voteDouble = Double()
    var dateString = String()
    var descriptionString = String()
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailVotes: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.text = titleString
        detailVotes.text = String(voteDouble)
        detailDate.text = "Release date: \(dateString)"
        detailOverview.text = descriptionString
        detailImage.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "film.jpg"))

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
            basicAlert(title: savedTitle, message: savedMessage)
        }catch{
            fatalError("Error in saving in core data item")
        }
    }
    
    let savedTitle: String! = "Film added to Favourites"
    let savedMessage = "Go to heart icon to see your favourite film list"
    
    @IBAction func favouritesButtonTapped(_ sender: Any) {
        let filmItem = FrenchFilms(context: self.managedObjectContext!)
        filmItem.title = titleString
        filmItem.image = imageString
        filmItem.voteCount = String(voteDouble)
        filmItem.overview = descriptionString
        filmItem.date = dateString
        
        if !imageString.isEmpty{
            filmItem.image = imageString
        }
        
        self.savedItems.append(filmItem)
        saveData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
