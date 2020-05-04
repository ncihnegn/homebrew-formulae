cask 'lx-music-desktop' do
  version '0.18.2'
  sha256 '02f8135147320d30f19689d0797a37183bd86d33cef1296fe59fa9886c1f060e'

  url "https://github.com/lyswhut/lx-music-desktop/releases/download/v#{version}/lx-music-desktop-#{version}.dmg",
      user_agent: :fake
  homepage 'https://github.com/lyswhut/lx-music-desktop'

  auto_updates true

  app 'lx-music-desktop.app'
end
