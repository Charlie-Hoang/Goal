//
//  MatchesVM.swift
//  Goal
//
//  Created by Charlie Hoang on 11/24/22.
//

import Foundation

class MatchesVM{
    
    var apiService: ApiServiceProtocol!
    var arrDataPrevious: [MatchesResponse.Matches.Match] = []
    var arrDataUpComing: [MatchesResponse.Matches.Match] = []
    
    var callback_fetchMatches: RESPONSE_EMPTY?
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
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
                self?.callback_fetchMatches?()
            case .failure(_):
                print("error")
                self?.callback_fetchMatches?()
            }
        }
    }
}
