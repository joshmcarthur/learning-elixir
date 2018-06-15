defmodule GraphicalWeb.Schema do
  use Absinthe.Schema
  import_types GraphicalWeb.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &GraphicalWeb.PostResolver.all/2
    end

    field :users, list_of(:user) do
      resolve &GraphicalWeb.UserResolver.all/2
    end

    field :user, type: :user do
      arg :id, non_null(:id)
      resolve &GraphicalWeb.UserResolver.find/2
    end
  end

  input_object :update_post_params do
    field :title, non_null(:string)
    field :body, non_null(:string)
    field :user_id, non_null(:integer)
  end

  input_object :update_user_params do
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  mutation do
    field :create_post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
      arg :user_id, non_null(:integer)

      resolve &GraphicalWeb.PostResolver.create/2
    end

    field :update_post, type: :post do
      arg :id, non_null(:integer)
      arg :post, :update_post_params
      resolve &GraphicalWeb.PostResolver.update/2
    end

    field :delete_post, type: :post do
      arg :id, non_null(:integer)
      resolve &GraphicalWeb.PostResolver.delete/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params
      resolve &GraphicalWeb.UserResolver.update/2
    end
  end
end