//
//  APIService.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import Foundation

final class APIService{
    init() {}
    
    struct Constants {
        static let apiUrl = URL(string:"http://localhost:8080/admin/offerings")
    }
    
    public func getListings(completion: @escaping (Result<[AirbnbListing], Error>) -> Void){
        guard let url = Constants.apiUrl else{
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data, error == nil else{
                if let error{
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AirbnbListingResponse.self, from: data)
                completion(.success(response.results))
            } catch{
//                let json = try? JSONSerialization.jsonObject(with: data)
//                print(String(describing: json))
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
