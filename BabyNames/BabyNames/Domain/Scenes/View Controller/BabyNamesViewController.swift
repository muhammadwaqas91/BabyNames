import UIKit

protocol BabyNamesViewControllerDisplayLogic: AnyObject {
    func displayLoadedBabiesFromJSON(viewModel: LoadBabies.LoadData.ViewModel)
    func displayPopularBaby(viewModel: LoadBabies.LoadPopular.ViewModel)
}

class BabyNamesViewController: UIViewController {

    @IBOutlet var popularNameView: PopularNameView!
    
    var interactor: BabyInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureVIP()
        
        popularNameView.delegate = self
        loadBabiesFromJSON()
    }
    
    func configureVIP() {
        let interactor = BabyInteractor()
        let presenter = BabyPresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    func loadBabiesFromJSON() {
        interactor?.loadBabiesFromJSON(request: LoadBabies.LoadData.Request())
    }
}

extension BabyNamesViewController: PopularNameViewDelegate {
    func filterBy(gender: Gender) {
        interactor?.loadBaby(request: LoadBabies.LoadPopular.Request(gender: gender, babies: popularNameView.vm.babiesVM?.babies ?? []))
    }
    
    func updateUI() {
        guard let baby = popularNameView.vm.popularBaby?.baby else {return}
        
        popularNameView.nameLabel.text = baby.name
        
        
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
        
        popularNameView.detailsLabel.attributedText = mutableAttributedText
    }
}

extension BabyNamesViewController: BabyNamesViewControllerDisplayLogic {
    func displayLoadedBabiesFromJSON(viewModel: LoadBabies.LoadData.ViewModel) {
        popularNameView.vm.babiesVM = viewModel
    }
        
    func displayPopularBaby(viewModel: LoadBabies.LoadPopular.ViewModel) {
        popularNameView.vm.popularBaby = viewModel
        updateUI()
    }
}
