Pod::Spec.new do |spec|
  spec.name         = 'SwiftExpression'
  spec.version      = '3.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/lostatseajoshua/SwiftExpression'
  spec.authors      = { 'Joshua Alvarado' => 'alvaradojoshua0@gmail.com' }
  spec.summary      = 'Swift library for working with Regex.'
  spec.source       = { :git => 'https://github.com/lostatseajoshua/SwiftExpression.git', :tag => "v#{spec.version}"}
  spec.source_files = 'Sources/*.swift'
  spec.platform     = :ios, "8.0"
  spec.requires_arc = true
  spec.swift_versions = '4.2'
end
