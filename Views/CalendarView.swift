//  See LICENSE folder for this project’s licensing information.

import UIKit

let kMonthRange = 12

class CalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, MonthCollectionCellDelegate {
    
    weak var delegate: CalendarViewDelegate?
    fileprivate var collectionData = [CalendarLogic]()
    
    var baseDate: Foundation.Date? {
        didSet {
            collectionData = [CalendarLogic]()
            if baseDate != nil {
                var dateIter1  = baseDate!, dateIter2 = baseDate!
                var set        = Set<CalendarLogic>()
                set.insert(CalendarLogic(date: baseDate!))
                // Advance one year
                for _ in 0 ..< kMonthRange {
                    dateIter1 = dateIter1.firstDayOfFollowingMonth
                    dateIter2 = dateIter2.firstDayOfPreviousMonth
                    set.insert(CalendarLogic(date: dateIter1))
                    set.insert(CalendarLogic(date: dateIter2))
                }
                collectionData = Array(set).sorted(by: <)
            }
            updateHeader()
            collectionView.reloadData()
        }
    }
    
    var selectedDate: Foundation.Date? {
        didSet {
            collectionView.reloadData()
            DispatchQueue.main.async{
                self.moveToSelectedDate(false)
                if self.delegate != nil {
                    self.delegate!.didSelectDate(self.selectedDate!)
                }
            }
        }
    }
    
    @IBOutlet var monthYearLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    @IBAction func retreatToPreviousMonth(_ button: UIButton) {
        advance(-1, animate: true)
    }
    
    @IBAction func advanceToFollowingMonth(_ button: UIButton) {
        advance(1, animate: true)
    }
    
    override func awakeFromNib() {
        let nib = UINib(nibName: "MonthCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MonthCollectionCell")
    }
    
    class func instance(_ baseDate: Foundation.Date, selectedDate: Foundation.Date) -> CalendarView {
        let calendarView          = Bundle.main.loadNibNamed("CalendarView", owner: nil, options: nil)!.first as! CalendarView
        calendarView.selectedDate = selectedDate
        calendarView.baseDate     = baseDate
        return calendarView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell              = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCollectionCell", for: indexPath) as! MonthCollectionCell
        cell.monthCellDelgate = self
        cell.logic            = collectionData[indexPath.item]
        if cell.logic!.isVisible(selectedDate!) {
            cell.selectedDate     = Date(date: selectedDate!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            updateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateHeader()
    }
    
    func updateHeader() {
        let pageNumber = Int(collectionView.contentOffset.x / collectionView.frame.width)
        updateHeader(pageNumber)
    }
    
    func updateHeader(_ pageNumber: Int) {
        if collectionData.count > pageNumber {
            let logic = collectionData[pageNumber]
            monthYearLabel.text = logic.currentMonthAndYear as String
        }
    }
    
    func advance(_ byIndex: Int, animate: Bool) {
        var visibleIndexPath = self.collectionView.indexPathsForVisibleItems.first as IndexPath!
        if ((visibleIndexPath?.item)! == 0 && byIndex == -1) ||
            (((visibleIndexPath?.item)! + 1) == collectionView.numberOfItems(inSection: 0) && byIndex == 1) {
            return
        }
        visibleIndexPath = IndexPath(item: (visibleIndexPath?.item)! + byIndex, section: (visibleIndexPath?.section)!)
        updateHeader((visibleIndexPath?.item)!)
        collectionView.scrollToItem(at: visibleIndexPath!, at: .centeredHorizontally, animated: animate)
    }
    
    func moveToSelectedDate(_ animated: Bool) {
        var index = -1
        for i in 0 ..< collectionData.count  {
            let logic = collectionData[i]
            if logic.containsDate(selectedDate!) {
                index = i
                break
            }
        }
        if index != -1 {
            let indexPath = IndexPath(item: index, section: 0)
            updateHeader(indexPath.item)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        }
    }
    
    func didSelect(_ date: Date) {
        selectedDate = date.nsdate
    }

}

protocol CalendarViewDelegate: class {
    func didSelectDate(_ date: Foundation.Date)
}
