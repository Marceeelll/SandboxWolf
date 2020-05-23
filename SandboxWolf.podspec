#
# Be sure to run `pod lib lint SandboxWolf.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SandboxWolf'
  s.version          = '1.0.0'
  s.summary          = 'Manage your App Sandbox and App Group easy with the SandboxWolf.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SandboxWolf makes your life easier to navigate through your sandbox and edit/remove/copy files between directories and your app group.
                       DESC

  s.homepage         = 'https://github.com/Marceeelll/SandboxWolf'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcel Hagmann' => 'hagmann.marcel@yahoo.com' }
  s.source           = { :git => 'https://github.com/Marceeelll/SandboxWolf.git', :tag => s.version.to_s }
  s.social_media_url = 'https://marcelhagmann.de'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.platforms = {
    "ios": "13.0"
  }

  s.source_files = 'SandboxWolf/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SandboxWolf' => ['SandboxWolf/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
