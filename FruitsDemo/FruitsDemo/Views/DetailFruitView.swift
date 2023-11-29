import SwiftUI

struct DetailFruitView: View {
    let fruit:Fruit
    var body: some View {
        VStack(spacing:20.0) {
            Text(fruit.description)
                .multilineTextAlignment(.center)
                .font(.title3)
            GeometryReader{g in
                ZStack {
                    Circle().strokeBorder(Color.gray.opacity(0.15), lineWidth: 10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:5, y:5)
                    Text("\(fruit.emoji.rawValue)")
                        .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.4: g.size.height * 0.4))
                }
            }.frame(maxWidth:250)
            
        }.padding()
        
    }
}

struct DetailFruitView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFruitView(fruit: FruitStore.defaultFruit)
        DetailFruitView(fruit: FruitStore.defaultFruit)
            .preferredColorScheme(.dark)
        DetailFruitView(fruit: FruitStore.defaultFruit)
            .previewLayout(.fixed(width: 480, height: 320))
    }
}
