define :puma_install, gem_bin_path: "/usr/local/bin/gem" do
                                         
  gem_package 'bundler' do
    version node["puma"]["bundler_version"]
    gem_binary params[:gem_bin_path]
    options '--no-ri --no-rdoc'
  end

  gem_package 'puma' do
    action :install
    version node["puma"]["version"]
    gem_binary params[:gem_bin_path]
  end

end
