import SwiftUI

struct ContentView: View {
    @State private var isPresentingCamera = false
    
    var body: some View {
        VStack {
            Button(action: {
                isPresentingCamera = true
            }) {
                Text("Scan Bill")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .fullScreenCover(isPresented: $isPresentingCamera) {
                CameraView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
