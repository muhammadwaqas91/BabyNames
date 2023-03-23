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
    
    let vm = BabyNamesVM()
    
    override func defaultSetup() {
        super.defaultSetup()
        setupFromNib()
    }
    
    @IBAction func fetchPopular(_ sender: UIButton) {
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
        if sender == maleButton {
            maleButton.isSelected = true
            vm.gender = .male
        }
        else if sender == femaleButton {
            femaleButton.isSelected = true
            vm.gender = .female
        }
        
        guard let gender = vm.gender else {return}
        delegate?.filterBy(gender: gender)
    }
    
    func updateUI() {
        updateGenderUI()
        updatePopularBabyUI()
    }
    
    func updateGenderUI() {
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
        switch vm.gender {
            case .male:
                maleButton.isSelected = true
            case .female:
                femaleButton.isSelected = true
            default:
                break
        }
    }
    
    func updatePopularBabyUI() {
        guard let baby = vm.popularBaby?.baby else {return}
        
        nameLabel.text = baby.name
        
        let headingFont = UIFont.systemFont(ofSize: 18)
        let headingForegroundColor: UIColor = .black
        
        let descriptionFont = UIFont.systemFont(ofSize: 15)
        let descriptionForegroundColor: UIColor = .gray
        
        let headingAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: headingForegroundColor,
                                                                 .font: headingFont]
        
        let descriptionAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: descriptionForegroundColor,
                                                                     .font: descriptionFont]
        
        let mutableAttributedText = NSMutableAttributedString()
        
        
        mutableAttributedText.append(NSAttributedString(string: "Year:" + " ", attributes: headingAttributes))
        mutableAttributedText.append(NSAttributedString(string: "\(baby.birthYear)\n", attributes: descriptionAttributes))
        
        mutableAttributedText.append(NSAttributedString(string: "Ethnicity:" + " ", attributes: headingAttributes))
        mutableAttributedText.append(NSAttributedString(string: "\(baby.ethnicity)\n", attributes: descriptionAttributes))
        
        mutableAttributedText.append(NSAttributedString(string: "Babies:" + " ", attributes: headingAttributes))
        mutableAttributedText.append(NSAttributedString(string: "\(baby.noOfBabies)\n", attributes: descriptionAttributes))
        
        mutableAttributedText.append(NSAttributedString(string: "Rank:" + " ", attributes: headingAttributes))
        mutableAttributedText.append(NSAttributedString(string: "\(baby.rank)\n", attributes: descriptionAttributes))
        
        
        /// set paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        mutableAttributedText.addAttribute(NSAttributedString.Key.paragraphStyle,
                                           value:paragraphStyle,
                                           range:NSMakeRange(0, mutableAttributedText.length))
        
        detailsLabel.attributedText = mutableAttributedText
    }
}
