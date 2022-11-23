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
    
    var viewModel: MatchesVM!
    
    static func instantiate(viewModel: MatchesVM) -> MatchesVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
        vc.viewModel = viewModel
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        
        
    }

}
//TableView
extension MatchesVC: UITableViewDelegate, UITableViewDataSource{
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

//MARK: - Private -
extension MatchesVC{
    private func setupViewModel(){
        tableView.isHidden = true
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        self.view.addSubview(indicator)
        indicator.center = self.view.convert(self.view.center, from:self.view.superview)
        
        viewModel.callback_fetchMatches = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                indicator.removeFromSuperview()
                self?.tableView.isHidden = false
            }
        }
        viewModel.fetchData()
    }
}
