class CountriesController < ApplicationController
  before_filter :fetch_country, :only => [:show, :edit, :update]
  before_filter :fetch_country_for_user, :only => [:show, :visit]

  # GET /countries
  # GET /countries.xml
  def index
    @countries = Country.for_user(current_user)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country }
    end
  end

  # GET /countries/1/edit
  def edit
  end

  # POST /countries
  # POST /countries.xml
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to(@country, :notice => 'Country was successfully created.') }
        format.xml  { render :xml => @country, :status => :created, :location => @country }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /countries/1
  # PUT /countries/1.xml
  def update
    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to(@country, :notice => 'Country was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /countries/1/visit
  def visit
    if @country.visited?
      redirect_to(@country, :notice => 'Country has been already visited.')
    else
      current_user.visits.create(:country_id => @country.code)
      redirect_to(@country, :notice => 'Country was successfully visited.')
    end
  end

  private
    def fetch_country
      @country = Country.find(params[:id])
    end

    def fetch_country_for_user
      @country = Country.for_user(current_user).find(params[:id])
    end
end