class Video.MyVideos extends Backbone.View
  template: "#videos_tpl"
  className: "my-videos-list"

  initialize: ->
    _.bindAll this, "render"

  render: ->
    container = $(@el)
    template = _.template( $(@template).html() )
    container.html(template)
    @collection.each (item) ->
      view = new Video.MyVideo({ video: item })
      $(container).append view.render().el
    this
