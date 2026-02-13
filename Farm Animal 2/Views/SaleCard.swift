import SwiftUI

struct SaleCard: View {
    let sale: Sale
    let onEdit: () -> Void
    let onRemove: () -> Void
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
    
    private var categoryIcon: String {
        switch sale.category {
        case .eggs:
            return "🥚"
        case .pork:
            return "🥓"
        case .lamb:
            return "🐑"
        case .wool:
            return "🧶"
        case .milk:
            return "🥛"
        case .meat:
            return "🥩"
        case .other:
            return "📦"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: screenHeight * 0.015) {
                Text(categoryIcon)
                    .font(.system(size: screenHeight * 0.04))
                
                Text("\(sale.category.rawValue) ")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                    .foregroundColor(.white) +
                Text("(\(sale.animalType.rawValue))")
                    .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                    .foregroundColor(.white.opacity(0.6))
                
                Spacer()
                
                Text("$\(Int(sale.amount))")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.025))
                    .foregroundColor(Color("color_1"))
            }
            
            HStack(spacing: screenHeight * 0.04) {
                VStack(alignment: .leading, spacing: screenHeight * 0.005) {
                    Text("Quantity:")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text("\(Int(sale.quantity)) pcs")
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: screenHeight * 0.005) {
                    Text("Customer:")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text(sale.customer.isEmpty ? "-" : sale.customer)
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.02))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding(.top, screenHeight * 0.015)
            
            HStack {
                Text(dateFormatter.string(from: sale.date))
                    .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                    .foregroundColor(.white.opacity(0.5))
                
                Spacer()
            }
            .padding(.top, screenHeight * 0.01)
            
            Divider()
                .background(Color.white.opacity(0.2))
                .padding(.vertical, screenHeight * 0.015)
            
            HStack(spacing: screenHeight * 0.02) {
                Button(action: onEdit) {
                    HStack(spacing: screenHeight * 0.008) {
                        Image("editImg")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight * 0.022)
                        
                        Text("Edit")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Button(action: onRemove) {
                    HStack(spacing: screenHeight * 0.008) {
                        Image("deleteImg")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight * 0.022)
                        
                        Text("Remove")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.018))
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding(screenHeight * 0.02)
        .background(
            RoundedRectangle(cornerRadius: screenHeight * 0.02)
                .fill(Color("color_3"))
        )
    }
}

#Preview {
    SaleCard(
        sale: Sale(
            category: .eggs,
            animalType: .chickens,
            quantity: 30,
            amount: 600,
            customer: "Ivan Petrov"
        ),
        onEdit: {},
        onRemove: {}
    )
    .padding()
    .background(Color.black)
}
