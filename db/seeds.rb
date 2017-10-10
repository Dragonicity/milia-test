user = User.new
user.email = "mark.nelson@dragonicity.com"
user.password = "123456"
user.password_confirmation = '123456'
user.first_name = "Mark"
user.last_name = "Nelson"
user.roles = "site_admin"
user.save!

12.times do |blog|
  Blog.create!(
    title:      "Blog Post #{blog}",
    body:       "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there. Then I'm gonna shoot that bitch in the kneecaps, find out where my goddamn money is. She gonna tell me too. Hey, look at me when I'm talking to you, motherfucker. You listen: we go in there, and that nigga Winston or anybody else is in there, you the first motherfucker to get shot. You understand?",
    thumb_nail: "http://placehold.it/350x200",
    main_image: "http://placehold.it/600x400",
    user_id:    user.id 
  )
end

puts "12 blog posts created"