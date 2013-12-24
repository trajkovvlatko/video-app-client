class Video.MyVideo extends Backbone.View
  template: "#video_tpl"
  className: "my-video"

  initialize: ->
    _.bindAll this, "render"

  render: ->
    container = $(@el)
    video = @options.video
    template = _.template( $(@template).html(), { video: video } )
    container.html(template)
    this
