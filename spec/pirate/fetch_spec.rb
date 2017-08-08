require "spec_helper"

describe Pirate::Service::Fetch do
  subject(:fetch) do
    Pirate::Service::Fetch.new(
      id: id
    )
  end

  let(:id) { 1 }
  let(:klass) { double("klass", fetch: record) }
  let(:record) { double("record") }

  before do
    allow(fetch).to receive(:klass) { klass }
  end

  describe "#call" do
    describe "call process" do
      after { subject.call }

      # Has to be a single block as schema is only created on first call
      it do
        is_expected.to receive(:before_find)
        is_expected.to receive(:find_record)
        is_expected.to receive(:after_find)
      end
    end

    it "returns the record" do
      expect(subject.call).to eq(record)
    end
  end

  describe "#klass" do
    subject { fetch.send(:klass) }
    it { is_expected.to eq(klass) }
  end

  describe "#find_record" do
    subject { fetch.send(:find_record) }

    it { is_expected.to eq(record) }

    it "performs an identity_cache fetch on the klass" do
      expect(klass).to receive(:fetch).with(id)
      subject
    end

    it "sets the record instance var" do
      subject
      expect(fetch.record).to eq(record)
    end
  end

  describe "#before_find" do
    subject { fetch.send(:before_find) }
    it { is_expected.to be(nil) }
  end

  describe "#after_find" do
    subject { fetch.send(:after_find) }
    it { is_expected.to be(nil) }
  end
end
