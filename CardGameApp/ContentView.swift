import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var nameInput: String = ""
    @State private var storedName: String = ""
    @State private var editingName = false
    @State private var side: String = ""
    @State private var locationError: String?
    @State private var path: [String] = []
    @State private var isLoadingLocation: Bool = true
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
                let isPortrait = geometry.size.height > geometry.size.width

                Group {
                    if isPortrait {
                        VStack(spacing: 24) {
                            nameSection
                            globeRow
                            Spacer()
                            startButton
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        HStack(spacing: 0) {
                            VStack {
                                Spacer()
                                sideBox(
                                    imageName: colorScheme == .dark ? "globe_dark_left" : "globe_light_left",
                                    label: "West Side",
                                    isActive: side == "West Side"
                                )
                                Spacer()
                            }
                            .frame(width: 140)
                            .padding(.leading, 16)

                            VStack(spacing: 24) {
                                nameSection
                                Spacer()
                                startButton
                            }
                            .frame(maxWidth: .infinity)

                            VStack {
                                Spacer()
                                sideBox(
                                    imageName: colorScheme == .dark ? "globe_dark_right" : "globe_light_right",
                                    label: "East Side",
                                    isActive: side == "East Side"
                                )
                                Spacer()
                            }
                            .frame(width: 140)
                            .padding(.trailing, 16)
                        }
                        .padding(.vertical, 32)
                    }
                }
            }
            .navigationDestination(for: String.self) { value in
                if value == "Game" {
                    GameView(side: side, path: $path)
                }
            }
        }
        .onAppear {
            loadName()
            isLoadingLocation = true
            getLocation()
            _ = CardGenerator.generateDeck()
            _ = CardGenerator.cardStrengths()
        }
    }

    // MARK: - Sections

    var nameSection: some View {
        VStack(spacing: 8) {
            Button(action: {
                nameInput = storedName
                editingName = true
            }) {
                Text("Insert name")
                    .foregroundColor(.blue)
                    .underline()
                    .frame(width: 150, height: 50)
            }

            if !editingName && !storedName.isEmpty {
                Text("Hi \(storedName)")
                    .font(.title2)
                    .bold()
            }

            if editingName {
                VStack(spacing: 8) {
                    TextField("Enter your name", text: $nameInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150)

                    Button("Save") {
                        saveName()
                        getLocation()
                        editingName = false
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }

    var globeRow: some View {
        HStack {
            sideBox(
                imageName: colorScheme == .dark ? "globe_dark_left" : "globe_light_left",
                label: "West Side",
                isActive: side == "West Side"
            )
            Spacer()
            sideBox(
                imageName: colorScheme == .dark ? "globe_dark_right" : "globe_light_right",
                label: "East Side",
                isActive: side == "East Side"
            )
        }
        .padding(.horizontal, 32)
    }

    var startButton: some View {
        Group {
            if !storedName.isEmpty {
                VStack(spacing: 10) {
                    if isLoadingLocation {
                        ProgressView("Getting location...")
                            .font(.caption)
                    } else if locationError != nil {
                        Text("Location is required to determine your side.")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button("START") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            GameManager.shared.reset()
                            SoundManager.shared.playBGM(named: "bgm", volume: 0.05)
                            
                            path = ["Game"]
                        }
                    }
                    .disabled(side.isEmpty)
                    .padding()
                    .frame(width: 160)
                    .background(side.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }

    // MARK: - Utility

    func sideBox(imageName: String, label: String, isActive: Bool) -> some View {
        VStack(spacing: 4) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            Text(label)
                .font(.caption)
        }
        .padding(8)
        .background(isActive ? Color.blue.opacity(0.2) : Color.clear)
        .cornerRadius(12)
    }

    func saveName() {
        UserDefaults.standard.set(nameInput, forKey: "playerName")
        storedName = nameInput
    }

    func loadName() {
        if let name = UserDefaults.standard.string(forKey: "playerName") {
            storedName = name
        }
    }

    func getLocation() {
        isLoadingLocation = true
        LocationManager.shared.requestLocation { location, error in
            isLoadingLocation = false
            if let loc = location {
                let midpoint = 34.817549168324334
                side = loc.coordinate.latitude > midpoint ? "West Side" : "East Side"
                locationError = nil
                print("✅ Side assigned: \(side)")
            } else {
                locationError = "Location required to determine your side."
                print("❌ Error:", error?.localizedDescription ?? "Unknown")
            }
        }
    }}
