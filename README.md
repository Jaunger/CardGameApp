# 🌍 Card VS Game

A SwiftUI-based iOS game where the player competes against the PC using a deck of cards. The game uses the player's physical location to determine their side (West or East) and features a minimalist UI with automated card flipping, scoring, and round tracking.

---

## 📱 Features

- 🔁 Automatically plays 10 rounds with card flipping every 5 seconds
- 📍 Uses CoreLocation to detect player's side (West or East) based on latitude
- 🎴 Dynamically drawn card assets with light/dark mode support
- 🔊 Sound effects (flip, win, background music)
- 🧠 Simple scoring system based on card strength
- 🎨 Adaptive layout for portrait and landscape orientations
- 🧭 Start button disabled until location and name are valid
- 💾 Name persistence with `UserDefaults`

---

## 🎮 How to Play

1. Enter your name.
2. Allow location access — your side (West or East) is assigned automatically.
3. Press **START**.
4. Every 5 seconds, two cards are flipped and compared:
   - Higher strength wins a point.
   - In case of a tie, both get a point.
5. After 10 rounds, the winner is declared.
6. In the case of a final tie, "The House" wins.

---

## 🧩 Architecture

| File | Description |
|------|-------------|
| `ContentView.swift` | Entry screen: handles name input, location check, and side selection |
| `GameView.swift` | Core gameplay logic and UI. Manages timer, card display, and round progression |
| `GameManager.swift` | Centralized logic controller (Singleton) for state, timer, scoring, and sound triggers |
| `ResultsView.swift` | Final screen displaying the winner and scores |
| `SoundManager.swift` | Plays background music and sound effects using `AVAudioPlayer` |
| `LocationManager.swift` | Handles one-time location fetching and authorization |
| `CardGameAppApp.swift` | Main app entry point |

---

## 💡 Technologies

- Swift 5
- SwiftUI
- CoreLocation
- AVFoundation (for sound)
- Dark Mode compatible assets
- Responsive layout using `GeometryReader`

---
## 🖼️ Screenshots

| Portrait | Landscape |
|----------|-----------|
| <img src="https://github.com/user-attachments/assets/e83ae827-faed-44c9-a880-2fc32d42e9a8" width="200"/> | <img src="https://github.com/user-attachments/assets/9744051b-23b1-4889-9296-ccffd286a32d" width="300"/> |
| <img src="https://github.com/user-attachments/assets/7d0abca1-0880-429a-b46f-b1961a1cc5a4" width="200"/> | <img src="https://github.com/user-attachments/assets/7976f258-8601-488d-9acc-5b22a0495b35" width="300"/> |
| <img src="https://github.com/user-attachments/assets/8e6245c1-3a8d-4e21-a7c9-94b8f0ca226f" width="200"/> |  <img src="https://github.com/user-attachments/assets/e81a2325-147f-4e10-b5ee-53d0e609434a" width="300"/> |

---

## 🎥 Demo Video

<p align="center">
  <img src="https://github.com/user-attachments/assets/0dfe49ac-6d95-4ac5-a81f-d5dd55189e3b" width="600" alt="Watch the demo"/>
</p>




---

## 🧪 How to Run

1. Open the project in Xcode.
2. Build and run on a real device or simulator (location may not behave the same in Simulator).
3. Make sure `flip.mp3`, `win.mp3`, and `bgm.mp3` are in your asset catalog.

---

## 📦 App Icon

<div align="center">
  <img src="https://github.com/user-attachments/assets/a765abe3-3f77-4a89-ba86-1ef5c380c78b" width="120" alt="App Icon"/>
</div>

---

## 📍 Notes

- For real device testing, ensure location permissions are granted under iOS Settings.
- On first launch, location might take a few seconds longer to resolve.
- Card deck is preloaded at launch to reduce delay on first round.

---

## 🧑‍💻 Author

- Daniel Raby (Student Developer)
