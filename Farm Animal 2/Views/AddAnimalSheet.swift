import SwiftUI

struct PickerSheet: View {
    @Binding var isPresented: Bool
    let title: String
    let options: [String]
    let onSelect: (String) -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack {
                Spacer()
                
                VStack(spacing: 0) {
                    Text(title)
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.025))
                        .foregroundColor(.white)
                        .padding(.vertical, screenHeight * 0.02)
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(options, id: \.self) { option in
                                Button(action: {
                                    onSelect(option)
                                    isPresented = false
                                }) {
                                    Text(option)
                                        .font(.custom("Onest-Medium", size: screenHeight * 0.022))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, screenHeight * 0.018)
                                }
                                
                                if option != options.last {
                                    Divider()
                                        .background(Color.white.opacity(0.2))
                                }
                            }
                        }
                    }
                    .frame(maxHeight: screenHeight * 0.4)
                }
                .padding(.horizontal, screenHeight * 0.025)
                .padding(.bottom, screenHeight * 0.03)
                .background(Color("color_3"))
                .cornerRadius(screenHeight * 0.025, corners: [.topLeft, .topRight])
            }
        }
    }
}

struct AddAnimalSheet: View {
    @Binding var isPresented: Bool
    @ObservedObject var animalStore: AnimalStore
    let editingAnimal: Animal?
    
    @State private var selectedType: AnimalType?
    @State private var quantity: String = ""
    @State private var breed: String = ""
    @State private var selectedSex: AnimalSex?
    @State private var selectedStatus: AnimalStatus?
    
    @State private var showTypePicker = false
    @State private var showSexPicker = false
    @State private var showStatusPicker = false
    
    init(isPresented: Binding<Bool>, animalStore: AnimalStore, editingAnimal: Animal? = nil) {
        self._isPresented = isPresented
        self.animalStore = animalStore
        self.editingAnimal = editingAnimal
        
        if let animal = editingAnimal {
            _selectedType = State(initialValue: animal.type)
            _quantity = State(initialValue: String(animal.quantity))
            _breed = State(initialValue: animal.breed)
            _selectedSex = State(initialValue: animal.sex)
            _selectedStatus = State(initialValue: animal.status)
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
                        Text(editingAnimal == nil ? "Adding animals" : "Edit animal")
                            .font(.custom("Onest-SemiBold", size: screenHeight * 0.03))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, screenHeight * 0.03)
                    
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
                        Text("Quantity")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                        
                        TextField("", text: $quantity)
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                            .keyboardType(.numberPad)
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
                        Text("Breed")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                        
                        TextField("", text: $breed)
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                            .placeholder(when: breed.isEmpty) {
                                Text("Enter breed")
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
                        Text("Sex")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            showSexPicker = true
                        }) {
                            HStack {
                                Text(selectedSex?.rawValue ?? "Select sex")
                                    .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                    .foregroundColor(selectedSex == nil ? Color.white.opacity(0.4) : .white)
                                
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
                        Text("Status")
                            .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                            .foregroundColor(.white)
                        
                        Button(action: {
                            showStatusPicker = true
                        }) {
                            HStack {
                                Text(selectedStatus?.rawValue ?? "Select status")
                                    .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                                    .foregroundColor(selectedStatus == nil ? Color.white.opacity(0.4) : .white)
                                
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
                    
                        Button(action: {
                            hideKeyboard()
                            if editingAnimal != nil {
                                saveAnimal()
                            } else {
                                addAnimal()
                            }
                        }) {
                            Text(editingAnimal == nil ? "Add" : "Save")
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
            
            if showSexPicker {
                PickerSheet(
                    isPresented: $showSexPicker,
                    title: "Select Sex",
                    options: AnimalSex.allCases.map { $0.rawValue },
                    onSelect: { value in
                        selectedSex = AnimalSex.allCases.first { $0.rawValue == value }
                    }
                )
            }
            
            if showStatusPicker {
                PickerSheet(
                    isPresented: $showStatusPicker,
                    title: "Select Status",
                    options: AnimalStatus.allCases.map { $0.rawValue },
                    onSelect: { value in
                        selectedStatus = AnimalStatus.allCases.first { $0.rawValue == value }
                    }
                )
            }
        }
    }
    
    private func addAnimal() {
        guard let type = selectedType else {
            print("Type not selected")
            return
        }
        
        guard !quantity.isEmpty, let quantityInt = Int(quantity), quantityInt > 0 else {
            print("Quantity invalid: \(quantity)")
            return
        }
        
        guard !breed.isEmpty else {
            print("Breed is empty")
            return
        }
        
        guard let sex = selectedSex else {
            print("Sex not selected")
            return
        }
        
        guard let status = selectedStatus else {
            print("Status not selected")
            return
        }
        
        let animal = Animal(
            type: type,
            quantity: quantityInt,
            breed: breed,
            sex: sex,
            status: status
        )
        
        print("Adding animal: \(animal)")
        animalStore.addAnimal(animal)
        
        DispatchQueue.main.async {
            isPresented = false
        }
    }
    
    private func saveAnimal() {
        guard let type = selectedType else {
            print("Type not selected")
            return
        }
        
        guard !quantity.isEmpty, let quantityInt = Int(quantity), quantityInt > 0 else {
            print("Quantity invalid: \(quantity)")
            return
        }
        
        guard !breed.isEmpty else {
            print("Breed is empty")
            return
        }
        
        guard let sex = selectedSex else {
            print("Sex not selected")
            return
        }
        
        guard let status = selectedStatus else {
            print("Status not selected")
            return
        }
        
        guard let editingAnimal = editingAnimal else {
            return
        }
        
        if let index = animalStore.animals.firstIndex(where: { $0.id == editingAnimal.id }) {
            animalStore.animals[index] = Animal(
                id: editingAnimal.id,
                type: type,
                quantity: quantityInt,
                breed: breed,
                sex: sex,
                status: status
            )
            
            print("Animal updated")
        }
        
        DispatchQueue.main.async {
            isPresented = false
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    AddAnimalSheet(isPresented: .constant(true), animalStore: AnimalStore.shared)
}
