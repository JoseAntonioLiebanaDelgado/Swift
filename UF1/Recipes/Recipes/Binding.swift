import SwiftUI

extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}
