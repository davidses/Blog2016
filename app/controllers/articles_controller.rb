# --------------------- CONTROLADOR --------------------------

class ArticlesController < ApplicationController
	# Esto es un callback
	before_action :authenticate_user!, only: [:create, :new]
	before_action :set_article, except: [:index, :new, :create]


	# GET y el path /articles
	def index
		# Devuelve todos los registros
		@articles = Article.all
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
	end

	# GET /articles/new
	def new
		@article = Article.new
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
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def edit
		# REFACTORIZADO EN EL CALLBACK SET_ARTICLE
	end

	private # Todo lo que este por debajo de PRIVATE son metodos privados de la clase.

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:body)
	end
	
end