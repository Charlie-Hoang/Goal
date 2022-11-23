//
//  ResponseModels.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import Foundation
protocol ResponseModel: Decodable{
    static func endpoint() -> Endpoint
}
struct MatchesResponse: ResponseModel{
    
    struct Matches: Decodable{
        
        struct PreviousMatch: Decodable{
            var date: String?
            var description: String?
            var home: String?
            var away: String?
            var winner: String?
            var highlights: String?
        }
        struct UpComingMatch: Decodable{
            var date: String?
            var description: String?
            var home: String?
            var away: String?
        }
        
        var previous: [PreviousMatch]?
        var upcoming: [UpComingMatch]?
    }
    
    var matches: Matches?
    static func endpoint() -> Endpoint{
        return .getMatches
    }
}

struct TeamsResponse: ResponseModel{
    
    struct Team: Decodable{
        var id: String?
        var name: String?
        var logo: String?
    }
    
    var teams: [Team]?
    static func endpoint() -> Endpoint{
        return .getTeams
    }
}
