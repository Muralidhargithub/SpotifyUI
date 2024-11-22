import UIKit
import AVFoundation

class AudioPlayerView: UIView {
    
    // MARK: - UI Components
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "adele") // Replace with your default image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.text = "Chasing Pavements"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Adele"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .gray
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private var audioPlayer: AVAudioPlayer?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.cornerRadius = 10
        clipsToBounds = true
        setupViews()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(albumImageView)
        addSubview(trackLabel)
        addSubview(artistLabel)
        addSubview(playPauseButton)
        addSubview(progressSlider)
        
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            albumImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            albumImageView.heightAnchor.constraint(equalToConstant: 50),
            albumImageView.widthAnchor.constraint(equalToConstant: 50),
            
            trackLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            trackLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 10),
            trackLabel.trailingAnchor.constraint(lessThanOrEqualTo: playPauseButton.leadingAnchor, constant: -10),
            
            artistLabel.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 5),
            artistLabel.leadingAnchor.constraint(equalTo: trackLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: trackLabel.trailingAnchor),
            
            playPauseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 30),
            playPauseButton.heightAnchor.constraint(equalToConstant: 30),
            
            progressSlider.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10),
            progressSlider.leadingAnchor.constraint(equalTo: trackLabel.leadingAnchor),
            progressSlider.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -10),
            progressSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configure Actions
    private func configureActions() {
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    @objc private func playPauseTapped() {
        if audioPlayer == nil {
            guard let soundURL = Bundle.main.url(forResource: "sample", withExtension: "mp3") else { return }
            audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        }
        
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
                playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            } else {
                player.play()
                playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
}
