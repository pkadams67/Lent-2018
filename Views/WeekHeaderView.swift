//  See LICENSE folder for this project’s licensing information.

import UIKit

class WeekHeaderView: UICollectionReusableView {

    @IBOutlet var labels: [UILabel]!
    
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        if labels.count == formatter.weekdaySymbols.count {
            for i in 0 ..< formatter.weekdaySymbols.count {
                let weekDayString = formatter.weekdaySymbols[i]
                labels[i].text    = String(weekDayString[..<weekDayString.index(weekDayString.startIndex, offsetBy: 3)])
            }
        }
    }
}
