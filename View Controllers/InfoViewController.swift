//  See LICENSE folder for this project’s licensing information.

import UIKit
import Crashlytics

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logCustomEvent(withName: "Viewed About", customAttributes: nil)
    }
    
    @IBAction func shareAppButtonTapped(_ sender: AnyObject) {
        Answers.logCustomEvent(withName: "Shared App", customAttributes: nil)
        print("Share App Button Pushed")
        let textToShare    = "“Lent 2018” is awesome! Download it on the App Store:"
        if let appStoreURL = URL(string: "https://itunes.apple.com/us/app/lent-2018/id1278677389") {
            let objectsToShare                                   = [textToShare, appStoreURL] as [Any]
            let activityVC                                       = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = (sender as! UIView)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func developerURLButtonTapped(_ sender: AnyObject) {
        Answers.logCustomEvent(withName: "Visited Developer Website", customAttributes: nil)
        print("Developer URL Button Tapped")
        SafariHandling.presentSafariVC(URL(string: "http://www.pkadams67.io")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
