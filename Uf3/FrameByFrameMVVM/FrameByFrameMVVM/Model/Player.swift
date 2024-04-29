import Foundation
import SwiftUI


class Player: Sprite{
    func moveToPoint(_ point:CGPoint){
        withAnimation{
            //print("Before moveToPoint \(self.center.x)")
            self.center.x =  point.x
            //print("After moveToPoint \(self.center.x)")
        }
    }
}
