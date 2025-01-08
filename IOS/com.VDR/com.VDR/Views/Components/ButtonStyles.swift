import SwiftUI


struct CustomColoredButtonStyle: ButtonStyle {
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .contentShape(RoundedRectangle(cornerRadius: 25))
    }
} 