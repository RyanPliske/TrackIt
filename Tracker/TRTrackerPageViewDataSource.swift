import Foundation

class TRTrackerPageViewDataSource: NSObject, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController is TRCalendarViewController {
            return viewControllerAtIndex(1)
        }
        return viewControllerAtIndex(0)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController is TRCalendarViewController {
            return viewControllerAtIndex(1)
        }
        return viewControllerAtIndex(0)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        switch (index) {
        case 0:
            return TRCalendarViewController()
        case 1:
            return TRStatsGraphViewController()
        default:
            return nil
        }
    }
    
}