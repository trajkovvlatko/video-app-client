class Video.FeaturedVideo extends Backbone.View
  template: "#featured_video_tpl"
  className: "featured-video"

  initialize: ->
    _.bindAll this, "render"

  render: ->
    container = $(@el)
    video = @options.video
    template = _.template( $(@template).html(), { video: video } )
    container.html(template)
    this
