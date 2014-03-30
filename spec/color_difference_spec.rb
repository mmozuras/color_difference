require 'spec_helper'

describe ColorDifference do
  describe '.cie2000' do
    subject { ColorDifference.cie2000(color1, color2) }

    context 'red compared to' do
      let(:color1) { { r: 255, g: 0, b: 0 } }

      context 'red' do
        let(:color2) { { r: 255, g: 0, b: 0 } }
        it { should == 0 }
      end

      context 'ff3800' do
        let(:color2) { { r: 255, g: 56, b: 0 } }
        it { should == 0.04308600148974144 }
      end

      context 'ff5555' do
        let(:color2) { { r: 255, g: 85, b: 85 } }
        it { should == 0.1190679817247797 }
      end

      context 'ddaaaa' do
        let(:color2) { { r: 221, g: 170, b: 170 } }
        it { should == 0.2958768313174173 }
      end

      context 'green' do
        let(:color2) { { r: 0, g: 255, b: 0 } }
        it { should == 0.866150129074629 }
      end

      context 'blue' do
        let(:color2) { { r: 0, g: 0, b: 255 } }
        it { should == 0.5287867414046132 }
      end
    end
  end
end
