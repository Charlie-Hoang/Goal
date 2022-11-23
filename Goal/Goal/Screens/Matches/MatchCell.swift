//
//  MatchCell.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit

protocol MatchCellDelegate: AnyObject{
    func playBtnClicked(urlString: String)
}

class MatchCell: UITableViewCell {
    @IBOutlet weak var highlightBtn: UIButton!
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    weak var delegate: MatchCellDelegate?
    private var model: MatchesResponse.Matches.Match?
    
    func setupCell(model: MatchesResponse.Matches.Match){
        self.model = model
        label0.text = model.home
        label1.text = model.away
        label2.text = model.date?.gToDate()?.gToDateString()
        label3.text = model.date?.gToDate()?.gToTimeString()
        highlightBtn.isHidden = model.highlights == nil
        label0.textColor = .white
        label1.textColor = .white
        if let _winner = model.winner{
            if _winner == label0.text{
                label0.textColor = .green
                label1.textColor = .red
            }
            if _winner == label1.text{
                label0.textColor = .red
                label1.textColor = .green
            }
        }
    }
    
    @IBAction func play(_ sender: Any) {
        if let _highlight = model?.highlights{
            delegate?.playBtnClicked(urlString: _highlight)
        }
    }
}
