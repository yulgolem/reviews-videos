app.modules.videos = (function(self) {
  var
    _subject = {},
    _subjectId,
    _retryInterval = 2000;

  function _init() {
    $.each($('.js-video-processing'), function() {
      _processing($(this).data('id'));
    });
  }

  function getVideoDataUrl(id) {
    return app.config.apiVideos.url.replace('_id_', id);
  }
  
  function _processing(id) {
    $.ajax({
      url: getVideoDataUrl(id),
      success: function(data) {
        if (data.video.status === 'processing') {
          setTimeout(function() {
            _processing(id);
          }, _retryInterval);
        } else {
          $doc.trigger('renderVideoPreview:videos', [{
            container: $('.js-video-processing[data-id="' + data.video.id + '"]'),
            oembedData: data.video['oembed_data']}]
          );
        }
      }
    });
  }

  function _prepareSubject(receivedVideos) {
    var
      maxVideosCount = app.config.videos.maxVideosCount || 1,
      videos = receivedVideos || [];

    _subjectId = app.config.videos.uploadData.subjectId;
    _subject[_subjectId] = {
      container: $('.js-video-container'),
      subjectId: _subjectId,
      subjectType: app.config.videos.uploadData.subjectType,
      videos: videos
    };

    if (_subject[_subjectId].videos.length >= maxVideosCount) {
      _subject[_subjectId].limitExceeded = true;
    }

    $.each(videos, function() {
      this.destroy = 0;
    });

    $doc.trigger('renderVideoForm:videos', _subject[_subjectId]);
  }

  function _isValidUrl(value) {
    return (new RegExp(app.config.videos.regexp.join('|'), 'i').exec(value) || !value);
  }

  function _addVideo() {
    var
      maxVideosCount = app.config.videos.maxVideosCount || 1,
      itemIndex = _subject[_subjectId].videos.length;

    if (_subject[_subjectId].videos.length + 1 >= maxVideosCount) {
      _subject[_subjectId].limitExceeded = true;
    }
    _subject[_subjectId].videos.push({
      destroy: 0,
      url: '',
      position: itemIndex + 1
    });
    $doc.trigger('renderVideoForm:videos', _subject[_subjectId]);
  }

  function _editVideo() {
    var
      $this = $(this),
      itemIndex = $this.closest('.js-video-item').data('id'),
      url = $this.val(),
      gaIds = _subject[_subjectId].container.data('ga-events');

    gaIds && gaIds.change && $doc.trigger('send:googleAnalytics', gaIds.change);

    if (!_isValidUrl(url)) {
      $doc.trigger('invalidVideoUrl:videos', $this);
      gaIds && gaIds['invalid-url'] && $doc.trigger('send:googleAnalytics', gaIds['invalid-url']);
      return false;
    }

    _subject[_subjectId].videos[itemIndex].url = url;
    _subject[_subjectId].videos[itemIndex].destroy = +!url;
    $doc.trigger('renderVideoForm:videos', _subject[_subjectId]);
  }

  function _deleteVideo() {
    var itemIndex = $(this).closest('.js-video-item').data('id');

    _subject[_subjectId].videos[itemIndex].url = '';
    _subject[_subjectId].videos[itemIndex].destroy = 1;
    $doc.trigger('renderVideoForm:videos', _subject[_subjectId]);
  }

  function _renderIframe() {
    var
      $preview = $(this),
      $iframe = $($preview.data('src'))[0],
      providerName = $preview.data('provider_name').toLowerCase();

    switch (providerName){
      case 'rutube':
        $iframe.src += '?autoStart=1';
        break;
      case 'youtube':
        $iframe.src += '&autoplay=1';
        break;
      case 'vimeo':
        $iframe.src += '?autoplay=1';
        break;
    }
    $doc.trigger('renderIframe:videos', {container: $preview, src: $iframe.src});
  }

  function _listener() {
    $doc
      .on('prepareObject:videos', function(event, videos) {
        _prepareSubject(videos);
      })
      .on('click', '.js-add-video', _addVideo)
      .on('change', '.js-video-input', _editVideo)
      .on('click', '.js-clear-video-input', _deleteVideo)
      .on('click', '.js-video-preview', _renderIframe)
      .on('getVideoData:videos', function(event, id) {
        _processing(id);
      });
  }

  self.load = function() {
    _init();
    _listener();
  };

  return self;
})(app.modules.videos || {});
