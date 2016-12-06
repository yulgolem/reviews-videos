json.video do |json|
  json.partial! 'apress/videos/api/v1/videos/video', locals: {video: @video}
end
