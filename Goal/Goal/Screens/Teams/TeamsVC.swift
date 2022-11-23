//
//  TeamsVC.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit

class TeamsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: TeamsVM!
    
    static func instantiate(viewModel: TeamsVM) -> TeamsVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamsVC") as! TeamsVC
        vc.viewModel = viewModel
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
}
//CollectionView
extension TeamsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
        cell.setupCell(model: viewModel.arrData[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = TeamDetailVM(team: viewModel.arrData[indexPath.row], apiService: viewModel.apiService)
        let vc = TeamDetailVC.instantiate(viewModel: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension TeamsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width - 8 * 4
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
//MARK: - Private -
extension TeamsVC{
    private func setupViewModel(){
        viewModel.callback_fetchTeams = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.fetchData()
    }
}
