
import SwiftUI

struct AddFruitView: View {
    
    @Binding var newFruit: Fruit
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var fruitStore: FruitStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $newFruit.name)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $newFruit.description)
                }
                Section(header: Text("Image")) {
                    EmojiPicker(emoji: $newFruit.emoji)
                }
            }
            
            .navigationBarTitle("Add Fruit")
            .navigationBarItems(
                leading: Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Guardar") {
                    addFruit()
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    func addFruit() {
        fruitStore.fruits.append(newFruit)
    }
}

    
struct AddFruitView_Previews: PreviewProvider {
    static var previews: some View {
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
            .preferredColorScheme(.dark)
        AddFruitView(newFruit: .constant(FruitStore.defaultFruit))
            .previewLayout(.fixed(width: 480, height: 320))
    }
}
