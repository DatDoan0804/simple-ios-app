import SwiftUI

struct ContentView: View {
    @StateObject private var flashlight = FlashlightManager()
    
    var body: some View {
        VStack(spacing: 40) {
            Image(systemName: flashlight.isOn ? "flashlight.on.fill" : "flashlight.off.fill")
                .font(.system(size: 100))
                .foregroundColor(flashlight.isOn ? .yellow : .gray)
            
            Button(action: {
                flashlight.toggle()
            }) {
                Text(flashlight.isOn ? "TURN OFF" : "TURN ON")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(flashlight.isOn ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}
