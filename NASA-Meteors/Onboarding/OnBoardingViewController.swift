import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {
    
    let onBoardCenterImages = ["ic_onboarding_1", "ic_onboarding_2", "ic_onboarding_3", "ic_onboarding_4"]
    
    let onBoardSlideMainTitles = ["NASA-Meteors Forum", "Space Launchs", "Space Stories", "Astranaut's experience"]
    
    let onBoardSlideSubTitles = ["Share knowledge about Meteor's landings", "Anytime access to NASA-Meteors’s library", "Lessons to tracking technology", "Analysis to focus on weaknesses & course strategy"]


    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var slides:[OnBoardSlide] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        self.scrollView.contentSize.height = 1.0 // disable vertical scroll
        decorateUIwithTheme()
        
        
    }
    func decorateUIwithTheme(){
       // scrollView.backgroundColor = UIColor.appHeaderColor()
      //  headerView.backgroundColor = UIColor.appHeaderColor()
      //  let appThemeColor = UIColor.appHeaderColor()
       // pageControl.pageIndicatorTintColor = appThemeColor.darker(by: 30.0)
        pageControl.currentPageIndicatorTintColor = UIColor.white
     //   helpButton.setTitleColor(UIColor.appHeaderTextColor(), for: .normal)
        //loginButton.setTitleColor(UIColor.appHeaderTextColor(), for: .normal)
        let boardGif = UIImage.gifImageWithName("meteor")
        backgroundImage.image = boardGif
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func createSlides() -> [OnBoardSlide] {

        let slide1:OnBoardSlide = Bundle.main.loadNibNamed("OnBoardSlide", owner: self, options: nil)?.first as! OnBoardSlide
        slide1.slideCenterImageView.image = UIImage(named: onBoardCenterImages[0])
        slide1.slideMainTitle.text = onBoardSlideMainTitles[0]
        slide1.slideSubtitle.text = onBoardSlideSubTitles[0]
        
        let slide2:OnBoardSlide = Bundle.main.loadNibNamed("OnBoardSlide", owner: self, options: nil)?.first as! OnBoardSlide
        slide2.slideCenterImageView.image = UIImage(named: onBoardCenterImages[1])
        slide2.slideMainTitle.text = onBoardSlideMainTitles[1]
        slide2.slideSubtitle.text = onBoardSlideSubTitles[1]
        
        let slide3:OnBoardSlide = Bundle.main.loadNibNamed("OnBoardSlide", owner: self, options: nil)?.first as! OnBoardSlide
        slide3.slideCenterImageView.image = UIImage(named: onBoardCenterImages[2])
        slide3.slideMainTitle.text = onBoardSlideMainTitles[2]
        slide3.slideSubtitle.text = onBoardSlideSubTitles[2]
        
        let slide4:OnBoardSlide = Bundle.main.loadNibNamed("OnBoardSlide", owner: self, options: nil)?.first as! OnBoardSlide
        slide4.slideCenterImageView.image = UIImage(named: onBoardCenterImages[3])
        slide4.slideMainTitle.text = onBoardSlideMainTitles[3]
        slide4.slideSubtitle.text = onBoardSlideSubTitles[3]
        
        return [slide1, slide2, slide3, slide4]
    }
    
    
    func setupSlideScrollView(slides : [OnBoardSlide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
 
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
           
        }
    }
    
    
    @IBAction func getStartedAction(_ sender: Any) {
        let mainVC = UIStoryboard.MainVC();
        self.navigationController?.pushViewController(mainVC!, animated: true)
     }
    
    
  
}

