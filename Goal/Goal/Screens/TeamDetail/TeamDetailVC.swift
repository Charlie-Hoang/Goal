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
    
    var viewModel: TeamDetailVM!
    
    static func instantiate(viewModel: TeamDetailVM) -> TeamDetailVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailVC") as! TeamDetailVC
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        self.title = viewModel.team.name
        if let _logo = viewModel.team.logo, let _url = URL(string: _logo){
            logo.load(url: _url)
        }
    }

}
//TableView
extension TeamDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.arrDataPrevious.count : viewModel.arrDataUpComing.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Previuos" : "Up Coming"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
        cell.setupCell(model: indexPath.section == 0 ? viewModel.arrDataPrevious[indexPath.row] : viewModel.arrDataUpComing[indexPath.row])
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
//MARK: - Private -
extension TeamDetailVC{
    private func setupViewModel(){
        viewModel.callback_fetchMatches = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
    }
}
