# coding: utf-8
FactoryGirl.define do
  factory :'apress/videos/video', aliases: [:video], class: Apress::Videos::Video do
    url 'https://www.youtube.com/watch?v=NVkvQHk4euM'
    subject_id 1
    subject_type 'Subject'

    trait :with_error do
      oembed_data '404 Not Found'
    end

    trait :with_oembed_data do
      oembed_data JSON.parse('{"thumbnail_url": "test_thubmnail_url", "thumbnail_width": 480, ' +
      '"width": 480, "provider_name": "YouTube", "html": "Test_HTML", "author_name": "1", ' +
      '"title": "1", "author_url": "https:\/\/www.youtube.com\/channel\/UCVfl-9pRqVSXLvoePB70bqw",' +
      ' "height": 270, "provider_url": "https:\/\/www.youtube.com\/", "type": "video", "thumbnail_height": 360, ' +
      '"version": "1.0"}')
    end
  end
end
