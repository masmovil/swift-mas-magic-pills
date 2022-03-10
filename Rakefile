# frozen_string_literal: true

task default: %w[setup]

task(:setup) do
  raise '`brew` is required. Please install brew. https://brew.sh/' unless system('which brew')

  puts('➡️  Bundle')
  sh('bundle install')

  puts('➡️  Overcommit')
  sh('bundle exec overcommit --install')
  sh('bundle exec overcommit --sign')
  sh('bundle exec overcommit --sign pre-commit')
end

task(:tests) do
  sh('bundle exec fastlane pass_tests')
end

task(:validate_podfile) do
  sh('bundle exec pod lib lint --allow-warnings')
end