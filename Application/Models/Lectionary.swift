//  See LICENSE folder for this project’s licensing information.

import Foundation

class Lectionary {
    
    let dayTitle: String
    let day: String
    let collectBodyText: String
    let oldTestamentTitle: String
    let oldTestamentBodyText: String
    let psalmTitle: String
    let psalmSubtitle: String
    let psalmBodyText: String
    let epistleTitle: String
    let epistleBodyText: String
    let gospelTitle: String
    let gospelBodyText: String
    
    init(
        dayTitle: String,
        day: String,
        collectBodyText: String,
        oldTestamentTitle: String,
        oldTestamentBodyText: String,
        psalmTitle: String,
        psalmSubtitle: String,
        psalmBodyText: String,
        epistleTitle: String,
        epistleBodyText: String,
        gospelTitle: String,
        gospelBodyText: String
        ) {
        self.dayTitle             = dayTitle
        self.day                  = day
        self.collectBodyText      = collectBodyText
        self.oldTestamentTitle    = oldTestamentTitle
        self.oldTestamentBodyText = oldTestamentBodyText
        self.psalmTitle           = psalmTitle
        self.psalmSubtitle        = psalmSubtitle
        self.psalmBodyText        = psalmBodyText
        self.epistleTitle         = epistleTitle
        self.epistleBodyText      = epistleBodyText
        self.gospelTitle          = gospelTitle
        self.gospelBodyText       = gospelBodyText
    }
}
