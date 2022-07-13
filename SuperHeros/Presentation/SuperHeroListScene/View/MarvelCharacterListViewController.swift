import UIKit

class MarvelCharacterListViewController: UIViewController {
    
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var characterListContainerView: UIView!
    
    var viewModel: CharacterListViewModel?
    private var characterListTableViewController: CharacterListTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstant.MarvelCharacterListViewController.characterListTableViewController {
            if let destination = segue.destination as? CharacterListTableViewController {
                self.characterListTableViewController = destination
                if let viewModel = viewModel {
                    self.characterListTableViewController?.viewModel = viewModel
                    self.bind(to: viewModel)
                }
            }
        }
    }
}
// MARK: Private Methods
extension MarvelCharacterListViewController {
    
    private func bind(to viewModel: CharacterListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.navigationTitle.observe(on: self) { [weak self] _ in self?.updateNavigationTitle() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateNavigationTitle() {
        navigationItem.title = viewModel?.navigationTitle.value
    }
    
    private func updateItems() {
        characterListTableViewController?.reload()
    }
    
    // MARK: Navigations to other view
}
// MARK: Alertable
extension MarvelCharacterListViewController: Alertable {
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel?.errorTitle ?? "", message: error)
    }
}
