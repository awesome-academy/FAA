environments = Rails.application.config.rack_mini_profiler_environments
if environments.include? Rails.env
  require "rack-mini-profiler"

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize! Rails.application
end
