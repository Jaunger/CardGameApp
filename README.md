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

> 🧩 Insert your screenshots here

| Portrait | Landscape |
|----------|-----------|
| ![Portrait Screenshot](screenshots/portrait.png) | ![Landscape Screenshot](screenshots/landscape.png) |

---

## 🎥 Demo Video

> 📹 Drop a screen recording of gameplay here

[![Watch the demo](https://img.youtube.com/vi/your-video-id-here/0.jpg)](https://www.youtube.com/watch?v=your-video-id-here)

---

## 🧪 How to Run

1. Open the project in Xcode.
2. Build and run on a real device or simulator (location may not behave the same in Simulator).
3. Make sure `flip.mp3`, `win.mp3`, and `bgm.mp3` are in your asset catalog.

---

## 📦 App Icon

<div align="center">
  <img src="Assets/AppIcon.png" width="120" alt="App Icon"/>
</div>

---

## 📍 Notes

- For real device testing, ensure location permissions are granted under iOS Settings.
- On first launch, location might take a few seconds longer to resolve.
- Card deck is preloaded at launch to reduce delay on first round.

---

## 🧑‍💻 Author

- Daniel Raby (Student Developer)
