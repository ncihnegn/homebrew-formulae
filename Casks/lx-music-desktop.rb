cask 'lx-music-desktop' do
  version '1.2.0'
  sha256 "622d02b9ae1aec125618e7f43ee05e8bc20caedc88141418da9c929553c306b4"

  url "https://github.com/lyswhut/lx-music-desktop/releases/download/v#{version}/lx-music-desktop-#{version}.dmg",
      user_agent: :fake
  homepage 'https://github.com/lyswhut/lx-music-desktop'

  auto_updates false

  app 'lx-music-desktop.app'
end
