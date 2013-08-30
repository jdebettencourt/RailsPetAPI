Tenderpets::Application.routes.draw do

  root :to => 'pets#home'

  get 'getpet/:id' => 'pets#getpet'

  get 'findpets/:options' => 'pets#findpets'

  get 'random/:options' => 'pets#random'

  get 'listbreeds/:animal' => 'pets#listbreeds'

end
