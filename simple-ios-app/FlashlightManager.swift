import AVFoundation

class FlashlightManager: ObservableObject {
    @Published var isOn: Bool = false
    
    func toggle() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
            print("Torch unavailable")
            return
        }
        
        do {
            try device.lockForConfiguration()
            if isOn {
                device.torchMode = .off
                isOn = false
            } else {
                try device.setTorchModeOn(level: 1.0)
                isOn = true
            }
            device.unlockForConfiguration()
        } catch {
            print("Torch error: \(error)")
        }
    }
}
