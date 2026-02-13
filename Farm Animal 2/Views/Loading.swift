import SwiftUI

struct Loading: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Loading")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.025))
                    .foregroundColor(.white)
                    .padding(.bottom, screenHeight * 0.05)
            }
        }
    }
}

#Preview {
    Loading()
}
