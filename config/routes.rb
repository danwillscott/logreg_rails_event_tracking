Rails.application.routes.draw do

  get '/', :controller => 'users', :action => 'index'

  get 'dashboard', :controller => 'users', :action => 'dashboard'

  get 'edit', :controller => 'users', :action => 'edit'

  get 'logout', :controller => 'users', :action => 'logout'

  post 'login_user', :controller => 'users', :action => 'login_user'

  post 'register_user', :controller => 'users', :action => 'register_user'

  patch 'update_user', :controller => 'users', :action => 'update_user'

  delete 'delete_user', :controller => 'users', :action => 'delete_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
