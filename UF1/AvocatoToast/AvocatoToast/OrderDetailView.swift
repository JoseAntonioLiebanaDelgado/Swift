import SwiftUI

struct OrderDetailView: View {
    var order: Order
    
    var body: some View {
        Form {
            Section(header: Text("BASE")) {
                Text("Bread: \(order.bread.rawValue)")
                Text("Toast: \(order.toast.rawValue)")
                Text("Avocado: \(order.avocado.rawValue)")
            }
            
            Section(header: Text("EXTRAS")) {
                Text("Include Salt: \(order.includeSalt ? "Yes" : "No")")
                Text("Include Eggs: \(order.includeEggs ? "Yes" : "No")")
            }
            
            Section(header: Text("QUANTITY")) {
                Text("Quantity: \(order.quantity)")
            }
            
            Section(header: Text("DATE")) {
                Text("Purchase Date: \(order.purchaseDateToPrint)")
            }
        }
        .navigationBarTitle(Text("Order Details"), displayMode: .inline)
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: Order())
    }
}
