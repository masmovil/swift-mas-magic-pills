# frozen_string_literal: true

task default: %w[setup]

task(:setup) do
  raise '`brew` is required. Please install brew. https://brew.sh/' unless system('which brew')

  puts('➡️  Bundle')
  sh('arch -x86_64 bundle install')

  puts('➡️  Overcommit')
  sh('arch -x86_64 bundle exec overcommit --install')
  sh('arch -x86_64 bundle exec overcommit --sign')
  sh('arch -x86_64 bundle exec overcommit --sign pre-commit')
end

task(:tests) do
  sh('arch -x86_64 bundle exec fastlane pass_tests')
end

task(:validate_podfile) do
  sh('arch -x86_64 bundle exec pod lib lint --allow-warnings')
end