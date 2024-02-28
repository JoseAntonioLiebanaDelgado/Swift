import Foundation
struct Game{
    private(set) var target = Int.random(in: 1...100)
    private(set) var score = 0
    private(set) var points = 0
    private(set) var round = 1
    private(set) var marks = [Mark]()
    
    private let maxNumberMarks = 5
    
    mutating func points(sliderValue: Int){
        points = 100-abs(sliderValue-target)
        score+=points
        addMark()
    }
    
    mutating func startNewRound(){
       target = Int.random(in: 1...100)
       round+=1
    }
    
    mutating func restartGame(){
        score = 0
        round = 0
    }
    
    private mutating func addMark(){
        if marks.count<maxNumberMarks{
            self.marks.append(Mark(value:points, date:Date()))
        }else if marks.last!.value<points{
            marks.removeLast()
            marks.append(Mark(value:points, date:Date()))
        }
        
        self.marks.sort{$0<$1}
    }
}
