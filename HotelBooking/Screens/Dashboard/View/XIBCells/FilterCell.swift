import UIKit

class FilterCell: UITableViewCell {
    let checkboxImageView = UIImageView()
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkboxImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            checkboxImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            checkboxImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxImageView.widthAnchor.constraint(equalToConstant: 24),
            checkboxImageView.heightAnchor.constraint(equalToConstant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: checkboxImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with title: String, isSelected: Bool) {
        titleLabel.text = title
        checkboxImageView.image = UIImage(systemName: isSelected ? "checkmark.square" : "square")
        checkboxImageView.tintColor = .lightGray
    }
}
