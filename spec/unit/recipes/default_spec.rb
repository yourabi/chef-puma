require 'spec_helper'

RSpec.configure do |config|
  # Specify the path for Chef Solo to find cookbooks (default: [inferred from
  # the location of the calling spec file])
  # config.cookbook_path = '~/.berkshelf/cookbooks'
  
end
describe "puma::default" do
  context "with default attributes" do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it "includes the default recipe" do
      expect(chef_run).to include_recipe 'puma::default'
    end

    it "installs the puma gem" do
      expect(chef_run).to install_gem('puma')
    end
        
  end
end
