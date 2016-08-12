Pod::Spec.new do |spec|
  spec.name         = 'SwiftExpression'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/lostatseajoshua/SwiftExpression'
  spec.authors      = { 'Joshua Alvarado' => 'alvaradojoshua0@gmail.com' }
  spec.summary      = 'Swift library for working with Regex.'
  spec.source       = { :git => 'https://github.com/lostatseajoshua/SwiftExpression.git', :tag => "v#{spec.version}"}
  spec.source_files = 'SwiftExpression/SwiftExpression/Regex.swift'
  spec.platform     = :ios, "8.0"
  spec.requires_arc = true
end
