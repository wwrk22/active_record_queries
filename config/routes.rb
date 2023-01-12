Rails.application.routes.draw do
  resources :orders
  resources :reviews
  resources :customers
  resources :books
  resources :authors
  resources :suppliers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/books/filter/out_of_print/', to: 'books#list_oop'
  get '/books_by_author/:first_name/:last_name', to: 'books#list_books_by_author'
  get '/books/year_published_range/:begin_year/:end_year', to: 'books#list_books_by_year_published_range'
  get '/books_since_year/:year', to: 'books#list_books_since_year'

  # http://localhost:3000/customers_by_orders_count?orders_counts[]=1&orders_counts[]=3&orders_counts[]=5
  get '/customers_by_orders_count', to: 'customers#list_by_orders_count'
end
