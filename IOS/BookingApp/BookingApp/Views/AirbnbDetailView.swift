//
//  AirbnbDetailView.swift
//  BookingApp
//
//  Created by Abhra Ghosh on 27/12/24.
//

import SwiftUI

struct AirbnbDetailView: View {
    let model: AirbnbListing
    
    var body: some View {
        VStack(alignment: .leading){
            GeometryReader { proxy in
                ScrollView(.vertical){
                    //picture
                    AsyncImage(url: URL(string: model.imageUrl ?? ""))
                        .frame(width: proxy.frame(in: .global).width)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                    
                    // Info
                    Text(model.name ?? "")
                        .bold()
                    let price = model.cost
                    
                    Text("Hourly Rate: \(price.formatted(.currency(code: "USD")))")
                    
                    //                    Text("Cost: \(model.cost ?? "")")
                    Text("Type: \(model.type ?? "")")
                    
                    //Host info
                    
                    HStack{
                        AsyncImage(url: URL(string: model.imageUrl))
                            .frame(width: 75, height: 75)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        Text(model.name)
                            .bold()
                    }.frame(maxWidth: proxy.frame(in: .global).width)
                }
                .navigationTitle(model.name ?? "LISTING")
            }
        }
    }
}

