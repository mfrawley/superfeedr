#
# Be sure to run `pod lib lint superfeedr.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "superfeedr"
  s.version          = "0.1.1"
  s.summary          = "superfeedr iOS client"
  s.description      = <<-DESC
                      Api client for superfeedr with example app 
                       DESC
  s.homepage         = "https://github.com/mfrawley/superfeedr"
  s.license          = 'MIT'
  s.author           = { "Mark Frawley" => "markfrawley@gmail.com" }
  s.source           = { :git => "https://github.com/mfrawley/superfeedr.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'api_wrapper/*.swift'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
end
