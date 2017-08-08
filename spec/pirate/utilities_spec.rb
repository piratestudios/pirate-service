require "spec_helper"

describe Services::Base::Utilities do
  let(:klass) do
    Class.new do
      include Services::Base::Utilities
    end
  end

  subject(:instance) { klass.new }

  describe "#unless_empty" do
    subject { instance.unless_empty(collection) }

    context "collection is not empty" do
      let(:collection) { [double("item")] }
      it { is_expected.to eq(collection) }
    end

    context "collection is empty" do
      let(:collection) { [] }
      it { is_expected.to be(nil) }
    end
  end

  describe "#empty_or_nil?" do
    subject { instance.empty_or_nil?(value) }

    context "is nil" do
      let(:value) { nil }
      it { is_expected.to be(true) }
    end

    context "is empty" do
      let(:value) { [] }
      it { is_expected.to be(true) }
    end

    context "is not empty" do
      let(:value) { [1] }
      it { is_expected.to be(false) }
    end

    context "does not respond to empty" do
      let(:value) { "blah" }
      it { is_expected.to be(false) }
    end
  end
end
