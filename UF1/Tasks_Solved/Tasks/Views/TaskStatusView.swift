import SwiftUI

struct TaskStatusView: View {
    let isDone:Bool
    var body: some View {
      Circle()
        .padding(4)
        .overlay(
            Circle()
            .stroke(isDone ? Color.green : Color.red, lineWidth: 2)
        )
        .foregroundColor(isDone ? .green : .clear)
        .frame(width: 20, height: 20)
    }
}

struct TaskStatusView_Previews: PreviewProvider {
    static var previews: some View {
        TaskStatusView(isDone: true)
    }
}
