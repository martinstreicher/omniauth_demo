require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :authentications }
  end

  describe "callbacks" do
  end

  describe "methods" do
  end
end
