require 'spec_helper'

module ColorDifference
  describe Color do
    let(:color) { Color.new(255, 85, 85) }

    describe '#x' do
      subject { color.x }
      it { should == 46.12819247877917 }
    end

    describe '#y' do
      subject { color.y }
      it { should == 28.412876338581523 }
    end

    describe '#z' do
      subject { color.z }
      it { should == 11.647337845289119 }
    end

    describe '#l' do
      subject { color.l }
      it { should == 60.25992777322978 }
    end

    describe '#a' do
      subject { color.a }
      it { should == 64.22114441381326 }
    end

    describe '#b' do
      subject { color.b }
      it { should == 36.541985592194294 }
    end
  end
end
