require "spec_helper"

describe Pirate::Service do
  it "has a version number" do
    expect(Pirate::Service::VERSION).not_to be nil
  end
end

describe Pirate::Service::Base do
  class TestService < Pirate::Service::Base
    attr_reader :id, :name, :type

    def call
      calculate_name
      return name
    end

    private

    def calculate_name
      @name = "#{id}-#{type}"
    end
  end

  context "when a class that inherits from Base" do
    let(:params) do
      { id: 0, type: "bounty" }
    end

    describe ".new" do
      context "when the params don't contain an attribute" do
        it "should not set the reader attribute" do
          subject = TestService.new(params)
          expect(subject.name).to eq(nil)
        end
      end

      context "when the params contain an attribute" do
        it "should populate the reader attributes" do
          subject = TestService.new(params)
          expect(subject.id).to eq(0)
          expect(subject.type).to eq("bounty")
        end
      end
    end

    describe ".call" do
      it "should call .new" do
        mock = Proc.new {}
        expect(TestService).to receive(:new).with(params).and_return(mock)
        TestService.call(params) {}
      end

      it "should run the child object's call method" do
        result = TestService.call(params)
        expect(result).to eq("0-bounty")
      end
    end
  end
end
