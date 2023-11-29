import Foundation
class FruitStore:ObservableObject{
    
    @Published var fruits = loadFruits()
    
    static func loadFruits()->[Fruit]{
        return FruitStore.defaultFruits
    }
    
    static let defaultFruits = [
        Fruit(name: "Apple", emoji: .apple, description: "Apples help your body develop resistance against infections"),
        Fruit(name: "Pineapple", emoji: .pineapple, description: "Pineapples help fight arthritis"),
        Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate"),
    ]
    
    static let defaultFruit =  Fruit(name: "Watermelon", emoji: .watermelon, description: "Watermelon helps control your heart rate")
    
}
