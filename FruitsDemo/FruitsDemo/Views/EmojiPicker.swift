import SwiftUI

struct EmojiPicker: View {
  @Binding var emoji: EmojiFruit

  var body: some View {
    Picker(selection: $emoji, label: Text("")) {
      ForEach(EmojiFruit.allCases, id: \.self) {
        Text($0.rawValue).font(.largeTitle)
      }
    }
    .pickerStyle(WheelPickerStyle())
  }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker(emoji: .constant(EmojiFruit.apple))
    }
}
