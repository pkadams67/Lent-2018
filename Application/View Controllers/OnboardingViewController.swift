//  See LICENSE folder for this project’s licensing information.

import UIKit
import Crashlytics
import OnboardingKit

public final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var beginButton: UIButton!
    
    private let model = OnboardingData()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logCustomEvent(withName: "Viewed Onboarding", customAttributes: nil)
        beginButton.alpha         = 0
        onboardingView.dataSource = model
        onboardingView.delegate   = model
        model.didShow             = { page in
            if page == 4 {
                UIView.animate(withDuration: 0.3) {
                    self.beginButton.alpha = 1
                }
            }
        }
        model.willShow = { page in
            if page != 4 {
                self.beginButton.alpha = 0
            }
        }
    }
    
    override public var prefersStatusBarHidden: Bool {
        return true
    }
}
