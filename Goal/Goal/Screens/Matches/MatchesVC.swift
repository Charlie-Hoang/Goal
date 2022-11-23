//
//  ViewController.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit
import AVFoundation
import AVKit

class MatchesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var apiService: ApiServiceProtocol!
    private var arrDataPrevious: [MatchesResponse.Matches.Match] = []
    private var arrDataUpComing: [MatchesResponse.Matches.Match] = []
    
    static func instantiate(apiService: ApiServiceProtocol) -> MatchesVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
        vc.apiService = apiService
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    func fetchData(){
        apiService.fetchMatches { [weak self] result in
            switch result{
            case .success(let res):
                if let _previous = res.matches?.previous{
                    self?.arrDataPrevious = _previous
                }
                if let _upcoming = res.matches?.upcoming{
                    self?.arrDataUpComing = _upcoming
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
            print(result)
        }
    }
}
//TableView
extension MatchesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? arrDataPrevious.count : arrDataUpComing.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Previuos" : "Up Coming"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
        cell.setupCell(model: indexPath.section == 0 ? arrDataPrevious[indexPath.row] : arrDataUpComing[indexPath.row])
        cell.delegate = self
        return cell
    }
}
//Cell Delegate
extension MatchesVC: MatchCellDelegate{
    func playBtnClicked(urlString: String) {
        if let _url = URL(string: urlString){
            let asset = AVAsset(url: _url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            
            let controller = AVPlayerViewController()
            controller.player = player //AVPlayer object
            self.present(controller, animated: true) {
               DispatchQueue.main.async {
                 player.play()
               }
            }
        }
    }
}
