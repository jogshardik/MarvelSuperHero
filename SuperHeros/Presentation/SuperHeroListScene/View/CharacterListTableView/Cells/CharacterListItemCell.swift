import UIKit

class CharacterListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CharacterListItemCell.self)
    static let height = CGFloat(100)
    
    @IBOutlet weak private var characterName: UILabel!
    @IBOutlet weak private var characterDescription: UILabel!
    @IBOutlet weak private var characterImage: UIImageView!
    
    private var viewModel: CharacterListItemViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fill(with viewModel: CharacterListItemViewModel) {
        self.viewModel = viewModel
        characterName.text = viewModel.title
        characterDescription.text = viewModel.overview
        if let imagePath = viewModel.posterImagePath, let imageExtension = viewModel.imageExtension {
            characterImage.setThumbnailImageWith(url: imagePath, imageExtension: imageExtension)
        }
    }
}
