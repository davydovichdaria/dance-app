import UIKit

class EmptyView: UIView {
    
    var onScheduleButtonTapped: (()->())?
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var scheduleButton: UIButton!
    
    
    @IBAction func scheduleButtonAction(_ sender: Any) {
        onScheduleButtonTapped?()
    }
    
}
