class Video.AdminVideos extends Backbone.View
  template: "#admin_videos_tpl"
  className: "my-videos-list"

  initialize: ->
    _.bindAll this, "render"

  render: ->
    if localStorage.user_type == "admin"
      container = $(@el)
      template = _.template( $(@template).html() )
      container.html(template)
      @collection.each (item) ->
        view = new Video.AdminVideo({ video: item })
        $(container).append view.render().el
      this
