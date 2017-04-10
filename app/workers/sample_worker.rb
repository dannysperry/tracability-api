class SampleWorker
  include Sidekiq::Worker
  def perform()
  end
end