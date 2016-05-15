# --------------------- CONTROLADOR --------------------------

class ArticlesController < ApplicationController

	# GET y el path /articles
	def index
		# Devuelve todos los registros
		@articles = Article.all
	end

	# GET /articles/:id
	def show
		# devuelve uno o varios articulos segun lo pasado en el parametro
		# FIND devuelve el primer registro que cumpla la condicion (solo uno)
		@article = Article.find(params[:id])
		#  WHERE devuelve varios registros que cumplan la condicion.
		# Article.where("id = ? OR body = ?",params[:id],params[:body])
		# where NOT devuelve todos menos el pasado por parametro
		# Article.where.not("id = ?",params[:id])
	end

	# GET /articles/new
	def new
		@article = Article.new
	end

	def destroy 
		@article = Article.find(params[:id])
		@article.destroy # Elimina el registro de la BD.
		redirect_to articles_path
	end

	def update
		# @article.update_attribute({title: "Nuevo titulo"})
	end

	#POST /articles
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def edit
		@article = Article.find(params[:id])
	end


	private # Todo lo que este por debajo de PRIVATE son metodos privados de la clase.

	def article_params
		params.require(:article).permit(:title,:body)
	end
	
end