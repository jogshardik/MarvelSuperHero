import UIKit

class CharacterListTableViewController: UITableViewController {
    
    var viewModel: CharacterListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        initializePullToRefresh()
    }
    
    private func initializePullToRefresh() {
        self.refreshControl?.tintColor = UIColor.magenta
        self.refreshControl?.addTarget(self, action: #selector(self.pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
        // Code to refresh table view
        viewModel?.pullToRefresh()
    }
    
    func reload() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

// MARK: - Table view data source
extension CharacterListTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.value.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListItemCell.reuseIdentifier,
                                                       for: indexPath) as? CharacterListItemCell,
              let viewModel = viewModel else {
            assertionFailure("Cannot dequeue reusable cell \(CharacterListItemCell.self) with reuseIdentifier: \(CharacterListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row])
        viewModel.didLoadNextPage(index: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectItem(at: indexPath.row)
    }
}
