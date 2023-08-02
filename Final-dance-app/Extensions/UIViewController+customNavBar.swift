import UIKit
import CalendarKit

extension UIViewController {
    
    func createCustomNavigationBar()  {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .gray.withAlphaComponent(0.5)
        navigationBarAppearance.backgroundColor = .white
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
    }
    
    func createCustomTitleView(image: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 42)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
//        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.frame = CGRect(x: (view.frame.width / 2 - 35), y: 0, width: 70, height: 34)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = #colorLiteral(red: 0.5776615739, green: 0.5480127931, blue: 0.9523189664, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}

