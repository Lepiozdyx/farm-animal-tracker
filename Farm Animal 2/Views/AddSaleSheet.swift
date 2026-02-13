import SwiftUI

struct AddSaleSheet: View {
    @Binding var isPresented: Bool
    @ObservedObject var saleStore: SaleStore
    let editingSale: Sale?
    
    @State private var selectedCategory: SaleCategory?
    @State private var selectedType: AnimalType?
    @State private var quantity: String = ""
    @State private var amount: String = ""
    @State private var customer: String = ""
    
    @State private var showCategoryPicker = false
    @State private var showTypePicker = false
    
    init(isPresented: Binding<Bool>, saleStore: SaleStore, editingSale: Sale? = nil) {
        self._isPresented = isPresented
        self.saleStore = saleStore
        self.editingSale = editingSale
        
        if let sale = editingSale {
            _selectedCategory = State(initialValue: sale.category)
            _selectedType = State(initialValue: sale.animalType)
            _quantity = State(initialValue: String(Int(sale.quantity)))
            _amount = State(initialValue: String(Int(sale.amount)))
            _customer = State(initialValue: sale.customer)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                ScrollView {
                    VStack(spacing: screenHeight * 0.025) {
                        Text(editingSale == nil ? "Adding sale" : "Edit sale")
                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.03))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, screenHeight * 0.03)
                        
                        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                            Text("Category")
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                            
                            Button(action: {
                                showCategoryPicker = true
                            }) {
                                HStack {
                                    Text(selectedCategory?.rawValue ?? "Select category")
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                        .foregroundColor(selectedCategory == nil ? Color.white.opacity(0.4) : .white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: screenHeight * 0.018))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .padding(.horizontal, screenHeight * 0.02)
                                .padding(.vertical, screenHeight * 0.018)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                            Text("Type")
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                            
                            Button(action: {
                                showTypePicker = true
                            }) {
                                HStack {
                                    Text(selectedType?.rawValue ?? "Select type")
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                        .foregroundColor(selectedType == nil ? Color.white.opacity(0.4) : .white)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: screenHeight * 0.018))
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .padding(.horizontal, screenHeight * 0.02)
                                .padding(.vertical, screenHeight * 0.018)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                            Text("Quantity (kg)")
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                            
                            TextField("", text: $quantity)
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                                .keyboardType(.decimalPad)
                                .placeholder(when: quantity.isEmpty) {
                                    Text("Enter quantity")
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                        .foregroundColor(.white.opacity(0.4))
                                }
                                .padding(.horizontal, screenHeight * 0.02)
                                .padding(.vertical, screenHeight * 0.018)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                            Text("Amount (£)")
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                            
                            TextField("", text: $amount)
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                                .keyboardType(.decimalPad)
                                .placeholder(when: amount.isEmpty) {
                                    Text("Enter amount")
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                        .foregroundColor(.white.opacity(0.4))
                                }
                                .padding(.horizontal, screenHeight * 0.02)
                                .padding(.vertical, screenHeight * 0.018)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: screenHeight * 0.01) {
                            Text("Customer (optional)")
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                            
                            TextField("", text: $customer)
                                .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                .foregroundColor(.white)
                                .placeholder(when: customer.isEmpty) {
                                    Text("Enter customer name")
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                        .foregroundColor(.white.opacity(0.4))
                                }
                                .padding(.horizontal, screenHeight * 0.02)
                                .padding(.vertical, screenHeight * 0.018)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            hideKeyboard()
                            if editingSale != nil {
                                saveSale()
                            } else {
                                addSale()
                            }
                        }) {
                            Text(editingSale == nil ? "Add" : "Save")
                                .font(.custom("Onest-SemiBold", size: screenHeight * 0.022))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, screenHeight * 0.02)
                                .background(
                                    RoundedRectangle(cornerRadius: screenHeight * 0.015)
                                        .fill(Color("color_5"))
                                )
                        }
                        .padding(.top, screenHeight * 0.01)
                        .padding(.bottom, screenHeight * 0.03)
                    }
                    .padding(.horizontal, screenHeight * 0.025)
                }
                .background(Color("color_3"))
                .cornerRadius(screenHeight * 0.025, corners: [.topLeft, .topRight])
            }
            
            if showCategoryPicker {
                PickerSheet(
                    isPresented: $showCategoryPicker,
                    title: "Select Category",
                    options: SaleCategory.allCases.map { $0.rawValue },
                    onSelect: { value in
                        selectedCategory = SaleCategory.allCases.first { $0.rawValue == value }
                    }
                )
            }
            
            if showTypePicker {
                PickerSheet(
                    isPresented: $showTypePicker,
                    title: "Select Type",
                    options: AnimalType.allCases.map { $0.rawValue },
                    onSelect: { value in
                        selectedType = AnimalType.allCases.first { $0.rawValue == value }
                    }
                )
            }
        }
    }
    
    private func addSale() {
        guard let category = selectedCategory else {
            print("Category not selected")
            return
        }
        
        guard let type = selectedType else {
            print("Type not selected")
            return
        }
        
        guard !quantity.isEmpty, let quantityDouble = Double(quantity), quantityDouble > 0 else {
            print("Quantity invalid: \(quantity)")
            return
        }
        
        guard !amount.isEmpty, let amountDouble = Double(amount), amountDouble > 0 else {
            print("Amount invalid: \(amount)")
            return
        }
        
        let sale = Sale(
            category: category,
            animalType: type,
            quantity: quantityDouble,
            amount: amountDouble,
            customer: customer
        )
        
        print("Adding sale: \(sale)")
        saleStore.addSale(sale)
        
        DispatchQueue.main.async {
            isPresented = false
        }
    }
    
    private func saveSale() {
        guard let category = selectedCategory else {
            print("Category not selected")
            return
        }
        
        guard let type = selectedType else {
            print("Type not selected")
            return
        }
        
        guard !quantity.isEmpty, let quantityDouble = Double(quantity), quantityDouble > 0 else {
            print("Quantity invalid: \(quantity)")
            return
        }
        
        guard !amount.isEmpty, let amountDouble = Double(amount), amountDouble > 0 else {
            print("Amount invalid: \(amount)")
            return
        }
        
        guard let editingSale = editingSale else {
            return
        }
        
        if let index = saleStore.sales.firstIndex(where: { $0.id == editingSale.id }) {
            saleStore.sales[index] = Sale(
                id: editingSale.id,
                category: category,
                animalType: type,
                quantity: quantityDouble,
                amount: amountDouble,
                customer: customer,
                date: editingSale.date
            )
            
            print("Sale updated")
        }
        
        DispatchQueue.main.async {
            isPresented = false
        }
    }
}

#Preview {
    AddSaleSheet(isPresented: .constant(true), saleStore: SaleStore.shared)
}
