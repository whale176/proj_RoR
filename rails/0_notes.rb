ssh://git@35.194.151.1:2222/fusiontw/toy_app.git

> rails routes
7個

before_action :set_user, only: [:show, :edit, :update, :destroy]
==
@user = User.find(params[:id])


# Relation ship

has_many
belongs_to

# ORM
has_many
 Article.where('user_id = ?', user.id)