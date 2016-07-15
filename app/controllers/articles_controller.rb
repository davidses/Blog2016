# --------------------- CONTROLADOR --------------------------

class ArticlesController < ApplicationController
	# Esto es un callback
	before_action :authenticate_user!, only: [:create, :new]
	before_action :set_article, except: [:index, :new, :create]
	before_action :authenticate_editor!, only: [:new, :create, :update]
	before_action :authenticate_admin!, only: [:destroy, :publish]

	# GET y el path /articles
	def index
		# Devuelve los articulos publicados
		@articles = Article.paginate(page: params[:page],per_page:3).publicados.ultimos
	end

	# GET /articles/:id
	def show
		# devuelve uno o varios articulos segun lo pasado en el parametro
		# FIND devuelve el primer registro que cumpla la condicion (solo uno)
		# ---@article = Article.find(params[:id]) REFACTORISADO EN EL CALLBACK SET_ARTICLE
		#  WHERE devuelve varios registros que cumplan la condicion.
		# Article.where("id = ? OR body = ?",params[:id],params[:body])
		# where NOT devuelve todos menos el pasado por parametro
		# Article.where.not("id = ?",params[:id])
		@article.update_visits_count
		@comment = Comment.new
	end

	# GET /articles/new
	def new
		@article = Article.new
		@categories = Category.all
	end

	def destroy 
		@article.destroy # Elimina el registro de la BD.
		redirect_to articles_path
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def edit
		# REFACTORIZADO EN EL CALLBACK SET_ARTICLE
	end

	def publish
		@article.publish!
		redirect_to @article
	end

	private # Todo lo que este por debajo de PRIVATE son metodos privados de la clase.

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover,:categories,:markup_body)
	end
	
end