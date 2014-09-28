require 'spec_helper'

describe 'puma::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it "includes the default recipe" do
    expect(chef_run).to include_recipe 'puma::default'
  end

  it "installs the puma gem" do
    expect(chef_run).to install_gem_package('puma')
  end

  it "installs bundler" do
    expect(chef_run).to install_gem_package('bundler')
  end
end


