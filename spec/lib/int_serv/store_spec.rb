# frozen_string_literal: true

require 'spec_helper'

describe IntServ::Store do
  subject(:store) { described_class.new }

  it 'defaults to in memory adapter' do
    expect(store.adapter).to be_an IntServ::Adapters::Stores::InMem
  end

  it 'settings change the default adapter' do
    stub_const 'SETTINGS', 'store_adapter' => 'mongodb',
                           'mongodb_uri' => 'test_mongo_url'
    allow(::Mongo::Client).to receive(:new).and_return(double)

    expect(store.adapter).to be_an IntServ::Adapters::Stores::Mongodb
  end

  describe '#store' do
    it 'stores the data in the test adapter' do
      store.store 'aaa'
      expect(IntServ::Adapters::Stores::InMem.new).to include 'aaa'
    end

    context 'when injecting the adapter' do
      subject(:store) { described_class.new test_adapter }

      let(:test_adapter) do
        Class.new(Array) do
          alias_method :store, :<<
        end.new
      end

      it 'stores the data in the test adapter' do
        store.store 'bbb'

        expect(test_adapter).to include('bbb')
      end
    end
  end
end
