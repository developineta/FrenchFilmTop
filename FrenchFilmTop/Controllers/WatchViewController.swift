//
//  WatchViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 25/11/2021.
//

import UIKit

class WatchViewController: UIViewController {
    
    var netflixUrl = String()
    var amazonUrl = String()
    var itunesUrl = String ()
    var huluUrl = String()
    
    @IBOutlet weak var netflixOutlet: UIButton!
    @IBOutlet weak var amazonOutlet: UIButton!
    @IBOutlet weak var iTunesOutlet: UIButton!
    @IBOutlet weak var huluOutlet: UIButton!
    
override func viewDidLoad() {
        super.viewDidLoad()
    
    netflixOutlet.addTarget(self, action: #selector(netflixTapped), for: .touchUpInside)
    amazonOutlet.addTarget(self, action: #selector(amazonTapped), for: .touchUpInside)
    iTunesOutlet.addTarget(self, action: #selector(iTunesTapped), for: .touchUpInside)
    huluOutlet.addTarget(self, action: #selector(huluTapped), for: .touchUpInside)
}
    
    @IBAction func netflixTapped(_ sender: Any) {
        netflixUrl = "https://www.netflix.com/"
        if let url = URL(string: netflixUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func amazonTapped(_ sender: Any) {
        amazonUrl = "https://www.primevideo.com/?ref_=dvm_pds_amz_LV_lb_s_g_mkw_sAwdNPFhk-dc_pcrid_507092814405&mrntrk=slid__pgrid_123397649190_pgeo_9062307_x__ptid_kwd-312570258840"
        if let url = URL(string: amazonUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @IBAction func iTunesTapped(_ sender: Any) {
        itunesUrl = "https://itunes.apple.com/us/genre/movies/id33"
        if let url = URL(string: itunesUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @IBAction func huluTapped(_ sender: Any) {
        huluUrl = "https://usa-ip-address.com/hulu/france/?gclid=Cj0KCQiAhf2MBhDNARIsAKXU5GQ1qIghhL1ua5hnanDXxTbE3u3-yLfH6nH6xdsAyvDGE9fYluqsoDEaAkYfEALw_wcB"
        if let url = URL(string: huluUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: WebViewController = segue.destination as! WebViewController
        vc.netflix = netflixUrl
        vc.amazon = amazonUrl
        vc.itunes = itunesUrl
        vc.hulu = huluUrl
        self.present(vc, animated: true, completion: nil)
    }
}
