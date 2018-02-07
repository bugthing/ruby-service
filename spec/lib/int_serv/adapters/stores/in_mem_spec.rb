require 'spec_helper'

describe IntServ::Adapters::Stores::InMem do
  subject(:store) { described_class.new }

  describe '#store' do
    subject { store.store(data) }

    let(:data) { 'aaa' }

    it 'stores data so another instance can accesses it' do
      subject

      expect(described_class.new).to include data
    end
  end
end
