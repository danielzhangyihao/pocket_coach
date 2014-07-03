FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :instructor do
      student false
    end

    factory :admin do
      admin true
    end
  end

  factory :identity do
    school_facility "Mike Murphy Baseball"
    user
    position "pitcher"
  end
end