import UIKit

class ViewController: UIViewController {
    
    // Horizontal scroll view for buttons (K, All, Music, etc.)
    let buttonScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    // Vertical scroll view for grid buttons (Trending, Top Hits, etc.)
    private let verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupHorizontalScrollView()
        setupVerticalScrollView()
        addHorizontalButtons()
        addGridButtons()
        addLabelBelowScrollView()
        setupHorizontalScrollWithTextSection()
        addArtistsLabelAndSection()
        setupAudioPlayerView()

    }
    
    // MARK: - Horizontal Button Setup
    func setupHorizontalScrollView() {
        view.addSubview(buttonScrollView)
        buttonScrollView.addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonScrollView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: buttonScrollView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: buttonScrollView.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: buttonScrollView.bottomAnchor)
        ])
    }
    
    func addHorizontalButtons() {
        let buttonTitles = ["K", "All", "Music", "Podcasts", "Audiobooks", "Stories", "Ebooks"]
        for (index, title) in buttonTitles.enumerated() {
            let button = createHorizontalButton(withTitle: title)
            if index == 0 {
                button.backgroundColor = .systemGreen
                button.setTitleColor(.white, for: .normal)
                // Add shadow for first button
                button.layer.shadowColor = UIColor.green.cgColor
                button.layer.shadowOffset = CGSize(width: 5, height: 0)
                button.layer.shadowOpacity = 0.5
                button.layer.shadowRadius = 4
            }
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    func createHorizontalButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 15
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }
    
    // MARK: - Vertical Grid Setup
    func setupVerticalScrollView() {
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(verticalStackView)
        
        verticalScrollView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: buttonScrollView.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -510) // Adjusted to leave space for label
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
            verticalStackView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor)
        ])
    }
    
    func addGridButtons() {
        let buttonData = [
            ("Trending Now", "trendingnow (1)"),
            ("Top Hits", "chillsongs"),
            ("Chill Vibes", "chillvibes"),
            ("Workout", "workout")
        ]
        
        // Add buttons in rows (2 per row)
        var currentRowStackView: UIStackView?
        for (index, data) in buttonData.enumerated() {
            if index % 2 == 0 { // Start a new row for every 2 buttons
                currentRowStackView = createHorizontalStackView()
                verticalStackView.addArrangedSubview(currentRowStackView!)
            }
            let button = createGridButton(title: data.0, imageName: data.1)
            currentRowStackView?.addArrangedSubview(button)
        }
    }
    
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    func createGridButton(title: String, imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        
        // Use UIButton Configuration (iOS 15+)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .darkGray // Set button background
        config.baseForegroundColor = .white    // Set text and image color
        
        // Add title
        config.title = title
        config.titleAlignment = .leading       // Align the title to the leading side
        config.titlePadding = 10
        let titleFont = UIFont.systemFont(ofSize: 14, weight: .bold)
        config.attributedTitle = AttributedString(config.title!, attributes: AttributeContainer([.font: titleFont]))
        // Add image
        if let image = UIImage(named: imageName) {
            config.image = image
        }
        config.imagePlacement = .leading      // Place image on the leading side
        config.imagePadding = 10               // Space between image and text
        
        button.configuration = config
        
        // Constrain button size
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 80), // Fixed button height
            button.widthAnchor.constraint(equalToConstant: 200)  // Fixed button width
        ])
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        
        return button
    }

    func addLabelBelowScrollView() {
        let label = UILabel()
        label.text = "Try Something else"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: verticalScrollView.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
}

extension ViewController {
    func setupHorizontalScrollWithTextSection() {
        // Add the scroll view and stack view
        view.addSubview(horizontalScrollView)
        horizontalScrollView.addSubview(horizontalStackView)
        
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Scroll view constraints
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: verticalScrollView.bottomAnchor, constant: 50),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Stack view constraints
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            horizontalStackView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor)
        ])
        
        // Add the buttons with text
        addHorizontalButtonsWithText()
        func addHorizontalButtonsWithText() {
            // Sample data
            let buttonData = [
                ("traditional (1)", "Traditional", "Classic and timeless styles"),
                ("modern", "Modern", "Contemporary and chic designs"),
                ("intage", "Vintage", "Elegant and nostalgic appeal"),
                ("Gym", "Gym", "Comfortable and casual wear"),
                ("sporty", "Party", "party wear")

            ]
            
            for data in buttonData {
                let buttonView = createButtonWithImageAndText(imageName: data.0, title: data.1, description: data.2)
                horizontalStackView.addArrangedSubview(buttonView)
            }
        }
        
        func createButtonWithImageAndText(imageName: String, title: String, description: String) -> UIView {
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            // Image
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            // Title Label
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = .white
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.textAlignment = .center
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Description Label
            let descriptionLabel = UILabel()
            descriptionLabel.text = description
            descriptionLabel.textColor = .lightGray
            descriptionLabel.font = UIFont.systemFont(ofSize: 12)
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 2
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // Add components to the container
            containerView.addSubview(imageView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(descriptionLabel)
            
            // Constraints for the image
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
                imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 80),
                imageView.widthAnchor.constraint(equalToConstant: 80)
            ])
            
            // Constraints for the title label
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5)
            ])
            
            // Constraints for the description label
            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
                descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
            ])
            
            return containerView
        }
    }
}



extension ViewController {
    
    // Define the second horizontal scroll view
    private var secondHorizontalScrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    // Define the stack view for the second horizontal section
    private var secondHorizontalStackView: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }
    
    func addArtistsLabelAndSection() {
        // Add "Artists You Like" label
        let artistsLabel = UILabel()
        artistsLabel.text = "Artists You Like"
        artistsLabel.textColor = .white
        artistsLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        artistsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistsLabel)
        
        NSLayoutConstraint.activate([
            artistsLabel.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 20),
            artistsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            artistsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        // Create and configure the horizontal scroll view
        let horizontalScrollView = secondHorizontalScrollView
        let horizontalStackView = secondHorizontalStackView
        
        view.addSubview(horizontalScrollView)
        horizontalScrollView.addSubview(horizontalStackView)
        
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: artistsLabel.bottomAnchor, constant: 10),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor)
        ])
        
        // Add buttons to the horizontal section
        addHorizontalButtonsToSecondSection(to: horizontalStackView)
    }
    
    private func addHorizontalButtonsToSecondSection(to stackView: UIStackView) {
        let artistData = [
            ("taylor", "Taylor Swift", "Pop sensation and icon"),
            ("ed", "Ed Sheeran", "Singer-songwriter extraordinaire"),
            ("adele", "Adele", "Soulful and powerful ballads"),
            ("drake", "Drake", "Hip-hop and R&B maestro")
        ]
        
        for data in artistData {
            let buttonView = createButtonWithImageAndText(imageName: data.0, title: data.1, description: data.2)
            stackView.addArrangedSubview(buttonView)
        }
    }
    
    private func createButtonWithImageAndText(imageName: String, title: String, description: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        // Image
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description Label
        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add components to the container
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
        return containerView
    }
}


extension ViewController {
    func setupAudioPlayerView() {
        let audioPlayerView = AudioPlayerView()
        view.addSubview(audioPlayerView)
        audioPlayerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            audioPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            audioPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            audioPlayerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            audioPlayerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
