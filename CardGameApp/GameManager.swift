import Foundation
import SwiftUI
import AVFoundation

class GameManager: ObservableObject {
    static let shared = GameManager()
    @Published var playerScore = 0
    @Published var computerScore = 0
    @Published var round = 0
    @Published var countdown = 5
    @Published var playerCard = ""
    @Published var computerCard = ""
    @Published var isShowingCards = false

    var onGameFinished: (() -> Void)?

    let playerName: String
    let allCards = CardGenerator.generateDeck()
    let cardStrength = CardGenerator.cardStrengths()

    private var timer: Timer?

    private init() {
        self.playerName = UserDefaults.standard.string(forKey: "playerName") ?? "You"
    }

    func reset() {
        stop()
        playerScore = 0
        computerScore = 0
        round = 0
        countdown = 5
        isShowingCards = false
        playerCard = ""
        computerCard = ""
        SoundManager.shared.playBGM(named: "bgm", volume: 0.05)
    }

    func startCountdown() {
        guard timer == nil, round < 10 else { return }

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if self.countdown > 1 {
                self.countdown -= 1
            } else {
                t.invalidate()
                self.timer = nil
                self.flipCards()
            }
        }
    }

    func flipCards() {
        isShowingCards = true
        countdown = 0

        playerCard = allCards.randomElement() ?? "back_light"
        computerCard = allCards.randomElement() ?? "back_light"

        SoundManager.shared.playSFX(named: "flip", volume: 1)
    
        let pVal = cardStrength[playerCard] ?? 0
        let cVal = cardStrength[computerCard] ?? 0

        if pVal > cVal {
            playerScore += 1
        } else if cVal > pVal {
            computerScore += 1
        } else {
            playerScore += 1
            computerScore += 1
        }

        if round >= 9 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isShowingCards = false
                if (self.playerScore > self.computerScore){
                    SoundManager.shared.playSFX(named: "win") // 🔊 Play win sound
                }
                SoundManager.shared.stopBGM() // 🛑 Stop BGM
                self.onGameFinished?()
            }
        } else {
            round += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isShowingCards = false
                self.countdown = 5
                self.startCountdown()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func pauseCountdown() {
        stop()
        SoundManager.shared.stopBGM()
    }

    func resumeCountdown() {
        if !isShowingCards && countdown > 0 {
            startCountdown()
            SoundManager.shared.playBGM(named: "bgm", volume: 0.05)
        }
    }

    var currentBackImage: String {
        UITraitCollection.current.userInterfaceStyle == .dark ? "back_dark" : "back_light"
    }
}
struct CardGenerator {
    static func generateDeck() -> [String] {
        let suits = ["clubs", "diamonds", "hearts", "spades"]
        let ranks = (2...10).map { String($0) } + ["J", "Q", "K", "A"]

        var deck = [String]()
        for suit in suits {
            for rank in ranks {
                deck.append("\(suit)_\(rank)")
            }
        }
        return deck
    }

    static func cardStrengths() -> [String: Int] {
        var strengths: [String: Int] = [:]
        let rankValues: [String: Int] = [
            "2": 2, "3": 3, "4": 4, "5": 5,
            "6": 6, "7": 7, "8": 8, "9": 9,
            "10": 10, "J": 11, "Q": 12, "K": 13, "A": 14
        ]
        let suits = ["clubs", "diamonds", "hearts", "spades"]

        for suit in suits {
            for (rank, value) in rankValues {
                strengths["\(suit)_\(rank)"] = value
            }
        }

        return strengths
    }
}
