require 'rails_helper'

describe MessagesController do
  let(:group) {create(:group)}
  let(:user)  {create(:user)}

  describe'#index' do
    # ログインしてる場合
    context'log in' do
      before do
        login user
        get :index,params: {group_id: group.id}
      end
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    # ログインしてない場合
    context 'not log in' do
      before do
        get :index, params: {group_id: group.id}
      end
      it 'redurects new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:params) { {group_id: group.id, user_id: user.id, message: attributes_for(:message)}}
    # ログインしてる場合
    context 'log in' do
      before do
        login user
      end
      # 保存に成功
      context 'can save' do
        subject {
          post :create,
          params: params
        }
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end
        it 'redirects to proup_messages_path'do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end
      # 保存に失敗
      context 'can not save' do
        let(:invalid_params){ {group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil)}}
        subject {
          post :create,
          params: invalid_params
        }
        it 'dose not count up' do
          expect{ subject }.not_to change(Message, :count)
        end
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ログインしてない場合
    context 'not log in' do
      before do
        get :create, params: params
      end
      it 'redirect to  new_user_session_path'  do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end

