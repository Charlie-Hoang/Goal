//
//  TeamDetailVC.swift
//  Goal
//
//  Created by Charlie Hoang on 11/24/22.
//

import UIKit
import AVFoundation
import AVKit

class TeamDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logo: UIImageView!
    
    var team: TeamsResponse.Team!
    var apiService: ApiServiceProtocol!
    private var arrDataPrevious: [MatchesResponse.Matches.Match] = []
    private var arrDataUpComing: [MatchesResponse.Matches.Match] = []
    
    static func instantiate(apiService: ApiServiceProtocol, team: TeamsResponse.Team) -> TeamDetailVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailVC") as! TeamDetailVC
        vc.apiService = apiService
        vc.team = team
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = team.name
        if let _logo = team.logo, let _url = URL(string: _logo){
            logo.load(url: _url)
        }
        fetchData()
    }
    func fetchData(){
        apiService.fetchMatches { [weak self] result in
            switch result{
            case .success(let res):
                if let _previous = res.matches?.previous{
                    self?.arrDataPrevious = _previous.filter{$0.home == self?.team.name || $0.away == self?.team.name}
                }
                if let _upcoming = res.matches?.upcoming{
                    self?.arrDataUpComing = _upcoming.filter{$0.home == self?.team.name || $0.away == self?.team.name}
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
extension TeamDetailVC: UITableViewDelegate, UITableViewDataSource{
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
extension TeamDetailVC: MatchCellDelegate{
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
