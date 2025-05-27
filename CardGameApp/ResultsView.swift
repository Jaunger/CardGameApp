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
        VStack(spacing: 24) {
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
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
