import SwiftUI

struct CircularImageView: View {
  var color: Color

  var body: some View {
    VStack {
      Image(systemName: "list.bullet")
        .foregroundColor(.white)
    }
    .padding(12)
    .background(color)
    .clipShape(Circle())
  }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(color: Color.red)
    }
}
