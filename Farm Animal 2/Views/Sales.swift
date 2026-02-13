import SwiftUI

struct Sales: View {
    @ObservedObject var saleStore: SaleStore
    @Binding var showAddSaleSheet: Bool
    @Binding var editingSale: Sale?
    @Binding var showDeleteConfirmation: Bool
    @Binding var saleToDelete: Sale?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("Sales")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.028))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    showAddSaleSheet = true
                }) {
                    Text("+ Add")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white)
                        .padding(.horizontal, screenHeight * 0.02)
                        .padding(.vertical, screenHeight * 0.01)
                        .background(
                            RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                .fill(Color("color_5"))
                        )
                }
            }
            .padding(.horizontal, screenHeight * 0.025)
            .padding(.bottom, screenHeight * 0.02)
            
            VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                Text("Total sales amount")
                    .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                    .foregroundColor(.white.opacity(0.7))
                
                Text("$\(Int(saleStore.totalSalesAmount).formatted())")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.045))
                    .foregroundColor(Color("color_1"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(screenHeight * 0.02)
            .background(
                RoundedRectangle(cornerRadius: screenHeight * 0.02)
                    .fill(Color("color_3"))
            )
            .padding(.horizontal, screenHeight * 0.025)
            .padding(.bottom, screenHeight * 0.02)
            
            if saleStore.sales.isEmpty {
                Spacer()
                
                VStack(spacing: screenHeight * 0.015) {
                    Text("No sales")
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.025))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("Click \"Add\" to start")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: screenHeight * 0.015) {
                        ForEach(saleStore.sales) { sale in
                            SaleCard(
                                sale: sale,
                                onEdit: {
                                    editingSale = sale
                                    showAddSaleSheet = true
                                },
                                onRemove: {
                                    saleToDelete = sale
                                    showDeleteConfirmation = true
                                }
                            )
                        }
                    }
                    .padding(.horizontal, screenHeight * 0.025)
                    .padding(.bottom, screenHeight * 0.02)
                }
            }
        }
    }
}

#Preview {
    Sales(saleStore: SaleStore.shared, showAddSaleSheet: .constant(false), editingSale: .constant(nil), showDeleteConfirmation: .constant(false), saleToDelete: .constant(nil))
        .background(Color.black)
}
