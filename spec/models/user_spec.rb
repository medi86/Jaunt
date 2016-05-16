require 'rails_helper'

RSpec.describe('User', {type: :model}) do
  it "user has name" do
    user = User.new(name: "DongmAn")
    user.save
    user.name == "DongmAn"
  end

  it "user name can't be empty" do
    user = User.new(name: "")
    user.save
    user.name == nil
  end

  it "user name can't be longer than 30chars" do
    user = User.new(name: "dsfkjlaksdjflkasdjflkajdslfkjalsdfkjladkjflkadsjflk")
    user.save
    user.name == nil
  end

  it "user name is unique" do
    user = User.create(name: "dongmin")
    user2 = User.create(name: "dongmin")
    user2.name == nil
  end

  it "user has email" do
    user = User.new(email: "medi8600@gmail.com")
    user.save
    user.email == "medi8600@gmail.com"
  end

  it "user email has to be in right format" do
    user = User.new(email: "asdkfjasdfk")
    user.save
    user.email == nil

    user2 = User.new(email: "kkk@adsasdf")
    user2.save
    user2.email == nil
  end

  it "user email is unique" do
    user = User.new(email: "medi8600@gmail.com")
    user.save
    user2 = User.new(email: "medi8600@gmail.com")
    user2.save
    user2.email == nil
  end

  it 'user has encrypted password' do
    user = User.new(password: 'password')
    user.save
    user.password_digest == !nil
  end

  it 'user password has to be longer than 8 chars' do
    user = User.create(password: '1234567')
    user.password_digest == nil
  end
end

