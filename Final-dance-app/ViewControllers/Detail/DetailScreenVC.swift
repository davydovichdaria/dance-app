import UIKit

class DetailScreenVC: UIViewController {
    
    private var detailScreenView: DetailScreenView {
        return self.view as! DetailScreenView
    }
    
    override func loadView() {
        self.view = DetailScreenView(frame: Screen.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}
