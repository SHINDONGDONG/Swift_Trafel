//
//  OnboardingViewController.swift
//  Swift_Trafel
//
//  Created by 申民鐡 on 2022/07/04.
//

import UIKit

protocol OnboardingViewControllerDelegate:AnyObject {
    func showMainTabBarController()
}

class OnboardingViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        showCaption(atIndex: index)
        self.pageController.currentPage = index
    }
    

    // MARK: - Configures
    private func configures() {
        setupViews()
        setupCollectionView()
        showCaption(atIndex: 0)
        setupPageControl()
    }
    private func setupPageControl() {
        pageController.numberOfPages = Slide.collection.count
    }
    
    private func showCaption(atIndex index: Int) {
        let slide = Slide.collection[index]
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    
    private func setupViews() {
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layout
    }

    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segue.showLoginSignUp, sender: nil)
    }
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! OnboardingCollectionViewCell
        let imageName = Slide.collection[indexPath.item].imageName
        let image = UIImage(named: imageName) ?? UIImage()
        cell.configure(image: image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.showLoginSignUp {
            if let destination = segue.destination as? LoginViewController {
                destination.delegate = self
            }
        }
    }
}

extension OnboardingViewController:OnboardingViewControllerDelegate {
    func showMainTabBarController() {
        
        if let loginViewController = self.presentedViewController as? LoginViewController {
            loginViewController.dismiss(animated: true)
            PresenterManager.shared.show(vc: .mainTabBarController)
        }
    }
}
