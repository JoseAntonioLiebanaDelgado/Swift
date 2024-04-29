import Foundation
import SwiftUI


class Player: Sprite{
    
    func moveToPoint(_ point:CGPoint){
        withAnimation{
            self.center.x =  point.x
        }
    }
}
