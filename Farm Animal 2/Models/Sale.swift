import Foundation
internal import Combine

enum SaleCategory: String, CaseIterable, Codable {
    case eggs = "Eggs"
    case pork = "Pork"
    case lamb = "Lamb"
    case wool = "Wool"
    case milk = "Milk"
    case meat = "Meat"
    case other = "Other"
}

struct Sale: Identifiable, Codable {
    let id: UUID
    var category: SaleCategory
    var animalType: AnimalType
    var quantity: Double
    var amount: Double
    var customer: String
    var date: Date
    
    init(id: UUID = UUID(), category: SaleCategory, animalType: AnimalType, quantity: Double, amount: Double, customer: String = "", date: Date = Date()) {
        self.id = id
        self.category = category
        self.animalType = animalType
        self.quantity = quantity
        self.amount = amount
        self.customer = customer
        self.date = date
    }
}

class SaleStore: ObservableObject {
    @Published var sales: [Sale] = []
    
    static let shared = SaleStore()
    
    var totalSalesAmount: Double {
        sales.reduce(0) { $0 + $1.amount }
    }
    
    func addSale(_ sale: Sale) {
        sales.append(sale)
    }
    
    func deleteSale(_ sale: Sale) {
        sales.removeAll { $0.id == sale.id }
    }
}
