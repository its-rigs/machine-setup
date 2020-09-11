brew_apps = %w{
  git
  htop
  tig
  tldr
}

brew_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

dep 'blackbox.bin' do
  provides 'blackbox_initialize'
end

dep 'install all brew apps' do
  requires [
    *(brew_apps).map { |a| "#{a}.bin" },
    'blackbox.bin'
  ]
end
