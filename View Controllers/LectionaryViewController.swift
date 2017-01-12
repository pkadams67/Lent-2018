//
//  LectionaryViewController.swift
//  Lent '17
//
//  Created by Paul Kirk Adams on 1/12/17.
//  Copyright © 2017 Paul Kirk Adams. All rights reserved.
//

import UIKit

class LectionaryViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var dayTitleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var collectBodyTextLabel: UILabel!
    @IBOutlet weak var oldTestamentTitleLabel: UILabel!
    @IBOutlet weak var oldTestamentBodyTextLabel: UILabel!
    @IBOutlet weak var psalmTitleLabel: UILabel!
    @IBOutlet weak var psalmSubtitleLabel: UILabel!
    @IBOutlet weak var psalmBodyTextLabel: UILabel!
    @IBOutlet weak var epistleTitleLabel: UILabel!
    @IBOutlet weak var epistleBodyTextLabel: UILabel!
    @IBOutlet weak var gospelTitleLabel: UILabel!
    @IBOutlet weak var gospelBodyTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateWithReading(_ lectionary: Lectionary) {
        self.title = nil
        dayTitleLabel.text = "\(lectionary.dayTitle)"
        dayLabel.text = "\(lectionary.day)"
        collectBodyTextLabel.text = "\(lectionary.collectBodyText)"
        oldTestamentTitleLabel.text = "\(lectionary.oldTestamentTitle)"
        oldTestamentBodyTextLabel.text = "\(lectionary.oldTestamentBodyText)"
        psalmTitleLabel.text = "\(lectionary.psalmTitle)"
        psalmSubtitleLabel.text = "\(lectionary.psalmSubtitle)"
        psalmBodyTextLabel.text = "\(lectionary.psalmBodyText)"
        epistleTitleLabel.text = "\(lectionary.epistleTitle)"
        epistleBodyTextLabel.text = "\(lectionary.epistleBodyText)"
        gospelTitleLabel.text = "\(lectionary.gospelTitle)"
        gospelBodyTextLabel.text = "\(lectionary.gospelBodyText)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
