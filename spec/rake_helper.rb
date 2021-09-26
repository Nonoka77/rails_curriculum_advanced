require 'rails_helper'
require 'rake'

RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.load_tasks #ここで全てのrakeタスクを読み込む
  end

  config.before(:each) do
    Rake.application.tasks.each(&:reenable)
  end
end
