import SwiftUI

struct Main: View {
    @State private var selectedTab: TabItem = .animals
    @ObservedObject var animalStore: AnimalStore = AnimalStore.shared
    @ObservedObject var saleStore: SaleStore = SaleStore.shared
    @State private var showAddSheet = false
    @State private var editingAnimal: Animal?
    @State private var showDeleteConfirmation = false
    @State private var animalToDelete: Animal?
    @State private var showAddSaleSheet = false
    @State private var editingSale: Sale?
    @State private var showDeleteSaleConfirmation = false
    @State private var saleToDelete: Sale?
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .animals:
                        Animals(
                            animalStore: animalStore,
                            showAddSheet: $showAddSheet,
                            editingAnimal: $editingAnimal,
                            showDeleteConfirmation: $showDeleteConfirmation,
                            animalToDelete: $animalToDelete
                        )
                    case .sales:
                        Sales(
                            saleStore: saleStore,
                            showAddSaleSheet: $showAddSaleSheet,
                            editingSale: $editingSale,
                            showDeleteConfirmation: $showDeleteSaleConfirmation,
                            saleToDelete: $saleToDelete
                        )
                    case .statistics:
                        Statistics(animalStore: animalStore, saleStore: saleStore)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                BottomBar(selectedTab: $selectedTab)
            }
            
            if showAddSheet {
                AddAnimalSheet(
                    isPresented: $showAddSheet,
                    animalStore: animalStore,
                    editingAnimal: editingAnimal
                )
                .onDisappear {
                    editingAnimal = nil
                }
            }
            
            if showDeleteConfirmation {
                DeleteConfirmationSheet(
                    isPresented: $showDeleteConfirmation,
                    onConfirm: {
                        if let animal = animalToDelete {
                            animalStore.deleteAnimal(animal)
                        }
                    }
                )
            }
            
            if showAddSaleSheet {
                AddSaleSheet(
                    isPresented: $showAddSaleSheet,
                    saleStore: saleStore,
                    editingSale: editingSale
                )
                .onDisappear {
                    editingSale = nil
                }
            }
            
            if showDeleteSaleConfirmation {
                DeleteConfirmationSheet(
                    isPresented: $showDeleteSaleConfirmation,
                    onConfirm: {
                        if let sale = saleToDelete {
                            saleStore.deleteSale(sale)
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    Main()
}
