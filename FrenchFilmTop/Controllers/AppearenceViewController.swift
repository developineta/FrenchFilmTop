//
//  AppearenceViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 24/11/2021.
//

import UIKit

class AppearenceViewController: UIViewController {
    
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openSettingsButton(_ sender: Any) {
        openSettings()
    }
    
    func setLabelText(){
        var text = "Unable to specify UI style"
        if self.traitCollection.userInterfaceStyle == .dark {
            text = "Dark Mode is On.\nGo to settings if you would like\nto change to Light Mode"
        }else{
            text = "Light Mode is On.\nGo to settings if you would like\nto change to Dark Mode"
        }
        textLabel.text = text
    }
    
    func openSettings(){
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
        
        if UIApplication.shared.canOpenURL(settingsURL){
            UIApplication.shared.open(settingsURL, options: [:]) { success in
                print("open: ", success)
            }
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

}

extension AppearenceViewController{
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setLabelText()
    }
}
