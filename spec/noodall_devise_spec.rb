require 'spec_helper'

describe Noodall::Devise do
  it "should be valid" do
    Noodall::Devise.should be_a(Module)
  end

  describe User do
    it "should be an editor by default" do
      u = Factory(:user)
      u.editor?.should be(true)
    end
    it "should not be an editor if editor groups have been set" do
      User.editor_groups = ['editor']
      u = Factory(:user)
      u.editor?.should be(false)
    end
    it "should be an editor if editor groups have been set and is in the correct group" do
      User.editor_groups = ['editor']
      u = Factory(:user, :group_list => 'editor')
      u.editor?.should be(true)
    end
  end
end
