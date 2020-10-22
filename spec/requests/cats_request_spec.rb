require 'rails_helper'

RSpec.describe "Cats", type: :request do

  cat_params = {
    cat: {
      name: 'Buster',
      age: 4,
      enjoys: 'Meow Mix, and plenty of sunshine.'
    }
  }

  it "gets a list of Cats" do
    # Create a new cat in the Test Database (this is not the same one as development)
    Cat.create(name: 'Felix', age: 2, enjoys: 'Walks in the park')

    # Make a request to the API
    get '/cats'

    # Convert the response into a Ruby Hash
    json = JSON.parse(response.body)
    # Assure that we got a successful response
    expect(response).to have_http_status(:ok)

    # Assure that we got one result back as expected
    expect(json.length).to eq 1
  end

  it "creates a cat" do

    # Send the request to the server
    post '/cats', params: cat_params

    # Assure that we get a success back
    expect(response).to have_http_status(:ok)

    # Look up the cat we expect to be created in the Database
    cat = Cat.first

    # Assure that the created cat has the correct attributes
    expect(cat.name).to eq 'Buster'
  end

  it "updates a cat" do

    # Send the request to the server
    post '/cats', params: cat_params

    cat = Cat.first

    new_cat_params = {
      cat: {
        name: 'Buster',
        age: 7,
        enjoys: 'Meow Mix, and plenty of sunshine.'
      }
    }

    patch "/cats/#{cat.id}", params: new_cat_params

    cat = Cat.find(cat.id)

    expect(response).to have_http_status(200)
    expect(cat.age).to eq 7

  end

  it "destroys a cat" do

    # Send the request to the server
    post '/cats', params: cat_params

    cat = Cat.first
    cat = Cat.find(cat.id)

    delete "/cats/#{cat.id}", params: cat_params

    expect(response).to have_http_status(200)
    cat = Cat.all
    expect(cat).to be_empty

  end

  it "doesn't create a cat without a name" do
    cat_params = {
      cat: {
        age: 7,
        enjoys: 'Meow Mix, and plenty of sunshine.'
      }
    }

    # Send the request to the server
    post '/cats', params: cat_params

    expect(response).to have_http_status(422)

    json = JSON.parse(response.body)

    expect(json['name']).to include "can't be blank"

  end

  it "updates an enjoys string too short" do

    cat_params = {
      cat: {
        name: 'Buster',
        age: 7,
        enjoys: 'Meow Mix'
      }
    }

    # Send the request to the server
    post '/cats', params: cat_params

    cat = Cat.first

    expect(response).to_not have_http_status(:ok)

  end

end
