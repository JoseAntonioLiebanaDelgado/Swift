import Foundation
import SwiftUI

class Obstacle:Sprite, Identifiable{
    let id = UUID()
    var speed:CGFloat
    
    override init(center:CGPoint, width:CGFloat, height: CGFloat){

        self.speed = CGFloat.random(in: 3...6)
        super.init(center: center, width: width, height: height)
    }
    
    func move(){
        withAnimation{
            self.center.y+=speed
        }
    }
    
    //After obstacle position>yMAX: restart obstacle position and speed
    func restart(){
        
        self.center.y = 0
        self.center.x = CGFloat.random(in: 50..<UIScreen.main.bounds.maxX-50)
        self.speed = CGFloat.random(in: 3...6)
    }
}
