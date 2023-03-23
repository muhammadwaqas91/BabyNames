import UIKit

class NibLoadableView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultSetup()
    }
    
    func defaultSetup() {
        print("__FUNCTION__ \(#function) called for \(self)")
    }
}
