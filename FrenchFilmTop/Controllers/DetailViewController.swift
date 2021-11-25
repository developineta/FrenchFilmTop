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
            basicAlert(title: savedTitle, message: savedMessage)
        }catch{
            fatalError("Error in saving in core data item")
        }
    }
    
    let savedTitle: String! = "Film added to Favourites"
    let savedMessage = "Go to heart icon to see your favourite film list"
    
    @IBAction func favouritesButtonTapped(_ sender: Any) {
        self.checkCompleted = false
        let filmItem = FrenchFilms(context: self.managedObjectContext!)
        filmItem.title = titleString
        filmItem.image = posterString
        filmItem.voteCount = String(voteDouble)
        filmItem.overview = descriptionString
        filmItem.date = dateString
        filmItem.completed = checkCompleted
        print("Bool false expected", filmItem.completed)
        
        if !imageString.isEmpty{
            filmItem.image = posterString
        }
        print("Poster string", posterString)
        self.savedItems.append(filmItem)
        saveData()
    }
    
//    switch findButton.titleLabel?.text{
//    case "FIND":
//        findButton.setTitle("CLEAR", for: .normal)
//        //31 February
//        if day >= 1 && day <= 31 && month >= 1 && month <= 12{
//            let weekday = dateFormatter.string(from: date)
//            resultLabel.text = weekday.capitalized
//        }else{
//            warningAlert(withTitle: "Error!", withMessage: "Wrong Date, please enter the correct Date!")
//        }
//    default:
//        findButton.setTitle("FIND", for: .normal)
//        //clear
//        clearTextFields()
//    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        shareData([titleString])
    }
    
    func shareData(_ dataToShare: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: [titleString], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

