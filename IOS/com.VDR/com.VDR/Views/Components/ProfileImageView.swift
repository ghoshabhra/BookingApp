import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: 100, height: 100)
            .overlay(
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(25)
                    .foregroundColor(.gray)
            )
    }
} 