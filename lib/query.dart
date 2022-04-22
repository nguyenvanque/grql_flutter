var getProduct = """
{
  products(first: 5, channel: "default-channel") {
    edges {
      node {
        id
        name
        description
        thumbnail{
          url
        }
      }
    }
  }
}

""";

String getPerson = """ 
query{
persons{
  id
  name
  age
}
}
""";

String getAlbumn="""
query getAlbum(\$page:Int,\$limit:Int){
  albums(options:{paginate:{page:\$page,limit:\$limit}}){
   data{
    id
    title
     user{
      id
      name
      phone
      email
      albums{
        data{
          id
          title
          photos{
            data{
              thumbnailUrl
            }
          }
       
        }
      }
    }
  }
  }
}
""";
