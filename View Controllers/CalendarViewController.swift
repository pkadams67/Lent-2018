//  See LICENSE folder for this project’s licensing information.

import UIKit
import Crashlytics

class CalendarViewController: UIViewController, CalendarViewDelegate {
    
    var firstRun: Bool = true
    var easterDay      = Foundation.Date()
    
    @IBOutlet var placeholderView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    //    @IBAction func crashButtonTapped(sender: AnyObject) {
    //        Crashlytics.sharedInstance().crash()
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Answers.logCustomEvent(withName: "Viewed Calendar", customAttributes: nil)
        let date                                               = Foundation.Date()
        let calendarView                                       = CalendarView.instance(date, selectedDate: date)
        calendarView.delegate                                  = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(calendarView)
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[calendarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[calendarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
        let currentYear: Int                                   = (Calendar.current as NSCalendar).components(.year, from: Foundation.Date()).year!
        easterDay                                              = Foundation.Date.date(1, month: 4, year: currentYear)
        // Force a Crash (disable for release)
        //        let button = UIButton(type: UIButtonType.RoundedRect)
        //        button.frame = CGRectMake(20, 50, 100, 30)
        //        button.setTitle("Crash", forState: UIControlState.Normal)
        //        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        //        view.addSubview(button)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CalendarViewController.updateCountdown), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func updateCountdown() {
        let calendar   = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: Foundation.Date(), to: easterDay, options: [])
        if components.day == 0 {
            countdownLabel.text = "Happy Easter!"
        } else if components.day! < 0 {
            countdownLabel.text = "\(366 + components.day!) days until Easter"
        } else {
            countdownLabel.text = "\(1 + components.day!) days until Easter"
        }
    }
    
    func didSelectDate(_ date: Foundation.Date) {
        let today     = Foundation.Date()
        let todayDate = Foundation.Date.date(today.day, month: today.month, year: today.year)
        if date.month == todayDate.month && date.day == todayDate.day {
            if firstRun == true {
                firstRun = false
                return
            }
        }
        if date.year == 2018 && date.month == 2 && date.day > 13 {
            performSegue(withIdentifier: "calendarToLectionary", sender: date)
        } else if date.year == 2018 && date.month == 4 && date.day < 2 {
            performSegue(withIdentifier: "calendarToLectionary", sender: date)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calendarToLectionary" {
            if let selectedDate = sender {
                if let detailViewController = segue.destination as? LectionaryViewController {
                    _        = detailViewController.view
                    let date = selectedDate as! Foundation.Date
                    if date.year == 2018 && date.month == 2 && date.day > 13 {
                        let reading = LectionaryController.readings[date.day - 1]
                        detailViewController.updateWithReading(reading)
                    } else if date.year == 2018 && date.month == 4 && date.day < 2 {
                        let reading = LectionaryController.readings[date.day + 30]
                        detailViewController.updateWithReading(reading)
                    }
                }
            }
        }
    }
}
