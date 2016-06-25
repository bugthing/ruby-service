require 'spec_helper'

describe IntServ::Workers::Service do
  let(:worker) { described_class.new }
  before do
	allow(IntServ::Store).to receive(:new).and_return(fake_store)
  end
  let(:fake_store) { spy }

  it 'receives messages from events queue' do
    expect(worker.queue.name).to eq 'events'
  end

  describe '#work' do
    subject { worker.work message }

    let(:message) {}

    it 'raises an exception if the message could not be parsed' do
	  expect { subject }.to raise_exception IntServ::Exceptions::JsonParseError
    end

	context 'with a valid json message' do
      let(:message) { '{"name":"dave"}' }

      it 'parses message as json and stores' do
		subject
        expect(fake_store).to have_received(:store).with({'name' => 'dave'})
      end
    end
  end
end
