cask 'lx-music-desktop' do
  version '1.1.1'
  sha256 "7de1b2d6469e799923a9c0643e67d9f62246dd5a5fd93c3dce7735d960b5a349"

  url "https://github.com/lyswhut/lx-music-desktop/releases/download/v#{version}/lx-music-desktop-#{version}.dmg",
      user_agent: :fake
  homepage 'https://github.com/lyswhut/lx-music-desktop'

  auto_updates false

  app 'lx-music-desktop.app'
end
