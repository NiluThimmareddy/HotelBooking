//
//  APIManager.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import Foundation
import Reachability



enum HTTPMethod: String{
    case GET, POST, PUT, DELETE
}

 class NetworkManager {
    // code for fetch data from api using generic
    
    static let shared = NetworkManager()
    private let reachability = try! Reachability()
    
    
    private init(){
        try? reachability.startNotifier()
    }
    
    var isNetworkAvailable : Bool {
        return reachability.connection != .unavailable
        
    }
     
     // MARK: fetch data
     func getRequest<T:Codable>( url:String, headers: [String: String]? = nil, completion: @escaping ( Result<T,Error>) -> Void
     ){
         sendRequest(url: url, method: .GET, headers: headers, body: nil, responseType: T.self, completion: completion)
     }
     
     // MARK: Post data
     func postRequest<T:Codable>(
        url:String, body: Data?, headers: [String:String]? = ["Content-Type" : "application/json"], completion: @escaping (Result<T,Error>)-> Void){
            sendRequest(url: url, method: .POST, headers: headers, body: body, responseType: T.self, completion: completion)
     }
     
     
     //MARK: Update data
     func putRequest<T: Codable>(
             url: String,
             body: Data?,
             headers: [String: String]? = ["Content-Type": "application/json"],
             completion: @escaping (Result<T, Error>) -> Void
         ) {
             sendRequest(url: url, method: .PUT, headers: headers, body: body, responseType: T.self, completion: completion)
         }

     //MARK: Delete data
     func deleteRequest<T: Codable>(
            url: String,
            headers: [String: String]? = nil,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            sendRequest(url: url, method: .DELETE, headers: headers, body: nil, responseType: T.self, completion: completion)
        }
     
     
     
     private func sendRequest<T: Codable>( url: String, method:HTTPMethod, headers: [String:String]?, body: Data?, responseType: T.Type, completion: @escaping (Result<T,Error>) -> Void){
         guard isNetworkAvailable else{
             completion(.failure(NSError(domain:"No Internet Connection", code: -1009)))
             return
         }
         
         
         
         guard let  url = URL(string: url) else{
             completion(.failure(NSError(domain: "Invalid URL", code: 0)))
             return
         }
         
         var request  = URLRequest(url: url)
         request.httpMethod = method.rawValue
         request.httpBody = body
         headers?.forEach{ request.setValue($1, forHTTPHeaderField: $0)
         }
         
         URLSession.shared.dataTask(with: request) { data, _, error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             
             guard let data = data else{
                 completion(.failure(NSError(domain: "No Data", code: 0)))
                 return
             }
             
             do{
                 let decoded = try JSONDecoder().decode(T.self, from: data)
                 completion(.success(decoded))
             }catch{
                 completion(.failure(error))
             }
         }.resume()
     }
     
   
}
