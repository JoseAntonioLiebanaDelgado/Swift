import Foundation

struct Fruit: Hashable, Identifiable{
    var id: some Hashable{name}
    var name:String
    var emoji:EmojiFruit
    var description:String
}

enum EmojiFruit:String, CaseIterable {
  case apple = "🍎"
  case banana = "🍌"
  case coco =  "🥥"
  case grape = "🍇"
  case kiwi = "🥝"
  case lemon = "🍋"
  case orange = "🍊"
  case pear = "🍐"
  case pineapple = "🍍"
  case strawberry = "🍓"
  case watermelon = "🍉"

}
