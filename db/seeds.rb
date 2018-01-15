ThemeGroup.create!([
  {title: "1,2년차 사회 초년생을 위한 테마"},
  {title: "서른을 맞이하는 당신을 위한 테마"},
  {title: "창업을 고민하는 당신을 위한 테마"}
])


Theme.create!([
  {user_id: 1, theme_group_id: 1, title: "theme1", background_img: "/template/img/headers/1.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 1, title: "theme2", background_img: "/template/img/headers/2.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 1, title: "theme3", background_img: "/template/img/headers/3.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 1, title: "theme4", background_img: "/template/img/headers/4.png", thumbnail_img: nil},

  {user_id: 1, theme_group_id: 2, title: "theme5", background_img: "/template/img/headers/5.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 2, title: "theme6", background_img: "/template/img/headers/6.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 2, title: "theme7", background_img: "/template/img/headers/7.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 2, title: "theme8", background_img: "/template/img/headers/8.png", thumbnail_img: nil},

  {user_id: 1, theme_group_id: 3, title: "theme9", background_img: "/template/img/headers/9.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 3, title: "theme10", background_img: "/template/img/headers/10.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 3, title: "theme11", background_img: "/template/img/headers/11.png", thumbnail_img: nil},
  {user_id: 1, theme_group_id: 3, title: "theme12", background_img: "/template/img/headers/12.png", thumbnail_img: nil}
])

12.times do |i|
    10.times { |j| Post.create(user_id: i+1) }
end
