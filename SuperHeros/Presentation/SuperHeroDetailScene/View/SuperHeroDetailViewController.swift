import UIKit

class SuperHeroDetailViewController: UIViewController {
    
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var characterName: UILabel!
    @IBOutlet weak private var characterDescription: UITextView!
    @IBOutlet weak private var visualEffectView: UIVisualEffectView!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    
    var viewModel: SuperHeroDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    private func initialSetup() {
        viewModel?.loadData()
        if let viewModel = viewModel {
            bind(to: viewModel)
        }
    }
    private func bind(to viewModel: SuperHeroDetailViewModel) {
        viewModel.navigationTitle.observe(on: self) { [weak self] _ in
            self?.updateNavigationTitle()
        }
        viewModel.superHeroModel?.observe(on: self, observerBlock: { [weak self] model in
            self?.characterImageView.setPosterImageWith(url: model.characterImage, imageExtension: model.characterPosterExtension)
            self?.backgroundImageView.setPosterPortrraitImageWith(url: model.characterImage, imageExtension: model.characterPosterExtension)
            self?.characterName.text = model.characterName
            self?.characterDescription.text = model.characterDescription
        })
    }
    private func updateNavigationTitle() {
        navigationItem.title = viewModel?.navigationTitle.value
    }
    
}

extension SuperHeroDetailViewController: Alertable {
    private func showAlertMessage(error: Error) {
        self.showAlert(title: viewModel?.errorTitle ?? "", message: error.localizedDescription, preferredStyle: .alert, completion: nil)
    }
}
