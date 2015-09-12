require 'rails_helper'

RSpec.describe PublishersController, :type => :controller do
  describe "GET #new" do
    it "returns a successful http request status code" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns a successful http request stutus code" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful http request status code" do
      publisher = Fabricate(:publisher)

      get :show, id: publisher
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "a successful create" do
      it "saves the new publisher object" do
        #require 'pry';binding.pry
        post :create, publisher: Fabricate.attributes_for(:publisher)
        expect(Publisher.count).to eq(1)
      end

      it "redirects to the show action" do
        post :create, publisher: Fabricate.attributes_for(:publisher)
        expect(response).to redirect_to publisher_path(Publisher.first)
      end

      it "sets the success flash message" do
        post :create, publisher: Fabricate.attributes_for(:publisher)
        expect(flash[:success]).to eq('Publisher has been created.')
      end
    end

    context "unsuccessful create" do
      it "it does not save the new publisher object with invalid inputs" do
        post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
        expect(Publisher.count).to eq(0)
      end

      it "renders to the new template" do
        post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
        expect(response).to render_template :new
      end

      it "sets the failure flash message" do
        post :create, publisher: Fabricate.attributes_for(:publisher, name: nil)
        expect(flash[:danger]).to eq('Publisher has not been created.')
      end
    end
  end

  describe "GET #edit" do
    let(:publisher) { Fabricate(:publisher, name: 'John') }
    it "finds the publisher with the given id and assigns to @publisher variable" do
      get :edit, id: publisher
      expect(assigns(:publisher)).to eq(publisher)
    end

    it "renders the edit template" do
      get :edit, id: publisher
      expect(response).to render_template('edit')
    end
  end

  describe "PUT #update" do
    context "a successful update" do
      let(:publisher) { Fabricate(:publisher) }

      it "updates the modified publisher object" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: 'Paul'), id: publisher.id
        expect(Publisher.first.name).to eq('Paul')
      end

      it "redirects to the show action" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: 'Paul'), id: publisher.id
        expect(response).to redirect_to publisher_path(Publisher.first)
      end

      it "sets the success flash message" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: 'Paul'), id: publisher.id
        expect(flash[:success]).to eq('Publisher has been updated.')
      end
    end

    context "unsuccessful update" do
      let(:publisher) { Fabricate(:publisher, name: 'Paul') }

      it "does not update the modified publisher object" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: ''), id: publisher.id
        expect(Publisher.first.name).to eq('Paul')
      end

      it "renders the edit template" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: ''), id: publisher.id
        expect(response).to render_template :edit
      end

      it "sets the failure flash message" do
        put :update, publisher: Fabricate.attributes_for(:publisher, name: ''), id: publisher.id
        expect(flash[:danger]).to eq('Publisher has not been updated.')
      end
    end #context
  end

  describe 'DELETE #destroy' do
    let(:publisher) { Fabricate(:publisher, name: 'Paul') }

    it 'deletes the publisher with the given id' do
      delete :destroy, id: publisher
      expect(Publisher.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, id: publisher
      expect(flash[:success]).to eq('Publisher has been deleted.')
    end

    it 'redirects to the index page' do
      delete :destroy, id: publisher
      expect(response).to redirect_to publishers_path
    end
  end
end
