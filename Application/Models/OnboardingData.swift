//  See LICENSE folder for this project’s licensing information.

import UIKit
import OnboardingKit

public final class OnboardingData: NSObject, OnboardingViewDelegate, OnboardingViewDataSource {
    
    public var didShow: ((Int) -> Void)?
    public var willShow: ((Int) -> Void)?
    
    public func numberOfPages() -> Int {
        return 5
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, configurationForPage page: Int) -> OnboardingConfiguration {
        switch page {
            
        case 0:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard0")!,
                itemImage: UIImage(named: "number1")!,
                pageTitle: "Prepare",
                pageDescription: "Early Christians observed a season of penitence and fasting in preparation for the Paschal feast, or Pascha. The season known now as Lent (from an Old English word meaning “spring,” the time of lengthening days) has a long history. Originally, in places where Pascha was celebrated on a Sunday, the Paschal feast followed a fast of up to two days.",
                backgroundImage: UIImage(named: "background0"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 1:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard1")!,
                itemImage: UIImage(named: "number2")!,
                pageTitle: "Reflect",
                pageDescription: "In the third century, this fast was lengthened to six days. Eventually, this fast overlapped another fast of forty days, in imitation of Christ’s fasting in the wilderness. The forty-day fast was especially important for converts to the faith who were preparing for baptism, and for those guilty of notorious sins who were being restored to the Christian assembly.",
                backgroundImage: UIImage(named: "background1"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 2:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard2")!,
                itemImage: UIImage(named: "number3")!,
                pageTitle: "Renew",
                pageDescription: "In the western church, the forty days of Lent extend from Ash Wednesday through Holy Saturday, omitting Sundays. The last three days of Lent are the sacred Triduum of Maundy Thursday, Good Friday, and Holy Saturday. Today Lent has reacquired its significance as the final preparation of adult candidates for baptism.",
                backgroundImage: UIImage(named: "background2"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 3:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard3")!,
                itemImage: UIImage(named: "number4")!,
                pageTitle: "Recommit",
                pageDescription: "Joining with them, all Christians are invited to the observance of a holy Lent, by self-examination and repentance; by prayer, fasting, and self-denial; and by reading and meditating on God’s holy Word.",
                backgroundImage: UIImage(named: "background3"),
                topBackgroundImage: nil,
                bottomBackgroundImage: UIImage(named: "backgroundWave")
            )
            
        case 4:
            return OnboardingConfiguration(
                image: UIImage(named: "onboard4")!,
                itemImage: UIImage(named: "number5")!,
                pageTitle: "Thanks!",
                pageDescription: "Your device will ask the next time this app loads whether to allow Push Notifications. Please tap “OK” to let us deliver a short message each day this Lenten season.",
                backgroundImage: UIImage(named: "background4"),
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
        pageView.titleLabel.font                     = UIFont(name: "HelveticaNeue-Bold", size: 36) ?? UIFont.boldSystemFont(ofSize: 36)
        pageView.descriptionLabel.font               = UIFont(name: "HelveticaNeue-Thin", size: 17) ?? UIFont.systemFont(ofSize: 17)
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
