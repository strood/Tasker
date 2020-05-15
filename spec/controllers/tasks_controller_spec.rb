require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:jack) { User.create!(username: "Jack", password: "password") }

  before(:each) do
    allow_message_expectations_on_nil
  end

  describe "GET #new" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      it 'renders the new tasks page' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects you to new user page' do
        get :new
        expect(response).to redirect_to(new_user_url)
      end
    end
  end

  describe "POST #create" do

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it 'redirects to the new user page' do
        post :create, params: { task: {} }
        expect(response).to redirect_to(new_user_url)
      end
    end

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { jack }
      end

      context 'with valid params' do
        it 'redirects to goal show page' do
          post :create, params: { task: { title: 'win fight', description: 'train hard, win the battle' } }
          expect(response).to redirect_to(task_url(Task.last))
        end
      end

      context 'with invalid params' do
        it 'validates presence of title and description' do
          post :create, params: { task: { title: 'invld' } }
          expect(response).to render_template('new')
          expect(flash[:errors]).to be_present
        end
      end
    end


  end
end
