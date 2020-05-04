cask 'font-ligalex-mono' do
  version '4'
  sha256 'b09f87d1a4ce154894cf43e818a214d87ad4962dd4cb7668a7c0c5f177eaf21a'

  url "https://github.com/ToxicFrog/Ligaturizer/releases/download/v#{version}/LigaturizedFonts.zip"
  name 'Ligalex Mono'
  homepage 'https://github.com/ToxicFog/Ligaturizer'

  font 'LigalexMono.ttf'
  font 'LigalexMono-Bold.ttf'
  font 'LigalexMono-BoldItalic.ttf'
  font 'LigalexMono-ExtraLight.ttf'
  font 'LigalexMono-ExtraLightItalic.ttf'
  font 'LigalexMono-Italic.ttf'
  font 'LigalexMono-Light.ttf'
  font 'LigalexMono-LightItalic.ttf'
  font 'LigalexMono-Medium.ttf'
  font 'LigalexMono-MediumItalic.ttf'
  font 'LigalexMono-SemiBold.ttf'
  font 'LigalexMono-SemiBoldItalic.ttf'
  font 'LigalexMono-Text.ttf'
  font 'LigalexMono-TextItalic.ttf'
  font 'LigalexMono-Thin.ttf'
  font 'LigalexMono-ThinItalic.ttf'
end
