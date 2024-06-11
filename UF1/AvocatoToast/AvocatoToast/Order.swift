import Foundation

struct Order: Identifiable {
    var bread: Bread = .sourdough
    var toast: Toast = .lightly
    var avocado: Avocado = .spread
    var includeSalt: Bool = false
    var includeEggs: Bool = false
    var quantity: Int = 1
    var purchaseDate = Date()
   
    var id = UUID()
   
    var purchaseDateToPrint: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let formattedDate = formatter.string(from: purchaseDate)
        return formattedDate
    }
}

enum Bread: String, CaseIterable, Hashable, Identifiable {
    case rye = "Rye"
    case sourdough = "Sourdough"
    case wheat = "Wheat"
    case multigrain = "Multigrain"

    var id: Bread { self }
}

enum Toast: String, CaseIterable, Hashable, Identifiable {
    case none = "Not toasted"
    case lightly = "Lightly toasted"
    case well = "Well toasted"
    case crunch = "Crunch toasted"
   
    var id: Toast { self }
}

enum Avocado: String, CaseIterable, Hashable, Identifiable {
    case none = "None"
    case spread = "Spread"
    case sliced = "Sliced"
   
    var id: Avocado { self }
}
