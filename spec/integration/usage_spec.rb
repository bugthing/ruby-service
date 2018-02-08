require 'spec_helper'

describe 'High level use of the service' do
  around { |example| run_test? ? example.run : example.skip }

  let(:amqp_url) { 'amqp://guest:guest@rabbitmq:5672/service' }
  let(:mongodb_uri) { 'mongodb://mongodb:27017/service' }

  context 'when a message appears in rabbitmq' do
    it 'writes a json document to mongodb data store' do
      message = "Tested at:#{Time.now}"

      # start_service
      fork do
        `ENVIRONMENT=production ./bin/service`
      end

      sleep 2

      # publish message
      system(%(
        amqp-publish --url='#{amqp_url}' \
                     --body='{ "test": "#{message}" }' \
                     --routing-key=events
      ))
      expect($CHILD_STATUS.exitstatus).to be 0

      sleep 1

      # fetch all documents
      recent_document = `
        mongoexport --uri='#{mongodb_uri}' \
                    --collection=messages \
                    --pretty \
                    --noHeaderLine
      `
      expect($CHILD_STATUS.exitstatus).to be 0

      expect(recent_document).to include message
    end
  end

  def run_test?
    got_commands? && got_docker_env?
  end

  def got_commands?
    system('which amqp-publish && which mongoexport')
    $CHILD_STATUS.exitstatus == 0
  end

  def got_docker_env?
    ENV.key?('RABBITMQ_NAME') && ENV.key?('MONGODB_NAME')
  end
end
