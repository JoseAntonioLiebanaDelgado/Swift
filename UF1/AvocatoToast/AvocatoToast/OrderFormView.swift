import SwiftUI

struct OrderFormView: View {
    @State private var order = Order()
    @EnvironmentObject var orderStore: OrderStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("BASE")) {
                Picker("Bread", selection: $order.bread) {
                    ForEach(Bread.allCases) { bread in
                        Text(bread.rawValue).tag(bread)
                    }
                }
                Picker("Toast", selection: $order.toast) {
                    ForEach(Toast.allCases) { toast in
                        Text(toast.rawValue).tag(toast)
                    }
                }
                Picker("Avocado", selection: $order.avocado) {
                    ForEach(Avocado.allCases) { avocado in
                        Text(avocado.rawValue).tag(avocado)
                    }
                }
            }
            
            Section(header: Text("EXTRAS")) {
                Toggle("Include Salt", isOn: $order.includeSalt)
                Toggle("Include Eggs", isOn: $order.includeEggs)
            }
            
            Section(header: Text("QUANTITY")) {
                Stepper(value: $order.quantity, in: 1...10) {
                    Text("Quantity: \(order.quantity)")
                }
            }
            
            Button(action: {
                orderStore.addOrder(order)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Submit Order")
            }
        }
        .navigationBarTitle(Text("Avocado Toast Order"), displayMode: .inline)
    }
}

struct OrderFormView_Previews: PreviewProvider {
    static var previews: some View {
        OrderFormView()
            .environmentObject(OrderStore()) // Proveer el OrderStore al entorno en el preview
    }
}
