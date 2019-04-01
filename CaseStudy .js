use CaseStudy

db.createCollection("Movies")

db.Movies.insertOne(
    {
        _id:1,
        title:"Sahara",
        category:"Comedy",
        img:"/images/Sahara.jpeg",
        theatre:"Toronto Cineplex",
        unitNum:231,
        street:"MyStreet",
        city:"Toronto",
        province:"Ontario",
        website:"www.sahara.com",
        cost:14.00,
        yr:2018,
        director:"Walid Bela",
        lang:"French",
        rating:9.9,
        showTimes:["12:30", "15:45"],
        reviews:[
            {
                user:{
                    reviewerUserId:284,
                    userName:"TheNiceGuy",
                    profilePic:"/img/user/TheNiceGuy.png"
                },
                likes:[
                    {
                        likeUserId:111,
                        userName:"SomeGuy",
                        dateOfLike:11/03/2018
                    },
                    {
                        likeUserId:121,
                        userName:"AnotherGuy",
                        dateOfLike:23/09/2018
                    }
                ],
                description:"Amazing Movie...",
                rating:9.5
            },
            {
                user:{
                    reviewerUserId:100,
                    userName:"SherlockHolmes",
                    profilePic:"/img/user/SherlockHolmes.jpeg"
                },
                likes:[
                    {
                        likeUserId:222,
                        userName:"GoodGuy",
                        dateOfLike:19/03/2017
                    }
                ],
                description:"Don't recommend it",
                rating:7.5  
            }
        ]      
    }
)

db.createCollection("Restaurants")
    
db.Restaurants.insertOne(
    {
        _id:1,
        title:"Ivars",
        category:"Italian",
        img:"/images/Ivars.jpeg",
        unitNum:123,
        street:"Main Street",
        city:"Toronto",
        province:"Ontario",
        website:"www.ivars.com",
        rating:9.5,
        maxPrice:75.00,
        minPrice:35.00,
        reviews:[
            {
                user:{
                    reviewerUserId:294,
                    userName:"NiceGlasses",
                    profilePic:"/img/user/NiceGlasses.jpeg"
                },
                likes:[
                    {
                        likeUserId:385,
                        userName:"BadGuy",
                        dateOfLike:31/03/2016
                    },
                    {
                        likeUserId:143,
                        userName:"Someone",
                        dateOfLike:07/07/2018
                    }
                ],
                description:"Great food",
                rating:9.5
            },
            {
                user:{
                    reviewerUserId:938,
                    userName:"Pierre",
                    profilePic:"/img/user/Pierre.png"
                },
                likes:[
                    {
                        likeUserId:973,
                        userName:"Somebody",
                        dateOfLike:08/08/2015
                    }
                ],
                description:"Good Price",
                rating:10.0  
            }
        ]      
    }
)
    
db.createCollection("CommunityDiscussions")
    
db.CommunityDiscussions.insertOne(
    {
        _id:1,
        topicTitle:"What is the best thing about Toronto",
        user:{
            userId:294,
            name:"NiceGlasses",
            profilePic:"/img/user/NiceGlasses.jpeg"
        },
        comments:[
            {
                user:{
                  userId:938,
                  name:"Pierre",
                  profilePic:"/img/user/Pierre.png",  
                },
                descrpt:"I like the weather",
                tmStamp:"2018:01:31:15:39:34"
            },
            {
                user:{
                  userId:284,
                  name:"NiceGuy",
                  profilePic:"/img/user/NiceGuy.png",  
                },
                descrpt:"I like the island", 
                tmStamp:"2018:01:30:13:43:24"
            }
        ]
    }      
)





