
# Spotify Clone

This is a Spotify-inspired iOS application developed using **Swift** and **UIKit**. The application mimics some features of Spotify's user interface, including horizontal and vertical scrollable sections, buttons, labels, and an audio player.

## Features

- **Horizontal Scrollable Sections**
  - Categories: Buttons like "K", "All", "Music", "Podcasts", etc.
  - Artist Recommendations: Scrollable horizontal stack of artists with images, titles, and descriptions.
  
- **Vertical Scrollable Sections**
  - Grids of playlists with titles and thumbnail images.
  - A dynamic label for different sections, e.g., "Try Something Else", "Artists You Like".

- **Audio Player**
  - Mini audio player at the bottom with song details and playback controls.

## Technologies Used

- **Swift**: The primary programming language for the app.
- **UIKit**: Used to create and manage the user interface programmatically.
- **Auto Layout**: For creating responsive designs that adapt to different screen sizes.
- **UIImageView**: For displaying images.
- **UIScrollView**: For horizontal and vertical scrolling functionality.
- **UIStackView**: For organizing UI components horizontally and vertically.

## Project Structure

```
SpotifyClone/
│
├── ViewController.swift
│   Main file containing the core implementation of the UI components.
│
├── Extensions/
│   ├── HorizontalScrollExtensions.swift
│   ├── VerticalScrollExtensions.swift
│   ├── ArtistsSectionExtensions.swift
│   ├── AudioPlayerExtension.swift
│
├── Assets/
│   Contains images for playlists, artists, and categories used in the app.
│
├── README.md
│   This file, providing project details and usage instructions.
│
├── Info.plist
│   Metadata about the application.
│
└── Main.storyboard (Optional, if used alongside programmatic UI).
```

## Getting Started

### Prerequisites

- **Xcode 14 or later**.
- **iOS 15 or later**.
- A basic understanding of Swift and UIKit.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repository/spotify-clone.git
   ```
2. Open the project in Xcode:
   ```bash
   cd spotify-clone
   open SpotifyClone.xcodeproj
   ```
3. Build and run the app on a simulator or a physical device:
   - Select a target device (e.g., iPhone 14).
   - Press `Cmd + R` to run the app.

## Usage

### 1. Horizontal Buttons Section
- Scroll horizontally to view different categories like "Music", "Podcasts", etc.

### 2. Vertical Grid Section
- Displays grid buttons with playlist thumbnails and titles.

### 3. Artists Section
- Contains a horizontal scroll view of artist recommendations with images, titles, and descriptions.

### 4. Audio Player
- Mini player at the bottom allows basic song control.

## Screenshots

### Main Page
<img src="SpotifyUI/Simulator Screenshot - iPhone 16 Pro - 2024-11-22 at 02.35.47.png" alt="Main Screen" width="500">


## Customization

You can easily modify the following parts of the app:
- **Categories**: Update the button titles in the `addHorizontalButtons()` method.
- **Playlist Grids**: Modify the grid button data in the `addGridButtons()` method.
- **Artists Section**: Change artist details in the `addHorizontalButtonsToSecondSection()` method.
- **Audio Player**: Customize the mini-player design in the `AudioPlayerExtension`.

## Contributing

Contributions are welcome! Feel free to:
- Report bugs.
- Submit feature requests.
- Create pull requests with improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- Inspired by the Spotify app design.
- Icons and images are placeholders and must be replaced with royalty-free assets.
