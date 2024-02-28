import Foundation


class Utils{
    static func dateformatter(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
