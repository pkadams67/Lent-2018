//  See LICENSE folder for this project’s licensing information.

import UIKit
import SafariServices

class SafariHandling {

    static func presentSafariVC(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        let window   = UIApplication.shared.windows[0]
        window.rootViewController?.present(safariVC, animated: true, completion: nil)
    }
}
