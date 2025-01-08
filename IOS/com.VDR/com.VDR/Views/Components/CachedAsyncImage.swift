import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }
    
    private func loadImage() async {
        guard let url = url else { return }
        
        let urlString = url.absoluteString
        
        // Check cache first
        if let cachedImage = ImageCache.shared.get(forKey: urlString) {
            image = cachedImage
            return
        }
        
        // If not in cache, load from network
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let downloadedImage = UIImage(data: data) {
                // Store in cache
                ImageCache.shared.set(downloadedImage, forKey: urlString)
                image = downloadedImage
            }
        } catch {
            Logger.log("Failed to load image: \(error)", level: .error)
        }
    }
} 