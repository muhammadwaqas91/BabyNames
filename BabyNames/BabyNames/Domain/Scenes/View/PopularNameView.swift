import UIKit

protocol PopularNameViewDelegate: AnyObject {
    func filterBy(gender: Gender)
}

class PopularNameView: NibLoadableView, NibLoadable {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    @IBOutlet var femaleButton: UIButton!
    @IBOutlet var maleButton: UIButton!
    
    weak var delegate: PopularNameViewDelegate?
    
    override func defaultSetup() {
        super.defaultSetup()
        setupFromNib()
    }
    
    @IBAction func fetchPopular(_ sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
        if sender == maleButton {
            maleButton.isSelected = true
            delegate?.filterBy(gender: .male)
        }
        else if sender == femaleButton {
            femaleButton.isSelected = true
            delegate?.filterBy(gender: .female)
        }
    }
}
