//
//  TeamDetailVM.swift
//  Goal
//
//  Created by Charlie Hoang on 11/24/22.
//

import Foundation

class TeamDetailVM{
    var team: TeamsResponse.Team!
    var apiService: ApiServiceProtocol!
    var arrDataPrevious: [MatchesResponse.Matches.Match] = []
    var arrDataUpComing: [MatchesResponse.Matches.Match] = []
    
    var callback_fetchMatches: RESPONSE_EMPTY?
    
    init(team: TeamsResponse.Team, apiService: ApiServiceProtocol) {
        self.team = team
        self.apiService = apiService
    }
    func fetchData(){
        apiService.fetchMatches {[weak self] result in
            switch result{
            case .success(let res):
                if let _previous = res.matches?.previous{
                    self?.arrDataPrevious = _previous.filter{$0.home == self?.team.name || $0.away == self?.team.name}
                }
                if let _upcoming = res.matches?.upcoming{
                    self?.arrDataUpComing = _upcoming.filter{$0.home == self?.team.name || $0.away == self?.team.name}
                }
                self?.callback_fetchMatches?()
            case .failure(_):
                print("error")
                self?.callback_fetchMatches?()
            }
        }
    }
}
