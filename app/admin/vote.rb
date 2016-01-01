ActiveAdmin.register Vote do

  actions :all, except: [:create, :new, :update, :edit, :destroy]

  filter :id

  index do
    vote_list
  end

end
