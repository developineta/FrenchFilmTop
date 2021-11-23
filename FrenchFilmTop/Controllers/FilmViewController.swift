//
//  FilmTopViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import SDWebImage
import UIKit

class FilmViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    var filmItems: [FilmItem] = []
    
    var searchResult = "popular"
    var apiKey = "fb24ef70820fbc0c04c81f1ae3541056"
    var posterPath = "https://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleGetData()
    }
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "French Film Top Info", message: "Press share button to share your favourite film")
    }
    
    func activityIndicator(animated: Bool){
        DispatchQueue.main.async {
            if animated{
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    func handleGetData(){
        activityIndicator(animated: true)
        let jsonUrl = "https://api.themoviedb.org/3/movie/\(searchResult)?api_key=\(apiKey)&language=en-FR&page=1"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        //url session
        URLSession(configuration: config).dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print((error?.localizedDescription)!)
                self.basicAlert(title: "Error!", message: "\(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let data = data else {
                self.basicAlert(title: "Error!", message: "Something weng wrong, no data.")
                return
            }
            
            do{
                let jsonData = try JSONDecoder().decode(Films.self, from: data) // From Model/ Film
                self.filmItems = jsonData.results
                DispatchQueue.main.async {
                    print("self.filmItems:", self.filmItems)
                    self.tableViewOutlet.reloadData()
                    self.activityIndicator(animated: false)
                }
            }catch{
                print("Err:", error)
            }
        }.resume()
    }
}
extension FilmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as? FilmTableViewCell else {return UITableViewCell()}
        
        let item = filmItems[indexPath.row]
        cell.titleLabel.text = item.title
        cell.titleLabel.numberOfLines = 0
        cell.voteLabel.text = String(item.vote_average)
        cell.imageForCell.sd_setImage(with:URL(string: posterPath + item.poster_path), placeholderImage: UIImage(named: "film.jpg"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storybord.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        let item = filmItems[indexPath.row]
        
        // DetailViewController names get values from Model/ Film
        vc.titleString = item.title
        vc.imageString = "\(posterPath)\(item.poster_path)"
        vc.voteDouble = item.vote_average
        vc.dateString = item.release_date
        vc.descriptionString = item.overview
        
        //        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
