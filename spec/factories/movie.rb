FactoryGirl.define do
  factory :movie do
    title 'A Fake Title'
    rating 'PG'
    release_date {10.year.ago}
    director 'John Doe'
  end
end
