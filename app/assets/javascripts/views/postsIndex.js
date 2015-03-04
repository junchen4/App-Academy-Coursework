var PostIndex = JournalApp.Views.PostIndex = Backbone.View.extend({

  //el and $el: defaults to div
  tagName: "section", //$el will have tag of tagName instead of div if given

  className: "posts-index", //$el will have class of className if given

  events: {},

  initialize: function(options){
    //this.collection and this.model if included in options are auto assigned
    //new JournalApp.Views.PostIndex({collection: //})
    //this.collection = options.collection
  },

  template: JST["postIndex"],
  //view name = "SomethingIndex"
  //view filename = somethingIndex.js is in assets/views
  //template filename = somethingIndex.jst.ejs is in assets/templates
  //Backbone create a function for the template called JST["somethingIndex"]
  //set template in the view to be JST["somethingIndex"]

  //template = JST["somthingIndex"] = function(){}

  render: function(){
    allPosts = this.template({posts: this.collection});
    //allPosts.append("blah"); allPosts is just an HTML string. NO JQUERY METHODS

    this.$el.html(allPosts); //$el is a JQuery object
    //$el.append("blah") puts this at the end of $el, $el.html("blah") replaces everything in $el


    // this.$el.html("blah"); this replaces everything in $el
    $("body").append(this.$el);
  }

});
