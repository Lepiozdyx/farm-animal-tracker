import SwiftUI

struct DeleteConfirmationSheet: View {
    @Binding var isPresented: Bool
    let onConfirm: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: screenHeight * 0.025) {
                Text("Are you sure you want to delete this item?")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("This action cannot be undone")
                    .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                
                VStack(spacing: screenHeight * 0.015) {
                    Button(action: {
                        onConfirm()
                        isPresented = false
                    }) {
                        Text("Delete")
                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, screenHeight * 0.018)
                            .background(
                                RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                    .fill(Color("color_5"))
                            )
                    }
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, screenHeight * 0.018)
                    }
                }
            }
            .padding(screenHeight * 0.03)
            .background(
                RoundedRectangle(cornerRadius: screenHeight * 0.025)
                    .fill(Color("color_3"))
            )
            .padding(.horizontal, screenHeight * 0.04)
        }
    }
}

#Preview {
    DeleteConfirmationSheet(isPresented: .constant(true), onConfirm: {})
}
