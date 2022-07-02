require 'rails_helper'

RSpec.describe "/", :type => :request do
  it 'shows the Wordle title' do
    get '/'

    expect(response).to render_template(:index)
    expect(response.body).to include('<h1>Wordle</h1>')
  end

end