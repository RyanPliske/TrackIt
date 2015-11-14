import UIKit

protocol TRStatsViewDelegate : class {
    var recordedDays: TRRecordedDays { get }
    var itemIndex: Int { get }
}

class TRStatsView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TRCalendarCollectionViewCellDelegate  {
    
    weak var delegate: TRStatsViewDelegate!
    @IBOutlet weak var collectionView: UICollectionView!
    let pageControl = UIPageControl()
    var trackingDate: NSDate!
    
    init(frame: CGRect, trackingDate: NSDate, delegate: TRStatsViewDelegate) {
        self.trackingDate = trackingDate
        self.delegate = delegate
        super.init(frame: frame)
        
        let newView = NSBundle.mainBundle().loadNibNamed("TRStatsView", owner: self, options: nil).first as! UIView
        newView.frame = bounds
        newView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        newView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newView)
        
        collectionView.registerClass(TRCalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarViewCell")
        collectionView.registerNib(UINib(nibName: "TRGraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphViewCell")
        addSubview(collectionView)
        
        pageControl.numberOfPages = self.numberOfPages
        pageControl.hidesForSinglePage = true
        pageControl.userInteractionEnabled = false
        addSubview(pageControl)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentSize = CGSize(width: CGRectGetWidth(self.bounds), height: CGRectGetHeight(self.bounds))
        collectionView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height)
        let pageControlSize = CGSize(width: contentSize.width * 0.3, height: contentSize.height * 0.1)
        pageControl.frame = CGRectMake(CGRectGetMidX(self.bounds) - pageControlSize.width / 2.0, contentSize.height - pageControlSize.height, pageControlSize.width, pageControlSize.height)
    }
    
    var recordedDays: TRRecordedDays {
        return delegate.recordedDays
    }
    
    var numberOfPages: Int {
        let item = TRItemsModel.sharedInstanceOfItemsModel.activeItems[delegate.itemIndex]
        if let _ = item.dailyGoal {
            return 2
        }
        return 1
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GraphViewCell", forIndexPath: indexPath) as! TRGraphCollectionViewCell
            cell.setStartColor(TRColorGenerator.colorFor(delegate.itemIndex))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarViewCell", forIndexPath: indexPath) as! TRCalendarCollectionViewCell
            cell.delegate = self
            cell.setupWith(trackingDate)
            return cell
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        pageControl.currentPage = Int(collectionView.contentOffset.x / CGRectGetWidth(collectionView.frame))
    }
    
}
