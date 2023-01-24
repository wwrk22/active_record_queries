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

  get '/books_not_by_author/:first_name/:last_name', to: 'books#list_books_not_by_author'

  # /books_by_either_author?a1_f_name=Joe&a1_l_name=Shmoe&a2_f_name=Bill&a2_l_name=Nye
  get '/books_by_either_author', to: 'books#list_books_by_either_author'

  get '/available_books_since_year/:year', to: 'books#available_books_since_year'

  # Count the number of books written by each author.
  get '/all_authors_book_counts', to: 'author#book_count'
end
