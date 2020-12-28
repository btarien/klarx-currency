require 'spec_helper'

describe ApplicationController do
  let(:app) {ApplicationController.new}

  it "gets index" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "gets new form" do
    get '/new'
    expect(last_response.status).to eq 200
  end

  it "posts new form and stores new conversion" do
    post('/new', {from: "USD", to: "EUR", amount: 1.00})
    expect(Conversion.last.from).to eq "USD"
  end

  it "adds new conversion to index table" do
    get '/'
    id = Conversion.last.id
    expect(last_response.body).to include("<th>#{id}</th>")
  end
end

describe "#convert" do
  it "converts from USD to EUR" do
    allow(app).to receive(:convert).with({from: "USD", to: "EUR", amount: 1.00}).and_return(0.82)
  end

  it "converts from EUR to USD" do
    allow(app).to receive(:convert).with({from: "EUR", to: "USD", amount: 1.00}).and_return(1.22)
  end

  it "converts from EUR to CHF" do
    allow(app).to receive(:convert).with({from: "EUR", to: "CHF", amount: 1.00}).and_return(1.08)
  end

  it "converts from CHF to EUR" do
    allow(app).to receive(:convert).with({from: "CHF", to: "EUR", amount: 1.00}).and_return(0.92)
  end
end
