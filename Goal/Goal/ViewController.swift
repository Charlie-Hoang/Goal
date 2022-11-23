//
//  ViewController.swift
//  Goal
//
//  Created by Charlie Hoang on 11/23/22.
//

import UIKit

class ViewController: UIViewController {
    private var apiService: ApiServiceProtocol!
    private var arrData: [TeamsResponse.Team] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServices()
        fetchData()
    }

    func fetchData(){
        apiService.fetchMatches { [weak self] result in
            switch result{
            case .success(let res):
                
                print(res)
            case .failure(_):
                print("error")
            }
            
            print(result)
        }
    }
}

//Private
extension ViewController{
    private func setupServices(){
        apiService = ApiService(baseURLString: "https://jmde6xvjr4.execute-api.us-east-1.amazonaws.com")
    }
}
