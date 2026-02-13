import SwiftUI

struct Animals: View {
    @ObservedObject var animalStore: AnimalStore
    @Binding var showAddSheet: Bool
    @Binding var editingAnimal: Animal?
    @Binding var showDeleteConfirmation: Bool
    @Binding var animalToDelete: Animal?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("Animals")
                    .font(.custom("Onest-SemiBold", size: screenHeight * 0.028))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    showAddSheet = true
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
            .padding(.bottom)
            
            if animalStore.animals.isEmpty {
                Spacer()
                
                VStack(spacing: screenHeight * 0.015) {
                    Text("No animals")
                        .font(.custom("Onest-SemiBold", size: screenHeight * 0.025))
                        .foregroundColor(.white.opacity(0.7))
                    
                    Text("Click \"Add\" to get started")
                        .font(.custom("Onest-Medium", size: screenHeight * 0.02))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: screenHeight * 0.015) {
                            ForEach(animalStore.animals) { animal in
                                AnimalCard(
                                    animal: animal,
                                    onEdit: {
                                        editingAnimal = animal
                                        showAddSheet = true
                                    },
                                    onDelete: {
                                        animalToDelete = animal
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
    Animals(animalStore: AnimalStore.shared, showAddSheet: .constant(false), editingAnimal: .constant(nil), showDeleteConfirmation: .constant(false), animalToDelete: .constant(nil))
        .background(Color.black)
}
