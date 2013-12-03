require 'rubygems'
require 'rspec'
require 'rspec/fire'

RSpec.configure do | config |
  config.include RSpec::Fire
end

class Bethtest
end

describe "Mocking with RSpec Fire" do
  context "when stubbing a method that does not exist on the mocked class" do
    context "using stub syntax" do
      let(:bethtest) { instance_double("Bethtest") }

      before do
        Bethtest.stub(:new).and_return(bethtest)
      end

      it 'correctly raises an error because the method does not exist' do
        expect { bethtest.stub(:doesnotexist) }.to raise_error RSpec::Expectations::ExpectationNotMetError, /does not implement/
      end
    end

    context "using should_receive syntax" do
      let(:bethtest) {instance_double("Bethtest")}

      before do
        Bethtest.stub(:new).and_return(bethtest)
      end

      it 'correctly raises an error because the method does not exist' do
        expect { bethtest.should_receive(:doesnotexist) }.to raise_error RSpec::Expectations::ExpectationNotMetError, /does not implement/
      end
    end

    context "using hash syntax" do
      let(:bethtest) { instance_double("Bethtest", :doesnotexist => nil) }

      before do
        Bethtest.stub(:new).and_return(bethtest)
      end

      it "should raise an error because the method does not exist - but doesn't" do
        expect { bethtest }.to raise_error RSpec::Expectations::ExpectationNotMetError, /does not implement/
      end
    end

  end

end