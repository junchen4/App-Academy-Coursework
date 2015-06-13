var Posts = JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  model: JournalApp.Models.Post,
  getOrFetch: function(id){
    //set the temporary variable to the post we want or a new Model so that we can go get it
    var currentPost = this.get(id) || new JournalApp.Models.Post({id: id});
    this.add(currentPost); //add temp to this collection

    currentPost.fetch();
    //this is what fetch does:
    //fetch sends an ajax req to the server
    //sends a get to rails route /posts/id for a response type of json
    //GET /posts/:id with accepts type json
    //server calls show in posts_controller
    //show grabs the right Post from the db
    //show implicit call to show.json.jbuilder
    //server builds response with render from show
    //server returns the response in type json
    //currentPost.attributes(:urlRoot, :id, :title, etc)
    return currentPost;
    //fetch is asynchronous
    //when we return the fetch might not be done
    //we should remember when we use getOrFetch that the render will have to wait
    //until the fetch is complete
    //all this means is if we use getOrFetch to display the data
    //it will render only after the server returns the data
  }
});

//getOrFetch
//var currentPost = null;
//check if the collection has a model with the id
//if it doesn't
  //make one(line 6)
  // add that to the collection
  //currentPost = new
//if it does
  //get it
  //currentPost = this.get(id)
//fetch it
//currentPost.fetch()
//return currentPost
