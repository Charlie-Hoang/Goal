//
//  TeamsVC.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit

class TeamsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiService: ApiServiceProtocol!
    private var arrData: [TeamsResponse.Team] = []
    
    static func instantiate(apiService: ApiServiceProtocol) -> TeamsVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamsVC") as! TeamsVC
        vc.apiService = apiService
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    func fetchData(){
        apiService.fetchTeams { [weak self] result in
            switch result{
            case .success(let res):
                if let _team = res.teams{
                    self?.arrData = _team
                }
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(_):
                print("error")
            }
            
            print(result)
        }
    }
}
//CollectionView
extension TeamsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
        cell.setupCell(model: arrData[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TeamDetailVC.instantiate(apiService: apiService, team: arrData[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension TeamsVC: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
//    }

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
