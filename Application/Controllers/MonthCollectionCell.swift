//  See LICENSE folder for this project’s licensing information.

import UIKit

protocol MonthCollectionCellDelegate: class {
    func didSelect(_ date: Date)
}

class MonthCollectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    weak var monthCellDelgate: MonthCollectionCellDelegate?
    
    var dates                          = [Date]()
    var previousMonthVisibleDatesCount = 0
    var currentMonthVisibleDatesCount  = 0
    var nextMonthVisibleDatesCount     = 0
    
    var lentDays: [Date]?
    
    var logic: CalendarLogic? {
        didSet {
            populateDates()
            if collectionView != nil {
                collectionView.reloadData()
            }
        }
    }
    
    var selectedDate: Date? {
        didSet {
            if collectionView != nil {
                collectionView.reloadData()
            }
        }
    }
    
    func populateDates() {
        if logic != nil {
            dates                          = [Date]()
            // lentDays = []
            dates                          += logic!.previousMonthVisibleDays!
            dates                          += logic!.currentMonthDays!
            dates                          += logic!.nextMonthVisibleDays!
            
            previousMonthVisibleDatesCount = logic!.previousMonthVisibleDays!.count
            currentMonthVisibleDatesCount  = logic!.currentMonthDays!.count
            nextMonthVisibleDatesCount     = logic!.nextMonthVisibleDays!.count
            
        } else {
            dates.removeAll(keepingCapacity: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "DayCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "DayCollectionCell")
        
        let headerNib = UINib(nibName: "WeekHeaderView", bundle: nil)
        self.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekHeaderView")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionCell", for: indexPath) as! DayCollectionCell
        
        let date = dates[indexPath.item]
        
        // Lent Cells Shading
        if date.year == 2018 && date.month == 2 && date.day < 14 {
            cell.backgroundColor = UIColor.white
            cell.label.textColor = UIColor(named: "PANTONE 17-3725 Bougainvillea")
        } else if date.year == 2018 && date.month == 2 && date.day > 13 {
            cell.backgroundColor = UIColor(named: "PANTONE 17-3725 Bougainvillea")
            cell.label.textColor = UIColor.white
        } else if date.year == 2018 && date.month == 3 && date.day > 0 {
            cell.backgroundColor = UIColor(named: "PANTONE 17-3725 Bougainvillea")
            cell.label.textColor = UIColor.white
        } else if date.year == 2018 && date.month == 4 && date.day == 1 {
            cell.backgroundColor = UIColor(named: "PANTONE 14-0955 Citrus")
            cell.label.textColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.white
            cell.label.textColor = UIColor(named: "PANTONE 17-3725 Bougainvillea")
        }
        cell.date = (indexPath.item < dates.count) ? date : nil
        cell.mark = (selectedDate == date)
        cell.disabled = (indexPath.item < previousMonthVisibleDatesCount) ||
            (indexPath.item >= previousMonthVisibleDatesCount
                + currentMonthVisibleDatesCount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if monthCellDelgate != nil {
            monthCellDelgate!.didSelect(dates[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekHeaderView", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 0.1) / 7.0, height: collectionView.frame.height / 7.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 7.0)
    }
}
