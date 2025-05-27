import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    
    private var bgmPlayer: AVAudioPlayer?
    private var sfxPlayer: AVAudioPlayer?
    private var originalBGMVolume: Float = 0.3

    private init() {}

    func playBGM(named name: String, volume: Float = 0.3) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("BGM file \(name) not found.")
            return
        }

        do {
            originalBGMVolume = volume
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.volume = volume
            bgmPlayer?.prepareToPlay()
            bgmPlayer?.play()
        } catch {
            print("Error playing BGM: \(error)")
        }
    }

    func stopBGM() {
        bgmPlayer?.stop()
        bgmPlayer = nil
    }

    func playSFX(named name: String, volume: Float = 0.5) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("SFX file \(name) not found.")
            return
        }

        do {
            // 🔉 Duck BGM
            bgmPlayer?.setVolume(originalBGMVolume * 0.4, fadeDuration: 0.1)

            sfxPlayer = try AVAudioPlayer(contentsOf: url)
            sfxPlayer?.volume = volume
            sfxPlayer?.prepareToPlay()
            sfxPlayer?.play()

            // 🔊 Restore BGM after 1.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.bgmPlayer?.setVolume(self.originalBGMVolume, fadeDuration: 0.2)
            }
        } catch {
            print("Error playing SFX: \(error)")
        }
    }
}
