import SwiftUI

struct AnimalCard: View {
    let animal: Animal
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: screenHeight * 0.015) {
            HStack(spacing: screenHeight * 0.015) {
                Image(animal.type.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight * 0.05)
                
                Text("\(animal.type.rawValue) ")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                    .foregroundColor(.white) +
                Text("(\(animal.quantity))")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                    .foregroundColor(Color("color_1"))
                
                Spacer()
                
                Button(action: onEdit) {
                    Image("editImg")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight * 0.04)
                }
                
                Button(action: onDelete) {
                    Image("deleteImg")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight * 0.04)
                }
            }
            
            HStack(spacing: screenHeight * 0.04) {
                VStack(alignment: .leading, spacing: screenHeight * 0.005) {
                    Text("Breed:")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text(animal.breed)
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: screenHeight * 0.005) {
                    Text("Sex:")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text(animal.sex.rawValue)
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            HStack {
                Text(animal.status.rawValue)
                    .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                    .foregroundColor(statusColor(for: animal.status))
                    .padding(.horizontal, screenHeight * 0.015)
                    .padding(.vertical, screenHeight * 0.008)
                    .background(
                        RoundedRectangle(cornerRadius: screenHeight * 0.01)
                            .stroke(statusColor(for: animal.status).opacity(0.5), lineWidth: 1)
                    )
                
                Spacer()
            }
        }
        .padding(screenHeight * 0.02)
        .background(
            RoundedRectangle(cornerRadius: screenHeight * 0.02)
                .fill(Color("color_3"))
        )
    }
    
    private func statusColor(for status: AnimalStatus) -> Color {
        switch status {
        case .inBreeding:
            return .green
        case .onFeed:
            return .blue
        case .forSale:
            return .red
        }
    }
}

#Preview {
    AnimalCard(
        animal: Animal(
            type: .chickens,
            quantity: 10,
            breed: "Rhode Island Red",
            sex: .female,
            status: .inBreeding
        ),
        onEdit: {},
        onDelete: {}
    )
    .padding()
    .background(Color.black)
}
