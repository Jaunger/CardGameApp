import SwiftUI

struct ResultsView: View {
    let playerName: String
    let playerScore: Int
    let computerScore: Int
    @Binding var path: [String]
    @Environment(\.dismiss) private var dismiss

    var winner: String {
        if playerScore > computerScore {
            return playerName
        } else if computerScore > playerScore {
            return "PC"
        } else {
            return "The House"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let isPortrait = geometry.size.height > geometry.size.width
            let horizontalPadding: CGFloat = isPortrait ? 24 : 64
            let verticalSpacing: CGFloat = isPortrait ? 24 : 16

            VStack(spacing: verticalSpacing) {
                Text("🏆 Winner: \(winner)")
                    .font(.largeTitle)
                    .bold()

                Text("\(playerName): \(playerScore)")
                Text("PC: \(computerScore)")

                Spacer()

                Button("Back to Main Menu") {
                    path = []
                }
                .padding()
                .frame(width: 200)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, isPortrait ? 48 : 24)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarBackButtonHidden(true)
    }
}
