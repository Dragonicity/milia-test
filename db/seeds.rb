user = User.new
user.email                 = "mark.nelson@dragonicity.com"
user.password              = "123456"
user.password_confirmation = '123456'
user.first_name            = "Mark"
user.last_name             = "Nelson"
user.roles                 = "site_admin"
user.save!

puts "Admin user created"

Topic.create!(title: "Retreats")
Topic.create!(title: "Retreat Design")
Topic.create!(title: "Services")
Topic.create!(title: "Products")
Topic.create!(title: "General")

puts "5 topics created"

12.times do |blog|
  Blog.create!(
    title:      "Blog Post #{blog}",
    subtitle: "Excerpt from the Crysalids by John Wyndham",
    body:       "When I was quite small I would sometimes dream of a city — which was strange because it began before I even knew what a city was. But this city, clustered on the curve of a big blue bay, would come into my mind. I could see the streets, and the buildings that lined them, the waterfront, even boats in the harbour; yet, waking, I had never seen the sea, or a boat. ... And the buildings were quite unlike any I knew. The traffic in the streets was strange, carts running with no horses to pull them; and sometimes there were things in the sky, shiny fish-shaped things that certainly were not birds.",
    thumb_nail: "http://placehold.it/350x200",
    main_image: "http://placehold.it/600x400",
    user_id:    user.id,
    topic_id: Topic.first.id
  )
end

puts "12 blog posts created"

Product.delete_all
Product.create!(title: 'Rails, Angular, Postgres, and Bootstrap',
  description:
    %{<p>
      <em>Powerful, Effective, and Efficient Full-Stack Web Development</em>
      As a Rails developer, you care about user experience and performance,
      but you also want simple and maintainable code. Achieve all that by
      embracing the full stack of web development, from styling with
      Bootstrap, building an interactive user interface with AngularJS, to
      storing data quickly and reliably in PostgreSQL. Take a holistic view of
      full-stack development to create usable, high-performing applications,
      and learn to use these technologies effectively in a Ruby on Rails
      environment.
      </p>},
  main_image: 'dcbang.jpg',    
  thumb_nail: 'dcbang.jpg',    
  price: 45.00)
# . . .
Product.create!(title: 'Seven Mobile Apps in Seven Weeks',
  description:
    %{<p>
      <em>Native Apps, Multiple Platforms</em>
      Answer the question “Can we build this for ALL the devices?” with a
      resounding YES. This book will help you get there with a real-world
      introduction to seven platforms, whether you’re new to mobile or an
      experienced developer needing to expand your options. Plus, you’ll find
      out which cross-platform solution makes the most sense for your needs.
      </p>},
  main_image: '7apps.jpg',
  thumb_nail: '7apps.jpg',
  price: 26.00)
# . . .

Product.create!(title: 'Ruby Performance Optimization',
  description:
    %{<p>
      <em>Why Ruby Is Slow, and How to Fix It</em> 
      You don’t have to accept slow Ruby or Rails performance. In this
      comprehensive guide to Ruby optimization, you’ll learn how to write
      faster Ruby code—but that’s just the beginning. See exactly what makes
      Ruby and Rails code slow, and how to fix it. Alex Dymo will guide you
      through perils of memory and CPU optimization, profiling, measuring,
      performance testing, garbage collection, and tuning. You’ll find that
      all those “hard” things aren’t so difficult after all, and your code
      will run orders of magnitude faster.
      </p>},
  main_image: 'adrpo.jpg',
  thumb_nail: 'adrpo.jpg',
  price: 46.00)

puts "3 products created"

Teacher.create!(name: "Mark Nelson", summary: "Shamanic practitioner and mentor", biography: "TBC")

Teacher.create!(name: "Hilsue Wong", summary: "Aerial yoga instructor and life coach", biography: "TBC")

Teacher.create!(name: "Vanina de Verneuil", summary: "Workshop leader and creativity consultant", biography: "TBC")

Teacher.create!(name: "Barbara Cooper", summary: "Teaching cnsultant", biography: "TBC")

Teacher.create!(name: "Ross Eathorne", summary: "Movement medicine practitioner and coach", biography: "TBC")

puts "5 teachers created"