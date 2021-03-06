# Add a declarative step here for populating the DB with movies.


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  (page.body.index(e1) < page.body.index(e2)).should == true
  # (page.body =~ Regexp.new(".*#{e1}.*#{e2}.*")).should_not == nil
  # assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(", ")
  unchecked = Movie.all_ratings.reject{|x| ratings.include? x}

  ratings.each {|rating|
  if uncheck then
    uncheck("ratings[#{rating}]")
  else
    check("ratings[#{rating}]")
  end
  }

  unchecked.each {|rating|
  if uncheck then
    check("ratings[#{rating}]")
  else
    uncheck("ratings[#{rating}]")
  end
  }
end

Then /^I should see all of the movies$/ do
  rows = page.all('table[@id="movies"]/tbody/tr')
  rows.length.should == 10
end


  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
