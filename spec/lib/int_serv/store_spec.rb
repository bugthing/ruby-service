require 'spec_helper'

describe IntServ::Store do
  let(:store) { described_class.new }

  before do
    allow(Mongo::Client).to receive(:new).and_return(fake_mongo)
    allow(fake_mongo).to receive(:[]).and_return(fake_table)
  end
  let(:fake_mongo) { spy }
  let(:fake_table) { spy }

  it 'connects to the mongodb' do
    expect(Mongo::Client).to receive(:new).with('test_mongo_url')
    store
  end

  describe '#store' do
    subject { store.store(data) }

    let(:data) { 'aaa' }

    it 'stores the data in the client' do
      subject
      expect(fake_mongo).to have_received(:[]).with(:messages)
      expect(fake_table).to have_received(:insert_one).with('aaa')
    end
  end
end
