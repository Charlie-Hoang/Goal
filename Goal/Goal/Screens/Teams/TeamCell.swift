//
//  TeamCell.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setupCell(model: TeamsResponse.Team){
        if let _logo = model.logo, let _url = URL(string: _logo){
            logo.load(url: _url)
        }
        label.text = model.name?.replacingOccurrences(of: "Team", with: "")
    }
}
