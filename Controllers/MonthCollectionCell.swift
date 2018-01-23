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

        let nib       = UINib(nibName: "DayCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "DayCollectionCell")

        let headerNib = UINib(nibName: "WeekHeaderView", bundle: nil)
        self.collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WeekHeaderView")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 7*6 = 42 :- 7 columns (7 days in a week) and 6 rows (max 6 weeks in a month)
        return dates.count//42
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionCell", for: indexPath) as! DayCollectionCell

        let date = dates[indexPath.item]

        // Lent Cells Coloring
        if date.year == 2017 && date.month == 3 && date.day > 0 {
            cell.backgroundColor = UIColor(red: 0.941, green: 0.82, blue: 0.98, alpha: 1)
        } else if date.year == 2017 && date.month == 4 && date.day < 16 {
                 cell.backgroundColor = UIColor(red: 0.941, green: 0.82, blue: 0.98, alpha: 1)
        } else if date.year == 2017 && date.month == 4 && date.day == 16 {
                cell.backgroundColor = UIColor(red: 0.831, green: 0.686, blue: 0.216, alpha: 1) // Hex d4af37 #colorLiteral(red: 0.8660482764, green: 0.7336418033, blue: 0.274929136, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
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
