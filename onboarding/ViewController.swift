import UIKit
import CHIPageControl

class ViewController: UIViewController, UIScrollViewDelegate {

    lazy var scrollView : UIScrollView! = {
       let scrollView = UIScrollView()
       scrollView.isPagingEnabled = true
       scrollView.showsHorizontalScrollIndicator = false
       scrollView.delegate = self
       scrollView.translatesAutoresizingMaskIntoConstraints = false
       return scrollView
   }()
    
    lazy var pageControl : CHIPageControlJalapeno! = {
        var pageControl = CHIPageControlJalapeno()
        pageControl.numberOfPages = images.count
        pageControl.currentPageTintColor = UIColor(red: 0.745, green: 0.2039, blue: 0.3333, alpha: 1)
        pageControl.tintColor = .systemGray4
        pageControl.padding = 10
        pageControl.radius = 5
        pageControl.progress = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }() // PageControl animasyonları için üçünü parti kütüphane
    
    lazy var continueButton : UIButton! = {
        let continueButton = UIButton()
        continueButton.setTitle("Devam Et", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.backgroundColor = UIColor(red: 0.745, green: 0.2039, blue: 0.3333, alpha: 1)
        continueButton.layer.cornerCurve = .circular
        continueButton.layer.cornerRadius = 10
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return continueButton
    }()
    
    var skipButton : UIButton! = {
        let skipButton = UIButton()
        skipButton.setTitle("Atla", for: .normal)
        skipButton.setTitleColor(.black, for: .normal)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addTarget(ViewController.self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return skipButton
    }()
    
    var logoImageView : UIImageView! = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(systemName: "playstation.logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()

    let images = ["image11", "image22", "image33"]
    let texts = ["Bu birinci sayfanın yazısı - Bu birinci sayfanın yazısı - Bu birinci sayfanın yazısı - Bu birinci sayfanın yazısı - Bu birinci sayfanın yazısı",
                 "Bu ikinci sayfanın yazısı - Bu ikinci sayfanın yazısı - Bu ikinci sayfanın yazısı - Bu ikinci sayfanın yazısı - Bu ikinci sayfanın yazısı",
                 "Bu üçüncü sayfanın yazısı - Bu üçüncü sayfanın yazısı - Bu üçüncü sayfanın yazısı - Bu üçüncü sayfanın yazısı - Bu üçüncü sayfanın yazısı"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoImageView)
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(continueButton)
        view.addSubview(skipButton)
        setupConstraints()
    }

    func setupConstraints() {
        
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10).isActive = true
        // Scrollview genişliği = fotoğraf sayısı * ekran genişliği. Buraya da yine ekran genişliği aralıklarla fotoğraflar yerleşecek
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: images[i])
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(imageView)
            
            // Her bir image, bir frame.width boşluklarla yerleşiyor böylece yatayda kaydırabiliyoruz
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(i) * view.frame.width).isActive = true
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.8).isActive = true
            
            let label = UILabel()
            label.text = texts[i]
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(label)
            
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            label.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.2).isActive = true
            
            if i == images.count - 1 {
                label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            }
        }
        
        pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -15).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -20).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 340).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Kaydırma yapılırken sürekli olarak mevcut konumu sayfa genişliğine bölerek mevcut indexi bul (pagecontrolde gösterilecek)
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.set(progress: Int(pageIndex), animated: true)
        if pageControl.currentPage == images.count - 1 {
            continueButton.setTitle("Bitir", for: .normal)
        } else { // Sona gelinince buton bitir olmalı
            continueButton.setTitle("Devam Et", for: .normal)
        }
    }

    @objc func continueButtonTapped() {
        let nextPage = pageControl.currentPage + 1
        if nextPage < images.count {
            let offset = CGPoint(x: view.frame.width * CGFloat(nextPage), y: 0)
            scrollView.setContentOffset(offset, animated: true)
        } else {
            performSegue(withIdentifier: "mysegue", sender: nil) // Gerçek uygulamada login storyboard'una gidebilir
        }
    }

    @objc func skipButtonTapped() {
        performSegue(withIdentifier: "mysegue", sender: nil) // Gerçek uygulamada login storyboard'una gidebilir
    }
}
