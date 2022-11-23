//
//  TeamsVM.swift
//  Goal
//
//  Created by Charlie Hoang on 11/24/22.
//

import Foundation

class TeamsVM{
    var apiService: ApiServiceProtocol!
    var arrData: [TeamsResponse.Team] = []
    
    var callback_fetchTeams: RESPONSE_EMPTY?
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    func fetchData(){
        apiService.fetchTeams { [weak self] result in
            switch result{
            case .success(let res):
                if let _team = res.teams{
                    self?.arrData = _team
                }
                self?.callback_fetchTeams?()
            case .failure(_):
                print("error")
                self?.callback_fetchTeams?()
            }
        }
    }
}
