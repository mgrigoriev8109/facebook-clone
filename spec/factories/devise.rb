FactoryBot.define do
  factory :user do
    email {"testone@user.com"}
    username {"user_one"}
    password {"qwerty"}
  end

  factory :user_two, class: User do
    email {"testtwo@user.com"}
    username { "user_two" }
    password {"qwerty"}
  end
end
