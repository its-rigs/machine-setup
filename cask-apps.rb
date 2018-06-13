meta :cask do
  def ensure_cask
    return if `brew tap`.include?('caskroom/cask')
    shell "brew tap caskroom/cask"
  end

  template {
    met? {
      `brew cask list`.include? basename
    }

    meet {
      ensure_cask
      shell "brew cask install #{basename}"
    }
  }
end

cask_apps = %w{
  docker
  firefox
  flux
  google-chrome
  iterm2
  oversight
  postman
  slack
  soda-player
  spotify
  sublime-text
  transmission
  virtualbox
  visual-studio-code
  vlc
  whatsapp
}

cask_apps.each do |app|
  dep "#{app}.cask" do
  end
end

dep 'install all casks apps' do
  requires [
    *(cask_apps).map { |a| "#{a}.cask" },
  ]
end