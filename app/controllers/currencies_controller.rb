class CurrenciesController < ApplicationController
  before_filter :fetch_currencies_for_user, :only => [:index, :collect_all, :progress]
  # GET /currencies
  # GET /currencies.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
    end
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.for_user(current_user).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end

  # POST /currencies/collect_all
  # POST /currencies/collect_all.json
  def collect_all
    visits = []
    if params[:currencies].present?
      @currencies.not_collected.where(:code => params[:currencies]).each do |currency|
        visits << current_user.visit_country(currency.country) if currency.country
      end
    end
    respond_to do |format|
      format.html { redirect_to countries_path }
      format.json { render :json => visits.to_json(:methods => :date, :only => [:date]) }
    end
  end

  # GET /currencies/progress
  def progress
    render :json => @currencies.collected.order_by_visit_date.to_json(:methods => :date, :only => [:date])
  end

  protected

    def fetch_currencies_for_user
      @currencies = Currency.for_user(current_user)
    end

end