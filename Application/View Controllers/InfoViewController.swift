//  See LICENSE folder for this project’s licensing information.

import UIKit
import SafariServices
import Crashlytics

class InfoViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logCustomEvent(withName: "Viewed About", customAttributes: nil)
        let appBuildString   = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        let appVersionString = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        versionLabel.text    = "Version \(appVersionString ?? "2018") (Build \(appBuildString ?? "1"))"
    }
    
    @IBAction func shareAppButtonTapped(_ sender: AnyObject) {
        Answers.logCustomEvent(withName: "Shared App", customAttributes: nil)
        print("Share App button tapped")
        let textToShare    = "“Lent 2018” is awesome! Download it on the App Store:"
        if let appStoreURL = URL(string: "https://itunes.apple.com/us/app/lent-2018/id1278677389") {
            let objectsToShare = [textToShare, appStoreURL] as [Any]
            let activityVC     = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = (sender as! UIView)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func developerURLButtonTapped(_ sender: Any) {
        print("\nDeveloper Website button tapped.\n")
        Answers.logCustomEvent(withName: "Developer Website button tapped", customAttributes: nil)
        let svc = SFSafariViewController(url: NSURL(string: "http://www.pkadams67.io")! as URL)
        self.present(svc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
