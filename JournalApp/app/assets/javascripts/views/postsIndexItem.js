var PostIndexItem = JournalApp.Views.PostIndexItem = Backbone.View.extend({

  //el and $el: defaults to div
  tagName: "li", //$el will have tag of tagName instead of div if given

  className: "posts-index-item", //$el will have class of className if given

  events: {
    'click button.delete-post': 'destroy'
  },

  initialize: function(options){
    //this.collection and this.model if included in options are auto assigned
    //new JournalApp.Views.PostIndex({collection: //})
    //this.collection = options.collection
  },

  destroy: function(){
    // event.preventDefault();
    console.log("clicked");
    this.model.destroy();
  },

  template: JST["postIndexItem"],
  //view name = "SomethingIndex"
  //view filename = somethingIndex.js is in assets/views
  //template filename = somethingIndex.jst.ejs is in assets/templates
  //Backbone create a function for the template called JST["somethingIndex"]
  //set template in the view to be JST["somethingIndex"]

  //template = JST["somethingIndex"] = function(){}

  render: function(){
    var currentPost = this.template({post: this.model});
    //allPosts.append("blah"); allPosts is just an HTML string. NO JQUERY METHODS

    this.$el.html(currentPost); //$el is a JQuery object
    //$el.append("blah") puts this at the end of $el, $el.html("blah") replaces everything in $el


    // this.$el.html("blah"); this replaces everything in $el
    //$(".posts").append(this.$el); //.posts is class name of <ul>
    return this;
    //var view = new PostIndexItem
    //view.render().$el
  }

});
