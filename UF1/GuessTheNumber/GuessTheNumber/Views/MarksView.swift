import SwiftUI

struct MarksView: View {
    @Binding var isVisible:Bool
    let game:Game
    var body: some View {
        VStack {
            HStack {
                Text("Marks".uppercased())
                    .font(.title)
                    .fontWeight(.bold)
                    .kerning(10)
                Spacer()
                Button("Close"){
                    isVisible = false
                }
            }
            List(0..<game.marks.count){index in
                HStack{
                    Text("\(index+1)")
                        .kerning(1)
                        .frame(width: 68, height: 56)
                        .overlay(RoundedRectangle(cornerRadius: 21).stroke())
                    Spacer()
                    Text("\(game.marks[index].value)")
                    Spacer()
                    Text(game.marks[index].date, style:.time)
                }
            }
        }.padding(.horizontal)
    }
}


struct MarksView_Previews: PreviewProvider {
    static var previews: some View {
        MarksView(isVisible: .constant(false), game: Game())
    }
}
