import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var orderStore: OrderStore
    
    var body: some View {
        List {
            ForEach(orderStore.orders) { order in
                NavigationLink(destination: OrderDetailView(order: order)) {
                    VStack(alignment: .leading) {
                        Text(order.purchaseDateToPrint)
                        Text("\(order.quantity) x \(order.bread.rawValue) - \(order.toast.rawValue)")
                    }
                }
            }
            .onDelete(perform: orderStore.deleteOrder)
        }
        .navigationBarTitle(Text("History"), displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .environmentObject(OrderStore())
    }
}
