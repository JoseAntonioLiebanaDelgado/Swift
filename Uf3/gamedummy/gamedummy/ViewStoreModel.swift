//
//  ViewStoreModel.swift
//  gamedummy
//
//  Created by alumne on 10/04/2024.
//

import SwiftUI

class ViewStoreModel: ObservableObject {
    @Published var center = CGPoint(x: 100, y: 20)
    private var displaylink:  CADisplayLink?
    
    private let minX = UIScreen.main.bounds.minX
    private let maxX = UIScreen.main.bounds.maxX
    private let minY = UIScreen.main.bounds.minY
    private let maxY = UIScreen.main.bounds.maxY
    
    enum Direction{
        case up
        case down
        
    }
    enum Horizontal{
        case left
        case right
    }
    
    private var speed:CGFloat = 2
    private var direction = Direction.up
    private var horizontal = Horizontal.right
    
    func createDisplayLink() {
        displaylink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displaylink?.add(to: .current, forMode: .default)
    }
         
    @objc func gameLoop() {
        //update position
        switch direction {
        case .down:
            self.center.y+=speed
        case .up:
            self.center.y-=speed
        
        }
        switch horizontal {
        case .left:
            self.center.x-=speed
        case .right:
            self.center.x+=speed
        }
        
        //check screen colition
        if (self.center.y>=maxY) {
            self.direction = .up
        }else if (self.center.y<=minY){
            self.direction = .down
        }
        if (self.center.x>=maxX){
            self.horizontal = .left
        }else if (self.center.x<=minX){
            self.horizontal = .right
        }
    }
}
