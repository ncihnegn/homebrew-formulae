cask 'lx-music-desktop' do
  version '0.18.2'

  url "https://github.com/lyswhut/lx-music-desktop/releases/download/v#{version}/lx-music-desktop-#{version}.dmg"
      user_agent: :fake
  homepage 'https://github.com/lyswhut/lx-music-desktop'

  auto_updates true

  app 'lx-music-desktop.app'
end
