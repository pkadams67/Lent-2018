//  See LICENSE folder for this project’s licensing information.

import UIKit
import OnboardingKit

public final class DataModel: NSObject, OnboardingViewDelegate, OnboardingViewDataSource {
    
    public var didShow: ((Int) -> Void)?
    public var willShow: ((Int) -> Void)?
    
    public func numberOfPages() -> Int {
        return 4
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, configurationForPage page: Int) -> OnboardingConfiguration {
        switch page {
            
        case 0:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard0")!,
                itemImage: UIImage(named: "number1")!,
                pageTitle: "Welcome!",
                pageDescription: "“Observe a blessed Lent this year by self-examination and repentance; by prayer, fasting, and self-denial; and by reading and meditating on God’s Holy Word.”",
                backgroundImage: UIImage(named: "background0"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 1:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard1")!,
                itemImage: UIImage(named: "number2")!,
                pageTitle: "Reflection",
                pageDescription: "Some words about reflection",
                backgroundImage: UIImage(named: "background1"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 2:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard2")!,
                itemImage: UIImage(named: "number3")!,
                pageTitle: "Preparation",
                pageDescription: "Some words about preparation",
                backgroundImage: UIImage(named: "background2"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 3:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard3")!,
                itemImage: UIImage(named: "number4")!,
                pageTitle: "Renewal",
                pageDescription: "Some words about renewal",
                backgroundImage: UIImage(named: "background3"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        default:
            fatalError("Out of range!")
        }
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, configurePageView pageView: PageView, atPage page: Int) {
        pageView.titleLabel.textColor                = UIColor.white
        pageView.titleLabel.layer.shadowOpacity      = 0.6
        pageView.titleLabel.layer.shadowColor        = UIColor.black.cgColor
        pageView.titleLabel.layer.shadowOffset       = CGSize(width: 0, height: 1)
        pageView.titleLabel.layer.shouldRasterize    = true
        pageView.titleLabel.layer.rasterizationScale = UIScreen.main.scale
        pageView.titleLabel.font                     = UIFont.boldSystemFont(ofSize: 30)
        pageView.descriptionLabel.font               = UIFont.systemFont(ofSize: 20)
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, didSelectPage page: Int) {
        print("Did select Page #\(page)")
        didShow?(page)
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, willSelectPage page: Int) {
        print("\nWill select Page #\(page)\n")
        willShow?(page)
    }
}
