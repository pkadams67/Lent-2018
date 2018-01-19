//  See LICENSE folder for this project’s licensing information.

import UIKit

class DayCollectionCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!    
    @IBOutlet var markedView: UIView!
    @IBOutlet var markedViewWidth: NSLayoutConstraint!
    @IBOutlet var markedViewHeight: NSLayoutConstraint!

    var date: Date? {
        didSet {
            if date != nil {
                label.text = "\(date!.day)"
            } else {
                label.text = ""
            }
        }
    }
    
    var disabled: Bool = false {
        didSet {
            if disabled {
                alpha = 0.25
            } else {
                alpha = 1
            }
        }
    }
    
    var mark: Bool = false {
        didSet {
            if mark {
                markedView!.isHidden = false
            } else {
                markedView!.isHidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        markedViewWidth!.constant = min(self.frame.width, self.frame.height)
        markedViewHeight!.constant = min(self.frame.width, self.frame.height)
        markedView!.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2.0
    }
}
