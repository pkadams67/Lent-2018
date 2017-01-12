//
//  WeekHeaderView.swift
//  Lent '17
//
//  Created by Paul Kirk Adams on 1/12/17.
//  Copyright © 2017 Paul Kirk Adams. All rights reserved.
//

import UIKit

class WeekHeaderView: UICollectionReusableView {

    @IBOutlet var labels: [UILabel]!
    
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        if labels.count == formatter.weekdaySymbols.count {
            for i in 0 ..< formatter.weekdaySymbols.count {
                let weekDayString = formatter.weekdaySymbols[i] 
                labels[i].text = weekDayString.substring(to: weekDayString.characters.index(weekDayString.startIndex, offsetBy: 3)) //.uppercaseString
            }
        }
    }
}
