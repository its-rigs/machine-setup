meta :cask do
  def strip_template_name
    return name.chomp(".cask")
  end

  def ensure_cask
    shell "brew tap caskroom/cask"
    return if `brew tap`.include?('caskroom/cask')
    shell "brew tap caskroom/cask"
  end

  template {
    meet {
      ensure_cask
      shell "brew cask install #{strip_template_name}"
    }

    met? {
      `brew cask list`.include? strip_template_name
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
