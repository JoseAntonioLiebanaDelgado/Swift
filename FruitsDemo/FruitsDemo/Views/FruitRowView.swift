
import SwiftUI

struct FruitRowView: View {
    let fruit:Fruit
    var body: some View{
        HStack {
            Text(fruit.emoji.rawValue)
            Text(fruit.name)
        }
    }
}

struct FruitRowView_Previews: PreviewProvider {
    static var previews: some View {
        FruitRowView(fruit: FruitStore.defaultFruit)
            .previewLayout(.sizeThatFits)
    }
}
