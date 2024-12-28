//
//  AirbnbListingsView.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import Foundation

final class AirbnbListingsViewViewModel: ObservableObject{
    private let service = APIService()
    
    @Published var listings: [AirbnbListing] = []
    
    public func fetchListings() {
        service.getListings{ result in
            switch result {
            case .success(let models):
                self.listings = models
            case.failure(let failure):
                break
            }
            
        }
    }
}
