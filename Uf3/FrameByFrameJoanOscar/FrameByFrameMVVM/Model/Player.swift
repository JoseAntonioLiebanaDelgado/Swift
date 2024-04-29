import Foundation
import SwiftUI


class Player: Sprite{
    var initialCenter:CGPoint = CGPoint.zero
    func moveToPoint(_ point:CGPoint){
        withAnimation{
            self.center.x =  point.x
        }
    }
}
