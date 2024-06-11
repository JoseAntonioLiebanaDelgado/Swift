import Foundation
import Combine

class OrderStore: ObservableObject {
    @Published var orders: [Order] = []

    func addOrder(_ order: Order) {
        orders.append(order)
    }

    func deleteOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
    }
}
