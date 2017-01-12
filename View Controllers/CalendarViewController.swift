//
//  CalendarViewController.swift
//  Lent '17
//
//  Created by Paul Kirk Adams on 1/12/17.
//  Copyright © 2017 Paul Kirk Adams. All rights reserved.
//

import UIKit
import Crashlytics

class CalendarViewController: UIViewController, CalendarViewDelegate {

    var firstRun: Bool = true
    var christmasDay = Foundation.Date()

    @IBOutlet var placeholderView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!

//    @IBAction func crashButtonTapped(sender: AnyObject) {
//        Crashlytics.sharedInstance().crash()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Foundation.Date()
        let calendarView = CalendarView.instance(date, selectedDate: date)
        calendarView.delegate = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(calendarView)
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[calendarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
        placeholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[calendarView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["calendarView": calendarView]))
        let currentYear: Int = (Calendar.current as NSCalendar).components(.year, from: Foundation.Date()).year!
        christmasDay = Foundation.Date.date(25, month: 12, year: currentYear)
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

    func updateCountdown() {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: Foundation.Date(), to: christmasDay, options: [])
        if components.day == 0 {
            countdownLabel.text = "Merry Christmas!"
        } else if components.day! < 0 {
            countdownLabel.text = "\(366 + components.day!) days until the Nativity"
        } else {
            countdownLabel.text = "\(1 + components.day!) days until the Nativity"
        }
    }

    func didSelectDate(_ date: Foundation.Date) {
        let today = Foundation.Date()
        let todayDate = Foundation.Date.date(today.day, month: today.month, year: today.year)
        if date.month == todayDate.month && date.day == todayDate.day {
            if firstRun == true {
                firstRun = false
                return
            }
        }
        if date.year == 2016 && date.month == 11 && date.day > 26 {
            performSegue(withIdentifier: "calendarToLectionary", sender: date)
        } else if date.year == 2016 && date.month == 12 && date.day < 26 {
            performSegue(withIdentifier: "calendarToLectionary", sender: date)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calendarToLectionary" {
            if let selectedDate = sender {
                if let detailViewController = segue.destination as? LectionaryViewController {
                    _ = detailViewController.view
                    let date = selectedDate as! Foundation.Date
                    if date.year == 2016 && date.month == 11 && date.day > 26 {
                        let reading = LectionaryController.readings[date.day - 27]
                        detailViewController.updateWithReading(reading)
                    } else if date.year == 2016 && date.month == 12 && date.day < 26 {
                        let reading = LectionaryController.readings[date.day + 3]
                        detailViewController.updateWithReading(reading)
                    }
                }
            }
        }
    }
}
