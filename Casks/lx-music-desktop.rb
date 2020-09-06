cask 'lx-music-desktop' do
  version '1.0.1'
  sha256 "bdca5b36ac11e70cbdd55c58bc6bb4d51b472959bd198839fc9f504110559b5e"

  url "https://github.com/lyswhut/lx-music-desktop/releases/download/v#{version}/lx-music-desktop-#{version}.dmg",
      user_agent: :fake
  homepage 'https://github.com/lyswhut/lx-music-desktop'

  auto_updates false

  app 'lx-music-desktop.app'
end
