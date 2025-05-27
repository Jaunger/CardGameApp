import SwiftUI

struct GameView: View {
    let side: String
    @ObservedObject private var manager = GameManager.shared
    @State private var showResults = false
    @Environment(\.scenePhase) private var scenePhase
    @Binding var path: [String]

    var body: some View {
        VStack {
            // Top row
            HStack {
                if side == "West Side" {
                    playerScoreBlock
                    Spacer()
                    timerBlock
                    Spacer()
                    computerScoreBlock
                } else {
                    computerScoreBlock
                    Spacer()
                    timerBlock
                    Spacer()
                    playerScoreBlock
                }
            }
            .padding(.horizontal)

            Spacer()

            HStack {
                if side == "West Side" {
                    CardView(cardName: manager.isShowingCards ? manager.playerCard : manager.currentBackImage)
                    Spacer()
                    CardView(cardName: manager.isShowingCards ? manager.computerCard : manager.currentBackImage)
                } else {
                    CardView(cardName: manager.isShowingCards ? manager.computerCard : manager.currentBackImage)
                    Spacer()
                    CardView(cardName: manager.isShowingCards ? manager.playerCard : manager.currentBackImage)
                }
            }
            .padding(.horizontal, 32)

            Spacer()
        }
        .onAppear {
            if manager.round == 0 {
                manager.reset()
                manager.startCountdown()
                manager.onGameFinished = {
                    self.showResults = true
                }
            }
        }
        .onDisappear {
            manager.stop()
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                manager.resumeCountdown()
            case .inactive, .background:
                manager.pauseCountdown()
            @unknown default:
                break
            }
        }
        .navigationDestination(isPresented: $showResults) {
            ResultsView(
                playerName: manager.playerName,
                playerScore: manager.playerScore,
                computerScore: manager.computerScore,
                path: $path
            )
        }
        .navigationBarBackButtonHidden(true)
    }

    var playerScoreBlock: some View {
        VStack {
            Text(manager.playerName)
                .font(.caption)
            Text("\(manager.playerScore)")
                .font(.title)
                .bold()
        }
    }

    var computerScoreBlock: some View {
        VStack {
            Text("PC")
                .font(.caption)
            Text("\(manager.computerScore)")
                .font(.title)
                .bold()
        }
    }

    var timerBlock: some View {
        VStack {
            Image(systemName: "timer")
                .font(.title2)
                .padding(.top, 20.0)
            Text("\(manager.countdown)")
                .font(.title)
                .bold()
            Text("Round \(manager.round + 1)/10")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct CardView: View {
    let cardName: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorScheme == .dark ? Color(white: 0.1) : .white)
                .shadow(radius: 4)

            Image(cardName)
                .resizable()
                .scaledToFit()
                .padding(8)
        }
        .frame(width: 140, height: 200)
    }
}
