//
//  ApiService.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import Foundation

protocol ApiServiceProtocol{
    func fetchTeams(completion: @escaping(Result<TeamsResponse, Error>) -> Void)
    func fetchMatches(completion: @escaping(Result<MatchesResponse, Error>) -> Void)
}

enum Endpoint{
    case getTeams
    case getMatches
    
    func path() -> String{
        switch self {
        case .getTeams:
            return "/teams"
        case .getMatches:
            return "/teams/matches"
        }
    }
    func method() -> String{
        switch self {
        default:
            return "GET"
        }
    }
}

enum ApiError: Error{
    case unidentified
}

final class ApiService: ApiServiceProtocol{
    private var baseURLString: String
    
    init(baseURLString: String){
        self.baseURLString = baseURLString
    }
    func fetchTeams(completion: @escaping(Result<TeamsResponse, Error>) -> Void){
        fetch(completion: completion)
    }
    func fetchMatches(completion: @escaping(Result<MatchesResponse, Error>) -> Void){
        fetch(completion: completion)
    }
}


//Private
extension ApiService{
    private func makeRequest(endpoint: Endpoint) -> URLRequest?{
        guard let url = URL(string: baseURLString + endpoint.path()) else {return nil}
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method()
        return request
    }
    private func fetch<R: ResponseModel>(completion: @escaping(Result<R, Error>) -> Void) {
        guard let request = makeRequest(endpoint: R.endpoint()) else {
            completion(Result.failure(ApiError.unidentified))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, responseHeader, error in
            guard let data = data else {
                completion(Result.failure(ApiError.unidentified))
                return
            }
            do{
                let responseModel = try JSONDecoder().decode(R.self, from: data)
                completion(Result.success(responseModel))
            }catch{
                completion(Result.failure(ApiError.unidentified))
            }
        }
        task.resume()
    }
}
