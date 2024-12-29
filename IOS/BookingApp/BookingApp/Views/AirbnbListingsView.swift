//
//  AirbnbListingsView.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import SwiftUI

struct AirbnbListingsView: View {
    @StateObject var viewModel = AirbnbListingsViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.listings.isEmpty{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }   else{
                        List(viewModel.listings){ listing in
                            NavigationLink(destination: AirbnbDetailView(model: listing), label: {
                                AirbnbListingCardView(model: listing)
                            })
                            
                        }
                    
                }
            }
            .navigationTitle("Our Services")
        }
        .onAppear{
            viewModel.fetchListings()
        }
    }
}
