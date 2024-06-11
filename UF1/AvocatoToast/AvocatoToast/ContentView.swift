import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                OrderFormView()
            }
            .tabItem {
                Image(systemName: "doc.text.fill")
                Text("New Order")
            }.tag(0)
            NavigationView {
                OrderHistoryView()
            }
            .tabItem {
                Image(systemName: ("clock.fill"))
                Text("History")
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(OrderStore()) // Proveer el OrderStore al entorno en el preview
    }
}
