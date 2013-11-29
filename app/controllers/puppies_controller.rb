class PuppiesController < ApplicationController
  before_action :set_puppy, only: [:show, :edit, :update, :destroy]

  # GET /puppies
  # GET /puppies.json
  def index
    @puppies = Puppy.all.sample(2)
  end

  # GET /standings
  def standings
    @puppies = Puppy.all.sort_by! {|a| -a.rating}
  end

  # GET /puppies/1
  # GET /puppies/1.json
  def show
  end

  # GET /puppies/new
  def new
    @puppy = Puppy.new
  end

  # POST /score
  def score
    @chosen = Puppy.find_by_id(params[:chosen])
    @notchosen = Puppy.find_by_id(params[:notchosen])

    # implementation of Elo rating algorithm (http://en.wikipedia.org/wiki/Elo_rating_system#Theory)
    @E_a = 1.0/(1.0 + 10.0 ** ((@notchosen.rating-@chosen.rating)/400.0))
    @E_b = 1.0/(1.0 + 10.0 ** ((@chosen.rating-@notchosen.rating)/400.0))
    @chosen.rating = @chosen.rating + 32.0 * (1 - @E_a)
    @notchosen.rating = @notchosen.rating + 32.0 * (0 - @E_b)
    @chosen.save
    @notchosen.save

    redirect_to('/')
  end

  # GET /puppies/1/edit
  def edit

  end

  def more
    # no need for anything here yet
  end

  # POST /puppies
  # POST /puppies.json
  def create
    (0..params[:num].to_i-1).each do
      @puppy = Puppy.create()
    end

    redirect_to('/')
  end

  # PATCH/PUT /puppies/1
  # PATCH/PUT /puppies/1.json
  def update
    respond_to do |format|
      if @puppy.update(puppy_params)
        format.html { redirect_to @puppy, notice: 'Puppy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @puppy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puppies/1
  # DELETE /puppies/1.json
  def destroy
    @puppy.destroy
    respond_to do |format|
      format.html { redirect_to puppies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puppy
      @puppy = Puppy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puppy_params
      params.require(:puppy).permit(:path, :rating)
    end
end
