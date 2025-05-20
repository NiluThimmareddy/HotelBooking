//
//  SignupViewModel.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import Foundation


class SignupViewModel{
    
    var user : User?
    var isLoading: ((Bool)-> Void)?
    var showError: ((String)-> Void)?
    var didLoadUser: (()-> Void)?
    
    
   
    
    func postUser(){
        let userData = User(id: 0, name: "Nilu", email: "nilu@example.com")
        let body = try? JSONEncoder().encode(userData)
        
        isLoading?(true)
        
        let url = ""
        
        NetworkManager.shared.postRequest(url: url, body: body) { (result: Result<User,Error>) in
            switch result{
            case .success(let user): print("User Posted \(user.id)")
            case .failure(let error): print("Error: \(error.localizedDescription)")
            }
        }
    }
}
